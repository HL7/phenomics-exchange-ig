package org.phenopackets.coreig.tools.command.kf;

import java.util.concurrent.Callable;

import org.hl7.fhir.r4.model.Bundle;
import org.phenopackets.coreig.tools.command.MainCommand;
import org.phenopackets.coreig.tools.util.Utils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class KFLoadData implements Callable<Void> {

	private static Logger logger = LoggerFactory.getLogger(KFLoadData.class);

	private MainCommand main;

	public KFLoadData(MainCommand main) {
		this.main = main;
	}

	@Override
	public Void call() throws Exception {

		loadData();

		return null;
	}

	private void loadData() {
		Bundle bundle = (Bundle) main.loadResource("../../data/kf-data/Bundle-kf-bundle-1.xml");
		main.getClient().transaction().withBundle(bundle).execute();
		Utils.saveRequestResponse(main, logger, "dataBundle1");

		bundle = (Bundle) main.loadResource("../../data/kf-data/Bundle-kf-bundle-2.xml");
		main.getClient().transaction().withBundle(bundle).execute();
		Utils.saveRequestResponse(main, logger, "dataBundle2");
	}

}
