package org.phenopackets.coreig.tools.command;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;

import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.ImplementationGuide;
import org.hl7.fhir.r4.model.ImplementationGuide.ImplementationGuideDefinitionResourceComponent;
import org.hl7.fhir.r4.model.MetadataResource;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r4.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.StringType;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.gclient.StringClientParam;

public class LoadConformanceCommand implements Callable<Void> {
	
	private static Logger logger = LoggerFactory.getLogger(LoadConformanceCommand.class);

	private final MainCommand main;

	private final Map<String, Set<Reference>> refTypeMap = new HashMap<>();
	private final List<ImplementationGuideDefinitionResourceComponent> examples = new ArrayList<>();
	private ImplementationGuide ig;
	private String igPrefix;
	private String tagSystem;
	

	public LoadConformanceCommand(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {
		
		ig = main.getIg();
		igPrefix = Utils.getIgPrefix(ig.getUrl());
		tagSystem = igPrefix+"/idtag";
		List<ImplementationGuideDefinitionResourceComponent> toRemove = new ArrayList<>();

		for (ImplementationGuideDefinitionResourceComponent rc : ig.getDefinition().getResource()) {

			if (rc.hasExample()) {
				examples.add(rc);
				continue;
			}

			Reference ref = rc.getReference();
			String[] refParts = ref.getReference().split("/");
			if (refParts.length == 2) {
				Set<Reference> list = refTypeMap.get(refParts[0]);
				if (list == null) {
					list = new HashSet<>();
					refTypeMap.put(refParts[0], list);
				}
				switch (refParts[0]) {
				case "CodeSystem":
				case "ValueSet":
				case "StructureDefinition":
					list.add(ref);
					break;
				default:
					toRemove.add(rc);
				}
			}

		}

		// remove any references we haven't dealth with so far in terms of loading them
		// to the server
		ig.getDefinition().getResource().removeAll(toRemove);

		loadResrouces(refTypeMap.get("CodeSystem"));
		loadResrouces(refTypeMap.get("ValueSet"));
		loadResrouces(refTypeMap.get("StructureDefinition"));
		loadExamples();
		loadUpdate(ig);

		return null;
	}

	private void loadExamples() {
		// TODO Auto-generated method stub

	}

	private void loadResrouces(Set<Reference> references) {
		for (Reference reference : references) {
			String[] parts = reference.getReference().split("/");
			MetadataResource updatedMetadata = loadUpdate(main.loadMetadata(parts[0] + "-" + parts[1] + ".xml"));
			String id = updatedMetadata.getIdElement().asStringValue();
			reference.setReferenceElement(new StringType(id));
		}
	}

	private MetadataResource loadUpdate(MetadataResource resource) {
		Utils.tagResourceId(resource, resource, tagSystem);
		main.info("Loading: " + resource.getResourceType().name() + "/" + resource.getId() + ", url:"
				+ resource.getUrl(), true, logger);
		IGenericClient client = main.getClient();
		String url = resource.getUrl();
		Bundle bundle = (Bundle) client.search().forResource(resource.getClass())
				.and(new StringClientParam("url").matchesExactly().value(url)).execute();

		List<BundleEntryComponent> entries = bundle.getEntry();
		MetadataResource existingResource = null;
		MethodOutcome crudOutcome = null;
		if (entries.size() > 1) {
			String json = main.getJsonParser().encodeResourceToString(bundle);
			main.warn("Search returned: multiple bundle entries. JSON:", true, logger);
			main.warn(json, true, logger);
			main.warn("Skipping loading this resource.", true, logger);
			return null;

		} else if (entries.size() == 1) {
			existingResource = (MetadataResource) entries.get(0).getResource();
			main.info("Search returned: " + existingResource.getResourceType() + "/" + existingResource.getId()
					+ ", revision: " + existingResource.getMeta().getVersionId(), true, logger);
			MetadataResource newResource = resource.copy();
			newResource.setId(existingResource.getId());
			crudOutcome = client.update().resource(newResource).execute();
		} else {
			main.info("Creating new resource", true, logger);
			crudOutcome = client.create().resource(resource).execute();
		}

		MetadataResource returnedResource = (MetadataResource) crudOutcome.getResource();
		if (returnedResource != null) {
			main.info("Response resource: " + returnedResource.getResourceType().name() + "/" + returnedResource.getId()
					+ ", revision: " + returnedResource.getMeta().getVersionId(), true, logger);

			OperationOutcome validateOutcome = (OperationOutcome) client.validate().resource(returnedResource).execute()
					.getOperationOutcome();
			main.info("Validate outcome issues:", true, logger);
			for (OperationOutcomeIssueComponent issueComp : validateOutcome.getIssue()) {
				IssueSeverity severity = issueComp.getSeverity();
				switch (severity) {
				case FATAL:
				case ERROR:
					main.error(severity.name() + ": code:" + issueComp.getCode(), false, logger);
					if (issueComp.getDetails() != null)
						main.error(", detail:" + issueComp.getDetails(), false, logger);
					main.info(", diagnostics:" + issueComp.getDiagnostics(), true, logger);
					break;
				default:

				}
			}
		}

		OperationOutcome outcome = (OperationOutcome) crudOutcome.getOperationOutcome();
		if (outcome != null) {
			main.info("CRUD outcome issues:", true, logger);
			for (OperationOutcomeIssueComponent issueComp : outcome.getIssue()) {
				IssueSeverity severity = issueComp.getSeverity();
				switch (severity) {
				case FATAL:
				case ERROR:
					main.info(severity.name() + ": code:" + issueComp.getCode(), false, logger);
					if (issueComp.getDetails() != null)
						main.info(", detail:" + issueComp.getDetails().getCoding().get(0).getCode(), false, logger);
					main.info(", diagnostics:" + issueComp.getDiagnostics(), true, logger);

					break;
				default:

				}
			}
		}
		main.info("", true, logger);
		return returnedResource;

	}
}
