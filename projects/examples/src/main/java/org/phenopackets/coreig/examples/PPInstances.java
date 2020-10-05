package org.phenopackets.coreig.examples;

import org.hl7.fhir.r5.model.Observation;
import org.hl7.fhir.r5.model.Patient;

public class PPInstances {
	
  public static Patient getEmptyPatient() {
	  Patient patient = new Patient();
	  return patient;
  }
  
  public static Observation getEmptyObservation() {
	  Observation obs = new Observation();
	  return obs;
  }

}
