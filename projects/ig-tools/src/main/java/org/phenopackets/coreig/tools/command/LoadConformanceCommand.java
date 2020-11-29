package org.phenopackets.coreig.tools.command;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.Callable;

import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.IdType;
import org.hl7.fhir.r4.model.ImplementationGuide;
import org.hl7.fhir.r4.model.ImplementationGuide.ImplementationGuideDefinitionComponent;
import org.hl7.fhir.r4.model.ImplementationGuide.ImplementationGuideDefinitionResourceComponent;
import org.hl7.fhir.r4.model.MetadataResource;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r4.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.StringType;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.gclient.StringClientParam;

public class LoadConformanceCommand implements Callable<Void> {

	private final MainCommand main;
	private final StringBuilder sb = new StringBuilder();

	private final Map<String, Set<Reference>> resources = new HashMap<>();

	public LoadConformanceCommand(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {
		ImplementationGuide ig = main.getIg();
		ImplementationGuideDefinitionComponent definition = ig.getDefinition();
		List<ImplementationGuideDefinitionResourceComponent> toRemove = new ArrayList<>();
		for (ImplementationGuideDefinitionResourceComponent rc : ig.getDefinition().getResource()) {
			Reference ref = rc.getReference();
			String[] reference = ref.getReference().split("/");
			if (reference.length == 2) {
				Set<Reference> list = resources.get(reference[0]);
				if (list == null) {
					list = new HashSet();
					resources.put(reference[0], list);
				}
				switch (reference[0]) {
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

		ig.getDefinition().getResource().removeAll(toRemove);

		loadResrouces(resources.get("CodeSystem"));
		loadResrouces(resources.get("ValueSet"));
		loadResrouces(resources.get("StructureDefinition"));
		loadUpdate(ig);

		System.out.println(sb.toString());
		return null;
	}

	private void loadResrouces(Set<Reference> references) {
		for (Reference reference : references) {
			String[] parts = reference.getReference().split("/");
			MetadataResource updatedMetadata = loadUpdate(main.loadMetadata(parts[0] + "-" + parts[1] + ".xml"));
			String id = updatedMetadata.getIdElement().asStringValue();
			reference.setReferenceElement(new StringType(id));
			IdType it = new IdType();

			System.out.println("debug");
		}
	}

	private MetadataResource loadUpdate(MetadataResource resource) {
		sb.append("Loading: ");
		sb.append(resource.getResourceType().name() + "/" + resource.getId() + ", url:" + resource.getUrl() + "\n");
		IGenericClient client = main.getClient();
		String url = resource.getUrl();
		Bundle bundle = (Bundle) client.search().forResource(resource.getClass())
				.and(new StringClientParam("url").matchesExactly().value(url)).execute();

		List<BundleEntryComponent> entries = bundle.getEntry();
		MetadataResource existingResource = null;
		MethodOutcome crudOutcome = null;
		if (entries.size() > 1) {
			String json = main.getJsonParser().encodeResourceToString(bundle);
			sb.append("Search returned: multiple bundle entries. JSON:\n");
			sb.append(json);
			sb.append("\nSkipping loading this resource\n\n");

		} else if (entries.size() == 1) {
			existingResource = (MetadataResource) entries.get(0).getResource();
			sb.append("Search returned: " + existingResource.getResourceType() + "/" + existingResource.getId()
					+ ", revision: " + existingResource.getMeta().getVersionId() + "\n");
			MetadataResource newResource = resource.copy();
			newResource.setId(existingResource.getId());
			crudOutcome = client.update().resource(newResource).execute();
		} else {
			sb.append("Creating new resource");
			crudOutcome = client.create().resource(resource).execute();
		}

		MetadataResource returnedResource = (MetadataResource) crudOutcome.getResource();
		if (returnedResource != null) {
			sb.append("Response resource: " + returnedResource.getResourceType().name() + "/" + returnedResource.getId()
					+ ", revision: " + returnedResource.getMeta().getVersionId());

			OperationOutcome validateOutcome = (OperationOutcome) client.validate().resource(returnedResource).execute()
					.getOperationOutcome();
			sb.append("Validate outcome issues:\n");
			for (OperationOutcomeIssueComponent issueComp : validateOutcome.getIssue()) {
				IssueSeverity severity = issueComp.getSeverity();
				switch (severity) {
				case FATAL:
				case ERROR:
					sb.append(severity.name() + ": code:" + issueComp.getCode());
					if (issueComp.getDetails() != null)
						sb.append(", detail:" + issueComp.getDetails());
					sb.append(", diagnostics:" + issueComp.getDiagnostics());
					sb.append("\n");
					break;
				default:

				}
			}
		}

		OperationOutcome outcome = (OperationOutcome) crudOutcome.getOperationOutcome();
		if (outcome != null) {
			sb.append("CRUD outcome issues:\n");
			for (OperationOutcomeIssueComponent issueComp : outcome.getIssue()) {
				IssueSeverity severity = issueComp.getSeverity();
				switch (severity) {
				case FATAL:
				case ERROR:
					sb.append(severity.name() + ": code:" + issueComp.getCode());
					if (issueComp.getDetails() != null)
						sb.append(", detail:" + issueComp.getDetails().getCoding().get(0).getCode());
					sb.append(", diagnostics:" + issueComp.getDiagnostics());
					sb.append("\n");
					break;
				default:

				}
			}
		}
		sb.append("\n");
		return returnedResource;

	}
}
