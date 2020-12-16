package org.phenopackets.coreig.tools.command.kf;

import java.util.concurrent.Callable;

import org.hl7.fhir.r4.model.Bundle;
import org.hl7.fhir.r4.model.Condition;
import org.hl7.fhir.r4.model.Bundle.BundleEntryComponent;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.Patient;
import org.hl7.fhir.r4.model.Resource;
import org.hl7.fhir.r4.model.Specimen;
import org.hl7.fhir.r4.model.Task;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class KFClearData implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(KFClearData.class);

	private MainCommand main;

	public KFClearData(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		// this doesn't work for HAPI. See:
		// https://chat.fhir.org/#narrow/stream/implementers/subject/Search.20by.20_tag.20on.20base.20url
		//
		// main.getClient().search().forAllResources().withTag(Utils.TAG_URI,
		// "kfdata").execute();

		@SuppressWarnings("unchecked")
		Class<? extends Resource>[] classes = new Class[] { Observation.class, Task.class, Condition.class,
				Specimen.class, Patient.class };

		for (Class<? extends Resource> clas : classes) {
			Thread.sleep(1000);
			while (true) {
				Bundle bundle = (Bundle) main.getClient().search().forResource(clas).withTag(Utils.TAG_URI, "kfdata")
						.execute();
				Utils.logRequest(main, logger);
				Utils.logResponse(main, logger);

				if (bundle.getEntry().size() > 0) {
					for (BundleEntryComponent entry : bundle.getEntry()) {
						if (clas.isInstance(entry.getResource())) {
							main.getClient().delete().resource(entry.getResource()).execute();
							Utils.saveRequestResponse(main, logger, "detete-" + entry.getResource().fhirType() + "-"
									+ entry.getResource().getIdElement().getIdPart());
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
