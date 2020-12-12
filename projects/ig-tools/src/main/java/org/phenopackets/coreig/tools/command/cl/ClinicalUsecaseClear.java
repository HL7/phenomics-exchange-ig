package org.phenopackets.coreig.tools.command.cl;

import java.util.concurrent.Callable;

import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Resource;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ClinicalUsecaseClear implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(ClinicalUsecaseClear.class);

	private MainCommand main;

	public ClinicalUsecaseClear(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		@SuppressWarnings("unchecked")
		Class<? extends Resource>[] classes = new Class[] { Observation.class, Patient.class };

		for (Class<? extends Resource> clas : classes) {
			Thread.sleep(1000);
			while (true) {
				Bundle bundle = (Bundle) main.getClient().search().forResource(clas)
						.withTag(Utils.TAG_URI, "clinical-usecase").execute();
				Utils.saveToStepFile(main, logger, clas.getSimpleName() + "-search-bundle");

				if (bundle.getEntry().size() > 0) {
					for (BundleEntryComponent entry : bundle.getEntry()) {
						if (clas.isInstance(entry.getResource())) {
							Resource r = entry.getResource();
							main.getClient().delete().resource(r).execute();
							Utils.saveToStepFile(main, logger,
									r.fhirType() + "-delete-" + r.getIdElement().getIdPart());
						}
					}
				} else {
					break;
				}
			}
		}
		return null;
	}

}
