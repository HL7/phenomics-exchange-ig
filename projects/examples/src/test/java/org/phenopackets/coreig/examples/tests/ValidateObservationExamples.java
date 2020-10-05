package org.phenopackets.coreig.examples.tests;

import static org.junit.jupiter.api.Assertions.assertThrows;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.io.ObjectInputFilter.Config;

import org.hl7.fhir.r4.model.CodeableConcept;
import org.hl7.fhir.r4.model.Coding;
import org.hl7.fhir.r4.model.Narrative;
import org.hl7.fhir.r4.model.Narrative.NarrativeStatus;
import org.hl7.fhir.r4.model.Observation;
import org.hl7.fhir.r4.model.Observation.ObservationStatus;
import org.hl7.fhir.r4.model.Quantity;
import org.junit.jupiter.api.Assertions;
import org.junit.jupiter.api.Test;
import org.phenopackets.coreig.examples.PPConfig;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.MethodOutcome;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.server.exceptions.UnprocessableEntityException;
import ca.uhn.fhir.validation.FhirValidator;
import ca.uhn.fhir.validation.SingleValidationMessage;
import ca.uhn.fhir.validation.ValidationResult;

public class ValidateObservationExamples {

	@Test
	void localBaseSpecExample() {

		Observation obs = new Observation();

		FhirContext ctx = PPConfig.getContext();
		// FhirInstanceValidator iv = new FhirInstanceValidator(ctx);
		FhirValidator fhirValidator = ctx.newValidator();
		// fhirValidator.registerValidatorModule(iv);

		ValidationResult result = fhirValidator.validateWithResult(obs);

		// this will fail
		// Assertions.assertTrue(result.isSuccessful());

		System.out.println("===============  Empty Observation ===============");
		for (SingleValidationMessage m : result.getMessages()) {
			System.out.println(m.getMessage());
		}

		// output
		// Element must have some content
		// Profile http://hl7.org/fhir/StructureDefinition/Observation, Element
		// 'Observation.status': minimum required = 1, but only found 0
		// Profile http://hl7.org/fhir/StructureDefinition/Observation, Element
		// 'Observation.code': minimum required = 1, but only found 0

		obs.getCode().addCoding().setCode("SomeCode");
		obs.setStatus(ObservationStatus.AMENDED);
		result = fhirValidator.validateWithResult(obs);

		// this will pass but we still have a validation message
		// Assertions.assertTrue(result.isSuccessful());
		System.out.println("===============  Observation with code and status ===============");
		for (SingleValidationMessage m : result.getMessages()) {
			System.out.println(m.getMessage());
		}

		// output
		// A code with no system has no defined meaning. A system should be provided

		obs.getCode().getCodingFirstRep().setSystem("http://somesystem");
		result = fhirValidator.validateWithResult(obs);

		// this will pass but we still have a validation message
		Assertions.assertEquals(0, result.getMessages().size());

	}

	@Test
	void serverBaseSpecExample() {

		Observation obs = new Observation();

		IGenericClient clienet = PPConfig.getClient();
		UnprocessableEntityException e = assertThrows(UnprocessableEntityException.class, () -> {
			MethodOutcome outcome = clienet.create().resource(obs).execute();
		});
		System.out.println("========== 1 ===========");
		System.out.println(e.getMessage());
		// HTTP 422 Unprocessable Entity: dom-6: A resource should have narrative for
		// robust management [text.div.exists()]

		obs.getText().getDiv().addText("Some narrative content");
		e = assertThrows(UnprocessableEntityException.class, () -> {
			MethodOutcome outcome = clienet.create().resource(obs).execute();
		});

		System.out.println("========== 2 ===========");
		System.out.println(e.getMessage());
		// HTTP 422 Unprocessable Entity: Profile
		// http://hl7.org/fhir/StructureDefinition/Observation, Element
		// 'Observation.status': minimum required = 1, but only found 0

		obs.getCode().addCoding().setCode("SomeCode");
		obs.setStatus(ObservationStatus.AMENDED);
		e = assertThrows(UnprocessableEntityException.class, () -> {
			MethodOutcome outcome = clienet.create().resource(obs).execute();
		});
		System.out.println("========= 3 ============");
		System.out.println(e.getMessage());
		// HTTP 422 Unprocessable Entity: Profile
		// http://hl7.org/fhir/StructureDefinition/Narrative, Element
		// 'Observation.text.status': minimum required = 1, but only found 0

		obs.getText().setStatus(NarrativeStatus.GENERATED);

		MethodOutcome outcome = clienet.create().resource(obs).execute();
		assertTrue(outcome.getCreated());

		System.out.println("========= 4 ============");

	}

	@Test
	void highSodiumExample() {
		Observation obs = new Observation();

		Narrative text = obs.getText();
		text.getDiv().addText("Just a dummy example.");
		text.setStatus(NarrativeStatus.GENERATED);
		obs.setStatus(ObservationStatus.CANCELLED);

		Coding coding = obs.getCode().addCoding();
		coding.setCode("2951-2");
		coding.setSystem("http://loinc");

		Quantity value = obs.getValueQuantity();
		value.setUnit("mEq/L");
		value.setValue(160.0);

		// add a snomed interpretation
		Coding interp = obs.addInterpretation().addCoding();
		interp.setSystem("http://snomed");
		interp.setCode("267446004");

		// add an HPO interpretation
		interp = obs.addInterpretation().addCoding();
		interp.setSystem("http://hpo");
		interp.setCode("HP:0003228");

		IParser parser = PPConfig.getJsonParser();
		parser.setPrettyPrint(true);
		System.out.println(parser.encodeResourceToString(obs));
		
		// output:
//		{
//			  "resourceType": "Observation",
//			  "text": {
//			    "status": "generated",
//			    "div": "<div xmlns=\"http://www.w3.org/1999/xhtml\">Just a dummy example.</div>"
//			  },
//			  "status": "cancelled",
//			  "code": {
//			    "coding": [ {
//			      "system": "http://loinc",
//			      "code": "2951-2"
//			    } ]
//			  },
//			  "valueQuantity": {
//			    "value": 160.0,
//			    "unit": "mEq/L"
//			  },
//			  "interpretation": [ {
//			    "coding": [ {
//			      "system": "http://snomed",
//			      "code": "267446004"
//			    } ]
//			  }, {
//			    "coding": [ {
//			      "system": "http://hpo",
//			      "code": "HP:0003228"
//			    } ]
//			  } ]
//			}

		IGenericClient client = PPConfig.getClient();
		MethodOutcome outcome = client.create().resource(obs).execute();
		assertTrue(outcome.getCreated());

	}

}
