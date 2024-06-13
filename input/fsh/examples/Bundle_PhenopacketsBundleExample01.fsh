Instance: PhenopacketsBundleExample01
InstanceOf: Bundle
Description: "Example Phenopacket Bundle instance"
Usage: #example
* meta.lastUpdated = "2022-02-02T22:22:22Z"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:1111-1111-1111-1111"
* type = #document
* timestamp = "2022-02-02T22:22:22Z"
* entry[0]
  * insert bundleEntry(Composition, PhenopacketCompositionExample01)
* entry[+]
  * insert bundleEntry(Patient, example-patient)
* entry[+]
  * insert bundleEntry(Practitioner, PhenopacketPractitionerExample01)
//features: CHF-with-severity
* entry[+]
  * insert bundleEntry(Observation, CHF-with-severity)
//measurements: thrombocytopenia
* entry[+]
  * insert bundleEntry(Observation, thrombocytopenia)
//diseases: CHF-stageIII
* entry[+]
  * insert bundleEntry(Condition, CHF-stageIII)
//biosamples: bladderCarcinoma
* entry[+]
  * insert bundleEntry(Specimen, bladderCarcinoma)
//interpretation: PhenopacketsGenomicInterpretationExample02
* entry[+]
  * insert bundleEntry(DiagnosticReport, PhenopacketsGenomicInterpretationExample02)
//PhenopacketsVariantExample01
* entry[+]
  * insert bundleEntry(Observation, PhenopacketsVariantExample01)
