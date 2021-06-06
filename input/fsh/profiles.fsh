Profile: Disease
Parent: Condition
Id: Disease
Title: "Disease profile"
Description: "This profile stipulates that a FHIR Condition must have a codeable concept that represents the disease. The concepts can be taken from various ontologies, but for rare-disease concepts, we recommend MONDO."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
//* extension contains
//    CodedOnset named CodedOnset ..1 MS //and
//    TumorStage named TumorStage ..1 MS
//* code MS
//* subject MS
//* onset[x] MS

Profile: Individual
Parent: Patient
Id: Individual
Title: "Individual"
Description: "The subject of the Phenopacket is represented by an Individual element. This element intends to represent an individual human or other organism."
* ^version = "0.0.1"
* ^date = "2021-05-28T17:06:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* extension contains
 //   AgeOrAgeRange named AgeOrAgeRange ..1 MS and
    KaryotypicSex named KaryotypicSex 0..1 MS //and
//    Taxonomy named Taxonomy ..1 MS
* identifier MS
* gender MS
* birthDate MS


Profile: Measurement
Parent: Observation
Id: Measurement
Title: "Measurement"
Description: "This profile defines the GA4GH Measurement element in terms of the FHIR Observation"
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"

Profile: PhenotypicFeature
Parent: Observation
Id: PhenotypicFeature
Title: "Phenotypic Feature"
Description: "This profile defines the GA4GH PhenotypicFeature element in terms of the FHIR Condition"
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* code 1..1 MS
* value[x] 1..1 MS
* value[x] only CodeableConcept
* value[x] ^short = "Superclass of ontology terms used to denote phenotypic feature"
//* severity 0..1 MS
//* clinicalStatus 0..1 MS
* specimen ..0
* device ..0
* referenceRange ..0
* hasMember ..0
* component ..0

