package ca.uhn.fhir.jpa.empi;

import java.net.URL;

public class LookForFiles {

	public static void main(String[] args) {
		
		URL resource = LookForFiles.class.getClassLoader().getResource("org/hl7/fhir/r5/model/schema/fhir-single.xsd");
		System.out.println(resource);

	}

}
