package org.phenopackets.coreig.tools.command.cl;

import java.util.concurrent.Callable;

import org.hl7.fhir.instance.model.api.IIdType;
import org.hl7.fhir.r4.model.Annotation;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.DiagnosticReport;
import org.hl7.fhir.r4.model.DiagnosticReport.DiagnosticReportStatus;
import org.hl7.fhir.r4.model.DocumentReference;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.Observation.ObservationStatus;
import org.hl7.fhir.r4.model.OperationOutcome;
import org.hl7.fhir.r4.model.OperationOutcome.IssueSeverity;
import org.hl7.fhir.r4.model.OperationOutcome.OperationOutcomeIssueComponent;
import org.hl7.fhir.r4.model.Parameters;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Reference;
import org.hl7.fhir.r4.model.Resource;
import org.hl7.fhir.r4.model.ResourceType;
import org.hl7.fhir.r4.model.ServiceRequest;
import org.hl7.fhir.r4.model.ServiceRequest.ServiceRequestIntent;
import org.hl7.fhir.r4.model.ServiceRequest.ServiceRequestStatus;
import org.hl7.fhir.r4.model.Specimen;
import org.hl7.fhir.r4.model.UriType;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.gclient.ICriterion;
import ca.uhn.fhir.rest.gclient.ReferenceClientParam;
import ca.uhn.fhir.rest.gclient.TokenClientParam;
import ca.uhn.fhir.rest.gclient.UriClientParam;
import ca.uhn.fhir.rest.server.exceptions.PreconditionFailedException;

