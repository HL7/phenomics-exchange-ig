package org.phenopackets.coreig.examples.tests;

import org.hl7.fhir.instance.model.api.IBaseOperationOutcome;
import org.hl7.fhir.instance.model.api.IBaseResource;
import org.hl7.fhir.r5.model.CapabilityStatement;
import org.hl7.fhir.r5.model.Observation;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.phenopackets.coreig.examples.PPConfig;
import org.phenopackets.coreig.examples.PPInstances;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.server.exceptions.UnprocessableEntityException;

public class MiscExamples {

	@Test
	void getCapabilitiesStatement() {

		CapabilityStatement capabilitiy = PPConfig.getCapabilitiy();
		IParser jsonParser = PPConfig.getJsonParser();
		jsonParser.setPrettyPrint(true);
		System.out.println(jsonParser.encodeResourceToString(capabilitiy));
	}

	@Test
	void sayHello() {
		System.out.println("Hello");
	}

	@Test
	void emptyPatientOkay() {

		MethodOutcome result = PPConfig.getClienet().create().resource(PPInstances.getEmptyPatient()).execute();
		IBaseResource patient = result.getResource();
		Assertions.assertTrue(result.getCreated());
	}
	
	@Test
	void emptyObservationFails() {
		FhirContext ctx = PPConfig.getContext();
		IGenericClient clienet = PPConfig.getClienet();
		Observation obs = PPInstances.getEmptyObservation();
		obs.addNote().setText("Some note");
		boolean generated = ctx.getNarrativeGenerator().populateResourceNarrative(ctx, obs);
		System.out.println(obs.getText());
		
		

		obs.getText().getDiv().addText("Some div text");
		IParser parser = PPConfig.getJsonParser();
		parser.setPrettyPrint(true)
		;
		String encodeResourceToString = parser.encodeResourceToString(obs);
		System.out.println(encodeResourceToString);
		MethodOutcome outcome;
		try {
			outcome = clienet.create().resource(obs).execute();
		} catch (UnprocessableEntityException e) {
		
			e.printStackTrace();
			throw e;
		}
		IBaseOperationOutcome operationOutcome = outcome.getOperationOutcome();
		
	}

}
