package org.phenopackets.coreig.examples;

import org.hl7.fhir.common.hapi.validation.validator.FhirInstanceValidator;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.validation.FhirValidator;

public class PPValidate {
	
	static public FhirValidator getBaseSpecValidator() {
	FhirContext ctx = PPConfig.getContext();
		FhirValidator validator = ctx.newValidator();
		validator.registerValidatorModule(new FhirInstanceValidator(ctx));
		return validator;
	}
	
	

}
