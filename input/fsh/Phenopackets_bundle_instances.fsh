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

Instance: PhenopacketCompositionExample01
InstanceOf: Phenopacket
Description: "Example Phenopacket Composition instance"
Usage: #example
//* meta.profile = "https://github.com/phenopackets/core-ig/StructureDefinition/Phenopacket"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:1111-1111-1111-1112"
* status = #preliminary
* type = LNC#11503-0 "Medical records" // we may need to change this later to a phenopacket loinc code
* subject = Reference(example-patient) "Anyname A. Anyperson"
* date = "2022-02-02"
* author = Reference(PhenopacketPractitionerExample01) "John T. Practitioner"
* title = "This is an example of a composition resource that represents some of the Phenopackets data elements"
* section[phenotypic_features].entry = Reference(CHF-with-severity) "Congestive heart failure"
* section[measurements].entry = Reference(thrombocytopenia) "Thrombocytopenia"
* section[biosamples].entry = Reference(bladderCarcinoma) "Bladder Carcinoma"
* section[interpretations].entry = Reference(PhenopacketsGenomicInterpretationExample02) "Obesity due to centrosomal protein 19 deficiency (disorder)"
* section[diseases].entry = Reference(CHF-stageIII) "CHF-stageIII"
