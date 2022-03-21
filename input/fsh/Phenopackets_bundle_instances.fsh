Instance: PhenopacketsBundleExample01
InstanceOf: Bundle
Usage: #example
* meta.lastUpdated = "2022-02-02T22:22:22Z"
* identifier.system = "urn:ietf:rfc:3986"
* identifier.value = "urn:uuid:1111-1111-1111-1111"
* type = #document
* timestamp = "2022-02-02T22:22:22Z"
//http://phenopackets.org/core-ig/DiagnosticReport-PhenopacketsGenomicInterpretationExample01.html
* entry[0].fullUrl = "http://phenopackets.org/core-ig/Composition-PhenopacketCompositionExample01.html"
* entry[=].resource = PhenopacketCompositionExample01
//subject: example-patient
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Patient-example-patient.html"
* entry[=].resource = example-patient
//PhenopacketPractitionerExample01
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Practitioner-PhenopacketPractitionerExample01.html"
* entry[=].resource = PhenopacketPractitionerExample01
//features: CHF-with-severity
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Observation-id.phenotypicfeature.4.html"
* entry[=].resource = CHF-with-severity
//measurements: thrombocytopenia
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Observation-id.measurement.1.html"
* entry[=].resource = thrombocytopenia
//diseases: CHF-stageIII
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Condition-id.disease.3.html"
* entry[=].resource = CHF-stageIII
//biosamples: bladderCarcinoma
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Specimen-biosample.specimen.id.1.html"
* entry[=].resource = bladderCarcinoma
//interpretation: PhenopacketsGenomicInterpretationExample02
* entry[+].fullUrl = "http://phenopackets.org/core-ig/DiagnosticReport-PhenopacketsGenomicInterpretationExample02.html"
* entry[=].resource = PhenopacketsGenomicInterpretationExample02
//PhenopacketsVariantExample01
* entry[+].fullUrl = "http://phenopackets.org/core-ig/Observation-PhenopacketsVariantExample01.html"
* entry[=].resource = PhenopacketsVariantExample01


Instance: PhenopacketCompositionExample01
InstanceOf: Phenopacket
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
