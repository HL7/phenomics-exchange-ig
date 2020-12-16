package org.phenopackets.coreig.tools.command.kf;

import java.util.HashSet;
import java.util.Set;
import java.util.concurrent.Callable;

import org.hl7.fhir.instance.model.api.IBaseBundle;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Condition;
import org.hl7.fhir.r4.model.Enumerations.AdministrativeGender;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.Patient;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.rest.gclient.CompositeClientParam;
import ca.uhn.fhir.rest.gclient.ICriterion;
import ca.uhn.fhir.rest.gclient.IParam;
import ca.uhn.fhir.rest.gclient.ReferenceClientParam;
import ca.uhn.fhir.rest.gclient.TokenClientParam;

public class KFUseCase implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(KFUseCase.class);

	private MainCommand main;

	public KFUseCase(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		/*-
		 * The implementation of this use case has the following steps:
		 * 
		 * 1. Data for two patients is loaded from the directory /core-ig/data/kf-data
		 * This data was provided by Kids First as example data that could be 
		 * returned by a query to a Kids First FHIR server. It is a workaround 
		 * for having to implement this test against their live system since their 
		 * system was behind a VPN connection for most of the duration of this project, 
		 * now requires proper authentication and authorization even though it is accessible 
		 * on the Internet, etc. These were technical barriers that we did not have the time
		 * or resources to implement for a relatively simple test scenario.
		 * 
		 * The is loaded by code found here: /ig-tools/src/main/java/org/phenopackets/coreig/tools/command/kf/KFLoadData.java
		 * 
		 * 2. Queries for Observation and Condition that match the query data found in the 
		 * first table here: https://phenopackets-analysis.readthedocs.io/en/latest/usecases-driver.html#use-case
		 * are made, the subject of those resources (i.e. Patient instances) are retrieved, 
		 * and the full set of Observation and Condition instances for those patients are 
		 * then retrieved and printed out to the screen as can be seen 
		 * in /ig-tools/savedMessages/kidsfirst-usecase/_screen-output.txt
		 * 
		 */

		// phenotype query parameters

		// gender

		ICriterion<TokenClientParam> femalParam = new TokenClientParam("subject:Patient.gender").exactly()
				.code(AdministrativeGender.FEMALE.toCode());

		// Abnormal Atrial Septum
		TokenClientParam atrialSeptumParam = new TokenClientParam("code");
		ICriterion<TokenClientParam> atrialSeptum = atrialSeptumParam.exactly()
				.systemAndCode("http://github.com/phenopackets/core-ig/CodeSystem/hpo", "HP:0011994");

		// Abnormal Pulmonary Valve
		// This parameter is skipped in the search since it will only return the same
		// patient
		// found with the condition search since we don't have a female patient in the
		// example data
		// that has both phenotypes.
		TokenClientParam pulmValveParam = new TokenClientParam("code");
		ICriterion<TokenClientParam> pulmValve = pulmValveParam.exactly()
				.systemAndCode("http://github.com/phenopackets/core-ig/CodeSystem/hpo", "HP:0001641");

		// the search request, without including the abnormal pulmonary valve phenotype.
		Bundle obsBundle = (Bundle) main.getClient().search().forResource(Observation.class).and(atrialSeptum)// .and(pulmValve)
																												// skipped
				.and(femalParam).execute();
		Utils.saveRequestResponse(main, logger, "searchByPhenotypeAndGender");

		Set<String> obsPatients = new HashSet<>();
		for (BundleEntryComponent e : obsBundle.getEntry()) {
			Observation obs = (Observation) e.getResource();
			String patientId = obs.getSubject().getReference();
			obsPatients.add(patientId);
		}

		main.info("", true, logger);
		main.info("Female patients with similar phenotypes: " + obsPatients, true, logger);
		showInfo(obsPatients);

		// condition query parameter

		// Atrial septal defect
		ICriterion<TokenClientParam> atrialSeptal = new TokenClientParam("code").exactly().systemAndCode("http://mondo",
				"MONDO:0006664");

		// condition search request
		Bundle condBundle = (Bundle) main.getClient().search().forResource(Condition.class).and(atrialSeptal).execute();
		Utils.saveRequestResponse(main, logger, "searchByCondition");

		Set<String> condPatients = new HashSet<>();
		for (BundleEntryComponent e : condBundle.getEntry()) {
			Condition cond = (Condition) e.getResource();
			String patientId = cond.getSubject().getReference();
			condPatients.add(patientId);
		}

		main.info("", true, logger);
		main.info("Female patients with similar conditions: " + condPatients, true, logger);
		showInfo(condPatients);

		return null;
	}

	private void showInfo(Set<String> patientRefs) {
		main.info("", true, logger);
		for (String patientRef : patientRefs) {
			main.info("Info for patient " + patientRef, true, logger);

			// get the patient instance by the reference
			Patient patient = (Patient) main.getClient().read().resource(Patient.class).withId(patientRef).execute();
			main.info("\tgender: " + patient.getGender(), true, logger);

			// observations for the patient
			Bundle obsBundle = (Bundle) main.getClient().search().forResource(Observation.class)
					.and(new ReferenceClientParam("subject").hasId(patientRef)).execute();
			Utils.saveRequestResponse(main, logger, "obssForPatient-" + patient.getIdElement().getIdPart());

			for (BundleEntryComponent e : obsBundle.getEntry()) {
				Observation obs = (Observation) e.getResource();
				for (Coding coding : obs.getCode().getCoding()) {
					if (coding.getSystem().equals("http://github.com/phenopackets/core-ig/CodeSystem/hpo")) {

						// these are phenotypes
						main.info("\tphenotype: " + coding.getDisplay(), true, logger);
					}
				}
				if (obs.getCode().hasCoding("http://snomed.info/sct", "424144002")) {

					// this is an age observation
					main.info("\tage: " + obs.getValueQuantity().getValue() + " " + obs.getValueQuantity().getUnit(),
							true, logger);
				}
			}

			// conditions for the patient
			Bundle condBundle = (Bundle) main.getClient().search().forResource(Condition.class)
					.and(new ReferenceClientParam("subject").hasId(patientRef)).execute();
			Utils.saveRequestResponse(main, logger, "condsForPatient-" + patient.getIdElement().getIdPart());

			for (BundleEntryComponent e : condBundle.getEntry()) {
				Condition cond = (Condition) e.getResource();
				for (Coding coding : cond.getCode().getCoding()) {
					if (coding.getSystem().equals("http://mondo")) {

						// this is a MONDO coded condition/diagnosis/disease
						main.info("\tcondition: " + coding.getDisplay(), true, logger);
					}
				}
			}
		}

	}
}
