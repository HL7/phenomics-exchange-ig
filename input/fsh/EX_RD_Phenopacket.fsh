Instance: DevelopmentalDelay
InstanceOf: Phenopacket
Description: "Example use case for a child with undiagnosed developmental delay"
* id = "id.treatment.1"
* status = #preliminary "preliminary"
* type = $LOINC#LOINC_11516-2 "Physician Episode of care medical records"
* date = "2018-03-16"
* title = "Phenopacket (static snapshot of clinical findings to support differential diagnosis of a child with developmental delay)."
* author = Reference(PeterGeneticist)
* subject = Reference(Proband1)
//* extension[phenotypic_features] = Reference(longPhiltrum)






Instance: longPhiltrum
InstanceOf: PhenotypicFeature
Description: "Long philtrum (HP:0000343)"
* id = "hp.0000343"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000343 "Long philtrum"
* valueBoolean = true

Instance: microphthalmia
InstanceOf: PhenotypicFeature
Description: "Long philtrum (HP:0000568)"
* id = "hp.0000568"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000568 "Microphthalmia"
* valueBoolean = true

Instance: irisColoboma
InstanceOf: PhenotypicFeature
Description: "Iris coloboma (HP:0000612)"
* id = "hp.0000612"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000612 "Iris coloboma"
* valueBoolean = true

Instance: Hypertelorism
InstanceOf: PhenotypicFeature
Description: "Hypertelorism (HP:0000316)"
* id = "hp.0000316"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000316 "Hypertelorism"
* valueBoolean = true

Instance: reducedVisualAcuity
InstanceOf: PhenotypicFeature
Description: "Reduced visual acuity (HP:0007663)"
* id = "hp.0007663"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0007663 "Reduced visual acuity"
* valueBoolean = true

Instance: lowSetEars 
InstanceOf: PhenotypicFeature
Description: "Low-set ears (HP:0000369)"
* id = "hp.0000369"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000369 "Low-set ears"
* valueBoolean = true


Instance: globalDevelopmentalDelay
InstanceOf: PhenotypicFeature
Description: "Global developmental delay (HP:0001263)"
* id = "hp.0001263"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0001263 "Global developmental delay"
* valueBoolean = true

Instance: Proband1
InstanceOf: Individual
Description: "Example child with developmental delay"
* identifier.use = #usual
* identifier.type = $IDTYPE#MR "Medical Record Number"
* identifier.system = "http://hospital.example.org"
* identifier.value = "m123"
* name.family = "Anyperson"
* name.given[0] = "Anyname"
* name.given[1] = "A."
* contact.telecom[0].system = #phone
* contact.telecom[0].value = "777-444-2222"
* contact.telecom[0].use = #home
* contact.telecom[1].system = #email
* contact.telecom[1].value = "anyname.anyperson@example.com"
* gender = #male
* birthDate = "2017-01-20"
* address.line = "123 Any St"
* address.city = "Anytown"
* address.postalCode = "12345"
* address.country = "US"
* communication.language = urn:ietf:bcp:47#en-US "English (Region=United States)"
* communication.language.text = "English"



Instance: PeterGeneticist
InstanceOf: Practitioner
Description: "Extended example: example practitioner"
* identifier.value = "practitioner.id1"
* name.family = "Geneticist"
* name.given[0] = "Peter"
* name.prefix[0] = "Dr."
* address.use = #work
* address.line[0] = "123 Yellow Brick Drive"
* address.city = "Anytown"
* address.state = "MA"
* address.postalCode = "12345"
* address.country = "US"
* gender = #male
* qualification.code = http://terminology.hl7.org/CodeSystem/v2-0360#MD
* qualification.code.coding[0].version = "2.7"
