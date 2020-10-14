package org.phenopackets.coreig.examples;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import org.hl7.fhir.r5.model.CapabilityStatement;
import org.phenopackets.coreig.PPValidator;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.narrative.DefaultThymeleafNarrativeGenerator;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.Constants;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.ServerValidationModeEnum;
import ca.uhn.fhir.validation.FhirValidator;
import ca.uhn.fhir.validation.IValidatorModule;

public class PPConfig {

	public final static String SERVER_URL_PROP_KEY = "server-url";

	private static FhirContext ctx = null;

	static public FhirContext getContext() {
		if (ctx == null) {
			ctx = FhirContext.forR4();
			ctx.getRestfulClientFactory().setServerValidationMode(ServerValidationModeEnum.NEVER);
			ctx.setNarrativeGenerator(new DefaultThymeleafNarrativeGenerator());
		}
		return ctx;
	}

	public static IGenericClient getClient() {
		return getContext().newRestfulGenericClient(getProperties().getProperty(SERVER_URL_PROP_KEY));
	}

	static Properties props = null;

	static Properties getProperties() {
		if (props == null) {
			props = new Properties();
			try {
				props.load(new FileReader("config.properties"));
			} catch (IOException e) {

				e.printStackTrace();
				throw new RuntimeException(e);
			}
		}
		return props;
	}

	static public CapabilityStatement getCapabilitiy() {
		return getClient().fetchResourceFromUrl(CapabilityStatement.class, Constants.URL_TOKEN_METADATA);
	}

	static public IParser getJsonParser() {
		IParser parser = getContext().newJsonParser();
		return parser;
	}

	static public PPValidator getPPValidator() {
		return new PPValidator(getContext());
	}
}
