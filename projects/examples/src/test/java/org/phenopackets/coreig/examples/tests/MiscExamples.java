package org.phenopackets.coreig.examples.tests;

import org.hl7.fhir.instance.model.api.IBaseOperationOutcome;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r5.model.CapabilityStatement;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.phenopackets.coreig.examples.PPConfiguration;
import org.phenopackets.coreig.examples.PPInstances;

import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;

public class MiscExamples {

	@Test
	void getCapabilitiesStatement() {

		CapabilityStatement capabilitiy = PPConfiguration.getCapabilitiy();
		IParser jsonParser = PPConfiguration.getJsonParser();
		jsonParser.setPrettyPrint(true);
		System.out.println(jsonParser.encodeResourceToString(capabilitiy));
	}

	@Test
	void sayHello() {
		System.out.println("Hello");
	}

	@Test
	void emptyPatientOkay() {

		MethodOutcome result = PPConfiguration.getClienet().create().resource(PPInstances.getEmptyPatient()).execute();
		IBaseResource patient = result.getResource();
		Assertions.assertTrue(result.getCreated());
	}
	
	@Test
	void emptyObservationFails() {
		IGenericClient clienet = PPConfiguration.getClienet();
		clienet.set
		MethodOutcome outcome = clienet.create().resource(PPInstances.getEmptyObservation()).execute();
		IBaseOperationOutcome operationOutcome = outcome.getOperationOutcome();
		
	}

}
