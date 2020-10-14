package org.phenopackets.coreig.examples;

import java.io.InputStream;

import org.hl7.fhir.r4.model.StructureDefinition;

import ca.uhn.fhir.parser.IParser;

public class PPDefs {

	static public StructureDefinition getStructureDefinition(String path) {
		IParser parser = PPConfig.getJsonParser();
		
		try (InputStream reader = PPDefs.class.getResourceAsStream(path)) {
			return parser.parseResource(StructureDefinition.class, reader);
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}

}
