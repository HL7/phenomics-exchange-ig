package org.phenopackets.coreig.examples.tests;

import static org.junit.jupiter.api.Assertions.assertNotNull;

import org.hl7.fhir.r4.model.DocumentReference;
import org.hl7.fhir.r4.model.StructureDefinition;
import org.junit.jupiter.api.Test;
import org.phenopackets.coreig.PPValidator;
import org.phenopackets.coreig.examples.PPConfig;
import org.phenopackets.coreig.examples.PPDefs;

import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.validation.ValidationResult;

public class SDExamples {

	@Test
	void generateSnapshots() {

		PPValidator validator = PPConfig.getPPValidator();
		IGenericClient client = PPConfig.getClient();

		for (String path : new String[] { "/kf/StructureDefinition-drs-checksum.json", "/kf/StructureDefinition-drs-access-method.json",
				"/kf/StructureDefinition-drs-object.json",
				"/kf/StructureDefinition-drs-attachment.json" }) {
			StructureDefinition sd = PPDefs.getStructureDefinition(path);
			assertNotNull(sd);
//			StructureDefinition sdWithSnapshot = (StructureDefinition) validator.generateSnapshot(
//					new ValidationSupportContext(validator.getCacheSupport()), sd, "http://urlprefix",
//					"http://webprefix", "");
//			assertNotNull(sdWithSnapshot);
			
			MethodOutcome execute = client.create().resource(sd).execute();
			System.out.println(execute);
			execute = client.validate().resource(execute.getResource()).execute();
			System.out.println(execute);
			
//			ValidationResult outcome = validator.getValidator().validateWithResult(sdWithSnapshot);
			
//			System.out.println(outcome);
		}
		IParser parser = PPConfig.getJsonParser();
		DocumentReference docRef = parser.parseResource(DocumentReference.class	, SDExamples.class.getResourceAsStream("/kf/DocumentReference-example-document-reference-id.json"));
		MethodOutcome execute = client.create().resource(docRef).execute();
		
		MethodOutcome execute2 = client.validate().resource(execute.getResource()).execute();
		System.out.println(execute2);
		
	}
	
	@Test
	void testInstance() {
		PPValidator pp = PPConfig.getPPValidator();
		pp.addStructureDefinition(PPDefs.getStructureDefinition("/kf/StructureDefinition-drs-checksum.json"));
		pp.addStructureDefinition(PPDefs.getStructureDefinition("/kf/StructureDefinition-drs-object.json"));
		pp.addStructureDefinition(PPDefs.getStructureDefinition("/kf/StructureDefinition-drs-access-method.json"));
		pp.addStructureDefinition(PPDefs.getStructureDefinition("/kf/StructureDefinition-drs-attachment.json"));
		
		IParser parser = PPConfig.getJsonParser();
		ValidationResult outcome = pp.getValidator().validateWithResult(parser.parseResource(DocumentReference.class	, SDExamples.class.getResourceAsStream("/kf/DocumentReference-example-document-reference-id.json")));
		System.out.println(outcome);
		
	}
	
}
