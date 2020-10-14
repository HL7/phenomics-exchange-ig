package org.phenopackets.coreig;

import org.hl7.fhir.r4.model.StructureDefinition;
import org.phenopackets.coreig.examples.PPConfig;
import org.phenopackets.coreig.examples.PPDefs;

import ca.uhn.fhir.context.support.ValidationSupportContext;

public class KFTesting {

	public static void main(String[] args) {
		test();

	}

	static void test() {
		PPValidator validator = PPConfig.getPPValidator();

		StructureDefinition sd = PPDefs.getStructureDefinition("/kf/StructureDefinition-drs-checksum.json");

		Object sdWithSnapshot = validator.generateSnapshot(new ValidationSupportContext(validator.getCacheSupport()),
				sd, "http://urlprefix", "http://webprefix", "");
		System.out.println(sdWithSnapshot);
	}

}
