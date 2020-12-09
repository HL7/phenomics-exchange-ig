package org.phenopackets.coreig.tools.command;

import java.io.IOException;
import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
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
import org.hl7.fhir.r4.model.DomainResource;
import org.hl7.fhir.r4.model.ImplementationGuide;
import org.hl7.fhir.r4.model.ImplementationGuide.ImplementationGuideDefinitionResourceComponent;
import org.hl7.fhir.r4.model.MetadataResource;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r4.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.Resource;
import org.hl7.fhir.r4.model.StringType;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.gclient.ICriterion;
import ca.uhn.fhir.rest.gclient.StringClientParam;
import ca.uhn.fhir.rest.gclient.TokenClientParam;

/**
 * @author essaids
 *
 */
public class LoadConformanceCommand implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(LoadConformanceCommand.class);

	private final MainCommand main;

	private final Map<String, Set<Reference>> refTypeMap = new HashMap<>();
	private final List<ImplementationGuideDefinitionResourceComponent> examples = new ArrayList<>();
	private ImplementationGuide ig;

	public LoadConformanceCommand(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		ig = main.getIg();
		main.header("Loading IG: " + ig.getUrl() + " to server: " + main.getServerUrl(), logger);

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
					main.info("Ignoring reference: " + rc.getReference().getReference(), true, logger);
					toRemove.add(rc);
				}
			}

		}

		// remove any references we haven't dealt with so far in terms of loading them
		// to the server
		if (toRemove.size() > 0) {
			main.info("Not loading the following resources...", true, logger);
			for (ImplementationGuideDefinitionResourceComponent resource : toRemove) {
				main.info(resource.getId(), true, logger);
			}
		}
		ig.getDefinition().getResource().removeAll(toRemove);

		loadResrouces(refTypeMap.get("CodeSystem"));
		loadResrouces(refTypeMap.get("ValueSet"));
		loadResrouces(refTypeMap.get("StructureDefinition"));
		loadExamples();
		loadUpdate(ig, true);

		return null;
	}

	private void loadResrouces(Set<Reference> references) {
		for (Reference reference : references) {
			String[] parts = reference.getReference().split("/");
			MetadataResource updatedMetadata = loadUpdate(main.loadMetadata(parts[0] + "-" + parts[1] + ".xml"), false);
			if (updatedMetadata != null) {
				String id = updatedMetadata.getIdElement().asStringValue();
				main.debug("Updating IG reference from:" + reference.getReference() + " to:" + id, true, logger);
				reference.setReferenceElement(new StringType(id));
			}
		}
	}

	/**
	 * the overall goal here is to load the examples both with a profile under
	 * .meta.profile, and without a profile.
	 * 
	 * if the ig specifies the profile for the example, we make sure we add that
	 * profile to one instance of the example if the example already has the profile
	 * indicated by the ig, we load a copy of it without that profile
	 * 
	 * we'll add a reference to the ig instance for the additional copies loaded,
	 * and tag that reference with a tooling extension.
	 */
	private void loadExamples() {
		List<ImplementationGuideDefinitionResourceComponent> addedComponents = new ArrayList<>();
		for (ImplementationGuideDefinitionResourceComponent rc : examples) {
			String ref = rc.getReference().getReference();
			String refProfile = rc.getExampleCanonicalType().asStringValue();

			String[] refParts = ref.split("/");
			DomainResource example = (DomainResource) main.loadResource(refParts[0] + "-" + refParts[1] + ".xml");
			main.header("\n", logger);
			main.header("Loading example: " + example.getId(), logger);

			// search if already loaded
			DomainResource existing = null;
			DomainResource existingGenerated = null;

			TokenClientParam tokenParam = new TokenClientParam("_tag");
			ICriterion<TokenClientParam> tokenCriterion = tokenParam.exactly().systemAndCode(Utils.ID_TAG_IRI, ref);
			Bundle bundle = (Bundle) main.getClient().search().forResource(example.getClass()).and(tokenCriterion)
					.execute();

			for (BundleEntryComponent entry : bundle.getEntry()) {
				DomainResource resource = (DomainResource) entry.getResource();
				if (resource.getMeta().getTag(Utils.TAG_URI, Utils.TAG_GENERATED) != null) {
					existingGenerated = resource;
					main.info("Found existing generated: " + existingGenerated.getId(), true, logger);
				} else {
					existing = resource;
					main.info("Found existing: " + existing.getId(), true, logger);
				}
			}

			// create or update original
			DomainResource updated = null;

			// without profile first
			DomainResource exampleCopy = example.copy();
			Utils.tagResourceId(exampleCopy, example);
			MethodOutcome methodOutcome = null;
			boolean created = false;
			if (existing != null) {
				exampleCopy.setId(existing.getId());
				methodOutcome = main.getClient().update().resource(exampleCopy).execute();
			} else {
				methodOutcome = main.getClient().create().resource(exampleCopy).execute();
				created = true;
			}
			updated = (DomainResource) methodOutcome.getResource();
			if (created) {
				main.info("Created: " + updated.getId(), true, logger);
			} else {
				main.info("Updated: " + updated.getId(), true, logger);
			}
			Utils.checkOutcome(main, (OperationOutcome) methodOutcome.getOperationOutcome(), logger);
			rc.getReference().setReference(updated.getIdElement().asStringValue());

			Utils.validate(main, updated, refProfile, logger);

			// if the example doesn't already have the profile, and we have a profile, we'll
			// add another example instance with the profile
			DomainResource updatedGenerated = null;
			if (refProfile != null && !updated.getMeta().hasProfile(refProfile)) {
				// we'll add the profile to .meta.profile and create/update
				DomainResource generatedCopy = example.copy();
				generatedCopy.getMeta().addProfile(refProfile);
				generatedCopy.getMeta().addTag(Utils.TAG_URI, "generated", "generated");
				Utils.tagResourceId(generatedCopy, example);
				MethodOutcome mo = null;
				if (existingGenerated != null) {
					generatedCopy.setId(existingGenerated.getId());
					mo = main.getClient().update().resource(generatedCopy).execute();
					main.info("Updated generated example: " + ((Resource) mo.getResource()).getId(), true, logger);
				} else {
					mo = main.getClient().create().resource(generatedCopy).execute();
					main.info("Created generated example: " + ((Resource) mo.getResource()).getId(), true, logger);
				}
				Utils.checkOutcome(main, (OperationOutcome) mo.getOperationOutcome(), logger);
				generatedCopy = (DomainResource) mo.getResource();
				Reference r = new Reference(generatedCopy);
				ImplementationGuideDefinitionResourceComponent rcGenerated = new ImplementationGuideDefinitionResourceComponent();
				rcGenerated.getReference().setReference(generatedCopy.getId());
				rcGenerated.addExtension(Utils.TAG_URI, new StringType("generated"));
				addedComponents.add(rcGenerated);

			} else {
				// skip but delete any existing generated instance from the past.
				if (existingGenerated != null) {
					main.info("Deleting no longer needed existing generated example: " + existingGenerated.getId(),
							true, logger);
					MethodOutcome execute = main.getClient().delete().resource(existingGenerated).execute();
					Utils.checkOutcome(main, (OperationOutcome) execute.getOperationOutcome(), logger);
				}
			}

			// //
			// // now if we have a profile for the example, update or create
			// if (refProfile != null) {
			// exampleCopy = example.copy();
			// Utils.tagResourceId(exampleCopy, example);
			// if (!exampleCopy.getMeta().hasProfile(refProfile)) {
			// exampleCopy.getMeta().addProfile(refProfile);
			// }
			// if (existingGenerated != null) {
			// exampleCopy.setId(existingGenerated.getId());
			// methodOutcome = main.getClient().update().resource(exampleCopy).execute();
			// } else {
			// methodOutcome = main.getClient().create().resource(exampleCopy).execute();
			// }
			// updatedGenerated = (DomainResource) methodOutcome.getResource();
			// }
			//
			// // TODO: validation and reporting
		}

		ig.getDefinition().getResource().addAll(addedComponents);

	}

	private MetadataResource loadUpdate(MetadataResource resource, boolean deleteExisting) {
		main.header("\n", logger);
		main.header("Loading: " + resource.getId() + ", url:" + resource.getUrl(), logger);
		MetadataResource resourceCopy = resource.copy();
		Utils.tagResourceId(resourceCopy, resource);

		IGenericClient client = main.getClient();
		String url = resource.getUrl();
		Bundle bundle = (Bundle) client.search().forResource(resource.getClass())
				.and(new StringClientParam("url").matchesExactly().value(url)).execute();



		List<BundleEntryComponent> entries = bundle.getEntry();
		MetadataResource existingResource = null;

		if (entries.size() > 1) {
			String json = main.getJsonParser().encodeResourceToString(bundle);
			main.warn("Search returned: multiple bundle entries. Skippping. JSON:", true, logger);
			main.debug(json, true, logger);
			return null;

		} else if (entries.size() == 1) {
			existingResource = (MetadataResource) entries.get(0).getResource();
			main.info("Search returned: " + existingResource.getId(), true, logger);
		}

		if (deleteExisting && existingResource != null) {
			main.info("Deleting resource: " + existingResource.getId(), true, logger);
			main.getClient().delete().resource(existingResource).execute();
			existingResource = null;
		}

		Utils.logRequest(main, logger);
		Utils.logResponse(main, logger);
		
		MethodOutcome mo = null;

		if (existingResource == null) {
			main.info("Creating resource...", true, logger);
			mo = main.getClient().create().resource(resourceCopy).execute();
		} else {
			resourceCopy.setId(existingResource.getId());
			main.info("Updating resource: " + resourceCopy.getId(), true, logger);
			mo = main.getClient().update().resource(resourceCopy).execute();
		}

		Utils.checkOutcome(main, (OperationOutcome) mo.getOperationOutcome(), logger);

		MetadataResource mr = (MetadataResource) mo.getResource();

		Utils.validate(main, mr, null, logger);

		return (MetadataResource) mo.getResource();
	}
}
