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