public class ClinicalUsecase implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(ClinicalUsecase.class);

	private MainCommand main;

	private Patient createdPatient;

	private Bundle phenopacketData;
	private Bundle createdPhenopacketBundle;

	private Specimen createdSpecimen;

	private ServiceRequest createdServiceRequest;

	private Bundle labRequestSearchResult;

	private Observation exomeObservation;

	private DiagnosticReport exomeReport;

	private ServiceRequest completedServiceRequest;

	public ClinicalUsecase(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		/*-
		 * This is an overview of the implementation of the use case described at 
		 * https://phenopackets-analysis.readthedocs.io/en/latest/usecases-driver.html#id3
		 * 
		 * 
		 * 1. A patient is created for the use case. The patient's data is from 
		 * /core-ig/data/cl-data/Patient-patient-data.xml * The "sex" is captured as 
		 * administrative gender but it is also captured as an XX Observation as 
		 * described below.
		 * 
		 * 2. The hand written Bundle located at 
		 * /core-ig/data/cl-data/Bundle-phenopacket.xml is loaded. This Bundle contains 
		 * a DocumentReference to hold the base64 encoded phenopacket JSON from file 
		 * /core-ig/data/native-pp/usecase-2-phenopacket.json. It also contains 
		 * Observation based representations of the phenotypes, age, and sex as XX 
		 * observation,
		 * 
		 * 3. The Bundle is submitted as a "collection" bundle. This means that resource 
		 * entries as saved with the bundle and not created on the sever. However, the Bundle 
		 * file also contains the necessary "request" elements to allow the Bundle to be 
		 * submitted with a "transaction" mode to actually create the resources in the bundle 
		 * 
		 * One advantage of the "collection" approach is that the FHIR server is not polluted with 
		 * Observations or other resource instances that represent the phenopacket but the 
		 * Representations of those resources are saved in the "collection" bundle to be 
		 * used as needed by clients. The DocumentReference in the bundle also holds 
		 * the full native phenopacket JSON representation.
		 * 
		 * 4. A Bundle has a "link" element to link an element to something else. In this example 
		 * the Bundle is linked with "about" to the patient as a way to specify the relationship 
		 * between the phenopacket and the patient.
		 * 
		 * 5. A ServiceRequest and a Specimen created, linked to Patient, with the phenopacket 
		 * Bundle as supportingInfo.
		 * 
		 * 6. The lab searches for ServiceRequests that have supportingInfo to a Bundle tagged 
		 * with "bundle-type-phenopacket", status active, and subject our patient.
		 * 
		 * This needed a custom SearchParameter defined in the IG. 
		 * 
		 * 7. The lab processes the SerivceRequests to extract the phenopacket information. 
		 * It does this by finding age, the karyotypic sex, and the phenotypes. For demonstration 
		 * purposes the phenopacket Bundle contains a non conforming phenotype. The lab 
		 * performs validation on each phenotype to check if it complies with the IG profile 
		 * and marks the ones with errors.
		 * 
		 * An Observation and a DiagnosticReport are created for the results. These entries are 
		 * simply text valued results based on the use case to simplify the demo. These resource 
		 * instances are linked to the ServiceRequest. The ServiceRequest is completed and 
		 * updated on the server. 
		 * 
		 * 8. Another client retrieves the lab results by querying for Observation and 
		 * DiagnosticReport that are based on the Service request.
		 * 
		 * 
		 * 
		 */

		// ===================================================================

		/*
		 * We're hard coding the patient in this demo. In a real interaction this
		 * patient will be looked up in the target system before the later steps.
		 */
		main.info("", true, logger);
		main.info("=============== Creating the patient for this demo ===================" + "", true, logger);
		createPatient();
		main.info(createdPatient.getId() + " created", true, logger);

		/*
		 * Next we will read the Bundle that stands for the phenopacket in our use case.
		 * This bundle is read from: /core-ig/data/cl-data/Bundle-phenopacket.xml
		 * 
		 */
		main.info("", true, logger);
		main.info(
				"============== Reading phenopacket bundle from: /core-ig/data/cl-data/Bundle-phenopacket.xml ===============",
				true, logger);
		readPhenopacketBundle();

		/*
		 * Submit bundle as a "collection" Bundle. A collection bundle can contain
		 * representation of resources but the resources are not actually instantiated
		 * on the server as part of creating the Bundle instance. So, the information
		 * about the bundled resources is in the Bundle instance but there are no
		 * resource instances.
		 */
		main.info("", true, logger);
		main.info("================ Creating the phenopacket bundle as a collection on the server =============", true,
				logger);
		submitAsCollection();
		main.info("Phenopacket collection Bundle " + createdPhenopacketBundle.getId() + " created...", true, logger);

		/*
		 * At this point we should have a "collection" Bundle for the phenopacket on the
		 * server but it is not connected to the patient in any way. Also, Bundle
		 * doesn't have the usual patient/subject link to Patient but it does have a
		 * general "link" relationship that is meant to be used the usual REST way.
		 * 
		 * The "about" link relationship is probably the best choice to link the Bundle
		 * to our patient. The "link" field is not a standard search parameter that can
		 * be used to find phenopacket bundles about a patient but a custom search
		 * parameter can be defined later if this is our final choice for linking a
		 * "collection" bundle to a patient. Also, keep in mind that Bundle doesnt' have
		 * the usual extension field since it extends Resource rather than
		 * DomainResource. This could be an argument in favor of using the Composition
		 * resource instead of Bundle.
		 */
		main.info("", true, logger);
		main.info(
				"==================  Linking collection bundle to patient with the \"about\" relationship. ============",
				true, logger);
		linkCollectionToPatient();
		main.info("Updated PP collection bundel to: " + createdPhenopacketBundle.getIdElement().getId(), true, logger);

		/*
		 * Now we'll submit a lab request and use the phenopacket Bundle as supporting
		 * info.
		 */
		main.info("", true, logger);
		main.info("==================  Submitting exom request  ==========================", true, logger);
		submitExomRequest();
		main.info("Created ServiceRequest: " + createdServiceRequest.getId(), true, logger);

		/*
		 * A lab finding active requests for our patient, active, and with supporting
		 * information that is a Bundle tagged as a PP bundle.
		 */
		main.info("", true, logger);
		main.info("================== Lab searching for patient's requests =============", true, logger);
		findLabRequests();

		/*
		 * This is just for demo purposes. The lab will: 1) iterate through the
		 * ServiceRequest instances from previous search, 2) find the first one
		 * requesting the exome analysis (by code), 3) lookup a supportingInfo Bundle
		 * that is a phenopacket, 4) iterate through the Observation instances, 5) for
		 * each observation instance that conforms to the phenotype abnormality profile
		 * in the Core IG, the phenotype will be reported to show that the lab was able
		 * to find the phenotype, 5) and finally will create an Observation and
		 * DiagnosticReport that will stand for the results of the exome analysis for
		 * demo purposes. A real exome analysis reporting example will be much more
		 * detailed, and likely be based on
		 * http://hl7.org/fhir/uv/genomics-reporting/index.html
		 */
		main.info("", true, logger);
		main.info("================= Lab processing ServiceRequests =================", true, logger);
		labPerformingExomeAnalysis();

		/*
		 * Now we'll retrieve the exome analysis results. In a real situation, the
		 * client will find relevant ServiceRequest first and from there will find
		 * results based on that request. For this demo we already have the
		 * ServiceRequest instance held in a variable and we'll use it to simplify the
		 * demo.
		 */

		main.info("", true, logger);
		main.info("================= Retrieving exome analysis results ====================", true, logger);
		obtainExomeResults();

		System.out.println("");
		return null;
	}

	private void createPatient() {
		Resource r = main.loadResource("../../data/cl-data/Patient-patient-data.xml");
		MethodOutcome mo = main.getClient().create().resource(r).execute();
		writeStep("createPatient");
		createdPatient = (Patient) mo.getResource();
	}

	private void readPhenopacketBundle() {
		phenopacketData = (Bundle) main.loadResource("../../data/cl-data/Bundle-phenopacket.xml");
	}

	private void submitAsCollection() {
		MethodOutcome mo = main.getClient().create().resource(phenopacketData).execute();
		writeStep("createPhenopacketBundleCollection");
		createdPhenopacketBundle = (Bundle) mo.getResource();
	}

	private void linkCollectionToPatient() {
		createdPhenopacketBundle.addLink().setRelation("about")
				.setUrl("Patient/" + createdPatient.getIdElement().getIdPart());
		MethodOutcome mo = main.getClient().update().resource(createdPhenopacketBundle).execute();
		writeStep("linkPhenopacketBundleCollection");
		createdPhenopacketBundle = (Bundle) mo.getResource();

	}

	private void submitExomRequest() {
		createdServiceRequest = new ServiceRequest();
		createdServiceRequest.setStatus(ServiceRequestStatus.ACTIVE);
		createdServiceRequest.setSubject(new Reference(createdPatient));
		createdServiceRequest.setIntent(ServiceRequestIntent.ORIGINALORDER);
		createdServiceRequest.getCode().addCoding().setSystem("http://loinc.org").setCode("86205-2")
				.setDisplay("Whole exome sequence analysis in Blood or Tissue by Molecular genetics method");
		createdServiceRequest.addSupportingInfo(new Reference(createdPhenopacketBundle));
		createdServiceRequest.getMeta().addTag().setSystem("http://github.com/phenopackets/core-ig/ig-tools/tag")
				.setCode("clinical-usecase");

		createdSpecimen = new Specimen();
		createdSpecimen.setSubject(new Reference(createdPatient));
		// just an example, from: https://www.hl7.org/fhir/v2/0487/index.html
		createdSpecimen.getType().addCoding().setSystem("http://terminology.hl7.org/CodeSystem/v2-0487").setCode("BLD");

		MethodOutcome mo = main.getClient().create().resource(createdSpecimen).execute();
		writeStep("createBloodSpecimen");
		createdSpecimen = (Specimen) mo.getResource();

		// now specimen has an id. we assign a reference to it in specimen
		createdServiceRequest.getSpecimen().add(new Reference(createdSpecimen));
		mo = main.getClient().create().resource(createdServiceRequest).execute();
		writeStep("createServiceRequest");
		createdServiceRequest = (ServiceRequest) mo.getResource();

	}

	private void findLabRequests() {
		// This uses the Core IG SearchParameter:
		// http://phenopackets.org/core-ig/master/SearchParameter-service-request-supporting-info.html
		ICriterion<TokenClientParam> ppSupportingParam = new TokenClientParam("supporting-info:Bundle._tag").exactly()
				.systemAndCode("http://github.com/phenopackets/core-ig/ig-tools/tag", "bundle-type-phenopacket");

		// this is to only find active requests
		ICriterion<TokenClientParam> activeRequestParam = new TokenClientParam("status").exactly().code("active");

		// for our patient
		ICriterion<ReferenceClientParam> subjectParam = new ReferenceClientParam("subject").hasAnyOfIds(
				createdPatient.getIdElement().getResourceType() + "/" + createdPatient.getIdElement().getIdPart());

		labRequestSearchResult = (Bundle) main.getClient().search().forResource(ServiceRequest.class)
				.and(ppSupportingParam).and(activeRequestParam).and(subjectParam).execute();
		writeStep("findingServiceRequestsWithPhenopacketBundle");

	}

	private void labPerformingExomeAnalysis() {
		ICriterion<UriClientParam> profileParam = new UriClientParam("profile").matches()
				.value("http://github.com/phenopackets/core-ig/StructureDefinition/observation-phenotypic-abnormality");

		for (BundleEntryComponent entry : labRequestSearchResult.getEntry()) {
			Resource resource = entry.getResource();
			if (resource != null && ServiceRequest.class.isInstance(resource)) {
				ServiceRequest request = (ServiceRequest) resource;
				// filter the non exome ones
				if (!request.getCode().hasCoding("http://loinc.org", "86205-2"))
					continue;

				// iterate over supporting information to find a possible phenopacket bundle
				String phenopacketOriginalJson = null;
				StringBuilder valideSb = new StringBuilder("Phenotypes:\n");
				StringBuilder invalideSb = new StringBuilder("Invalide phenotypes:\n");
				String age = "Age: ";
				String ks = "Karyotypic sex: ";

				for (Reference supporting : request.getSupportingInfo()) {
					IIdType reference = supporting.getReferenceElement();
					String resourceType = reference.getResourceType();
					if (resourceType.equals(ResourceType.Bundle.toString())) {
						// need to retrieve the supporting resource from the server
						Bundle ppBundle = main.getClient().read().resource(Bundle.class).withId(reference.getIdPart())
								.execute();
						writeStep("labSupportingInfoRead");

						for (BundleEntryComponent ppEntry : ppBundle.getEntry()) {
							Resource ppResource = ppEntry.getResource();
							if (Observation.class.isInstance(ppResource)) {
								// an observation instance in the bundle
								Observation ppObservation = (Observation) ppResource;

								// if not a phenotype Observation by category, skip
								if (Utils.hasCategory(ppObservation.getCategory(), "phenotype")) {

									// we need this copy for sending for validation by the server. There might be a
									// better way for doing this but this works.

									// is adds the phenotype profile to the Observation instance if it's not already
									// added. This is needed by the validate operation few lines below so the server
									// knows to also validate based on this profile and not just the base
									// Observation type.
									Observation ppObservationCopy = ppObservation.copy();
									if (!ppObservationCopy.getMeta().hasProfile(
											"http://github.com/phenopackets/core-ig/StructureDefinition/observation-phenotypic-abnormality")) {
										ppObservationCopy.getMeta().addProfile(
												"http://github.com/phenopackets/core-ig/StructureDefinition/observation-phenotypic-abnormality");
									}

									OperationOutcome validationOutcome = null;
									boolean failed = false;
									try {
										validationOutcome = (OperationOutcome) main.getClient().operation()
												.onType(Observation.class).named("validate")
												.withParameter(Parameters.class, "profile", new UriType(
														"http://github.com/phenopackets/core-ig/StructureDefinition/observation-phenotypic-abnormality"))
												.andParameter("resource", ppObservationCopy).execute()
												.getParameterFirstRep().getResource();
									} catch (PreconditionFailedException e) {
										validationOutcome = (OperationOutcome) e.getOperationOutcome();
										failed = true;
									}
									writeStep("labValidatingPhenotype");

									if (failed) {
										invalideSb.append("\t"
												+ ppObservationCopy.getCode().getCodingFirstRep().getCode() + " "
												+ ppObservationCopy.getCode().getCodingFirstRep().getDisplay() + "\n");

										for (OperationOutcomeIssueComponent issue : validationOutcome.getIssue()) {
											if (issue.getSeverity().equals(IssueSeverity.ERROR)) {
												invalideSb.append("\t\tError: " + issue.getDiagnostics() + "\n");
											}
										}

									} else {
										valideSb.append("\t" + ppObservationCopy.getCode().getCodingFirstRep().getCode()
												+ " " + ppObservationCopy.getCode().getCodingFirstRep().getDisplay()
												+ "\n");

									}
								} else {
									if (ppObservation.getCode().hasCoding("http://snomed.info/sct", "424144002")) {
										age = age
												+ (ppObservation.getValueQuantity().getValue().doubleValue() / 365.25);
									} else if (ppObservation.getCode().hasCoding("http://purl.obolibrary.org/obo/GSSO",
											"GSSO:000113")) {
										ks = ks + ppObservation.getValueCodeableConcept().getCodingFirstRep().getCode();
									}
								}

							} else if (DocumentReference.class.isInstance(ppResource)) {
								// the document reference for the original phenopacket JSON
								DocumentReference dr = (DocumentReference) ppResource;
								byte[] data = dr.getContentFirstRep().getAttachment().getData();

								phenopacketOriginalJson = new String(data);

							}
						}
					}
				}

				main.info(age, true, logger);
				main.info(ks, true, logger);
				main.info(valideSb.toString(), true, logger);
				main.info(invalideSb.toString(), true, logger);

				main.info("Original phenopacket JSON:", true, logger);
				main.info(phenopacketOriginalJson, true, logger);

			}

		}

		// now create an Observation and DiagnosticReport to stand for results, and
		// complete the ServiceRequest.

		// Observation
		exomeObservation = new Observation();
		exomeObservation.setStatus(ObservationStatus.FINAL).addBasedOn(new Reference(createdServiceRequest)).getCode()
				.addCoding().setSystem("http://loinc.org").setCode("86205-2");
		exomeObservation.getValueStringType().setValue("NKX6-2 mutation (GRCh37, chr:10: 134599256CG>C)");
		exomeObservation.setSubject(new Reference(createdPatient)).setSpecimen(new Reference(createdSpecimen)).getNote()
				.add(new Annotation().setText("Some exome analysis notes."));

		main.info("Lab creating exome Observation", true, logger);
		MethodOutcome mo = main.getClient().create().resource(exomeObservation).execute();
		exomeObservation = (Observation) mo.getResource();
		writeStep("labCreateExomeObservation");
		main.info(exomeObservation.getId() + " created.", true, logger);

		// DiagnosticReport
		exomeReport = new DiagnosticReport().setSubject(new Reference(createdPatient))
				.addBasedOn(new Reference(createdServiceRequest)).setStatus(DiagnosticReportStatus.FINAL)
				.addResult(new Reference(exomeObservation))
				.setConclusion(
						"Spastic ataxia 8, autosomal recessive, with hypomyelinating leukodystrophy (OMIM:617560) https://www.omim.org/clinicalSynopsis/617560 ")
				.addSpecimen(new Reference(createdSpecimen));
		exomeReport.getCode().addCoding().setSystem("http://loinc.org").setCode("86205-2");

		main.info("Lab creating exome DiagnosticReport", true, logger);
		mo = main.getClient().create().resource(exomeReport).execute();
		exomeReport = (DiagnosticReport) mo.getResource();
		writeStep("labCreateExomeDiagnosticReport");
		main.info(exomeReport.getId() + " created.", true, logger);

		// complete ServiceRequest
		completedServiceRequest = createdServiceRequest.copy();
		completedServiceRequest.setStatus(ServiceRequestStatus.COMPLETED);

		main.info("Lab updating ServiceRequest to completed.", true, logger);
		mo = main.getClient().update().resource(completedServiceRequest).execute();
		completedServiceRequest = (ServiceRequest) mo.getResource();
		writeStep("labUpdateServiceRequestCompleted");
		main.info(completedServiceRequest.getId() + " updated.", true, logger);

	}

	private void obtainExomeResults() {
		ICriterion<ReferenceClientParam> basedOnParam = new ReferenceClientParam("based-on")
				.hasId(createdServiceRequest.getIdElement());
		Bundle searchBundle = (Bundle) main.getClient().search().forResource(Observation.class).and(basedOnParam)
				.execute();
		writeStep("obtainingObservationResutls");
		for (BundleEntryComponent e : searchBundle.getEntry()) {
			Observation o = (Observation) e.getResource();
			main.info("Obs: " + o.getValueStringType().getValue() + ", notes: " + o.getNoteFirstRep().getText(), true,
					logger);
		}

		searchBundle = (Bundle) main.getClient().search().forResource(DiagnosticReport.class).and(basedOnParam)
				.execute();
		writeStep("obtainingDiagnositcReportResutls");
		for (BundleEntryComponent e : searchBundle.getEntry()) {
			DiagnosticReport dr = (DiagnosticReport) e.getResource();
			main.info("DiagnositcReport: " + dr.getConclusion(), true, logger);
		}
	}

	private void writeStep(String step) {
		Utils.saveRequestResponse(main, logger, step);
	}

}
