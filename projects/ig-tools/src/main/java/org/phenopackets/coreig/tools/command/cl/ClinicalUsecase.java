package org.phenopackets.coreig.tools.command.cl;

import java.util.concurrent.Callable;

import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleType;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Resource;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import ca.uhn.fhir.rest.api.MethodOutcome;

public class ClinicalUsecase implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(ClinicalUsecase.class);

	private MainCommand main;

	public ClinicalUsecase(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {
		
		Patient patient = createPatient();
		
		System.out.println("debug");
		return null;
	}
	
	private Patient createPatient() {
		Resource r = main.loadResource("../../data/cl-data/Patient-patient-data.xml");
		MethodOutcome mo = main.getClient().create().resource(r).execute();
		writeStep("createPatient");
		return (Patient) mo.getResource();
	}

	private void writeStep(String step) {
		Utils.saveToStepFile(main, logger, step);
	}

	private void firstTry() {
		Resource patient = main.loadResource("../../data/cl-data/Patient-patient-data.xml");
		MethodOutcome mo = main.getClient().create().resource(patient).execute();

		String requestResponse = Utils.saveToStepFile(main, logger, "createPatient");

		IBaseResource resource = mo.getResource();
		Patient createdPatient = null;
		if (Patient.class.isInstance(resource)) {
			createdPatient = (Patient) resource;
		} else {
			main.error("Something went wrong with creating patient", true, logger);
			throw new IllegalStateException("Couldn't create Patient. Response was:\n" + requestResponse);
		}

		// load a phenopacket for this patient before placing a lab request and
		// attaching the phenopacket
		Bundle bundle = (Bundle) main.loadResource("../../data/cl-data/Bundle-phenopacket-data.xml");
		Bundle execute = main.getClient().transaction().withBundle(bundle).execute();

		Utils.saveToStepFile(main, logger, "createNestedBundle");

		execute.setType(BundleType.COLLECTION);
		MethodOutcome execute2 = main.getClient().create().resource(execute)
				.withAdditionalHeader("Prefer", "return=representation").execute();
		
		Utils.saveToStepFile(main, logger, "savingBundle");

		System.out.println(execute);
	}
	
	private void secondTry() {
		Bundle bundle = (Bundle) main.loadResource("../../data/cl-data/Bundle-phenopacket-lightweight.xml");
		main.getClient().create().resource(bundle).execute();
		Utils.saveToStepFile(main, logger, "createBundleSecondTrye");
	}

}
