package org.phenopackets.coreig.examples;

import java.io.FileReader;
import java.io.IOException;
import java.util.Properties;

import org.hl7.fhir.r5.model.CapabilityStatement;

import ca.uhn.fhir.context.FhirContext;
import ca.uhn.fhir.parser.IParser;
import ca.uhn.fhir.rest.api.Constants;
import ca.uhn.fhir.rest.client.api.IGenericClient;
import ca.uhn.fhir.rest.client.api.ServerValidationModeEnum;

public class PPConfiguration {

	public final static String SERVER_URL_PROP_KEY = "server-url";

	private static FhirContext ctx = null;

	static FhirContext getContext() {
		if (ctx == null) {
			ctx = FhirContext.forR5();
			ctx.getRestfulClientFactory().setServerValidationMode(ServerValidationModeEnum.NEVER);
		}
		return ctx;
	}

	public static IGenericClient getClienet() {
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
	
	public static CapabilityStatement getCapabilitiy() {
		return getClienet().fetchResourceFromUrl(CapabilityStatement.class, Constants.URL_TOKEN_METADATA);
	}
	
	public static IParser getJsonParser() {
		IParser parser = getContext().newJsonParser();
		return parser;
	}

}
