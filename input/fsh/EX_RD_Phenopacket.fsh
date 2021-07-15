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
* section[diseases].entry[0] = Reference(intellectualDisabilityDisease)
* section[phenotypic_features].entry[+] = Reference(longPhiltrum)
* section[phenotypic_features].entry[+] = Reference(microphthalmia)
* section[phenotypic_features].entry[+] = Reference(retinalDetachment)
* section[phenotypic_features].entry[+] = Reference(tga)
* section[phenotypic_features].entry[+] = Reference(reducedVisualAcuity)
* section[phenotypic_features].entry[+] = Reference(lowSetEars)
* section[phenotypic_features].entry[+] = Reference(globalDevelopmentalDelay)
* section[phenotypic_features].entry[+] = Reference(muscleWeakness)
* section[phenotypic_features].entry[+] = Reference(amyotrophy)
* section[biosamples].entry[+] = Reference(muscleBiopsy)



Instance: intellectualDisabilityDisease
InstanceOf: Disease
Description: "Intellectual disability (disease)"
* id = "id.disease.intellectualDisability"
* code  = $mondo#MONDO_0001071  "Intellectual disability"
* subject = Reference(Proband1)


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

Instance: retinalDetachment
InstanceOf: PhenotypicFeature
Description: "Retinal detachment (HP:0000541)"
* id = "hp.0000541"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0000541 "Retinal detachment"
* valueBoolean = true

Instance: tga
InstanceOf: PhenotypicFeature
Description: "Transposition of the great arteries (HP:0001669)"
* id = "hp.0001669"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0001669 "Transposition of the great arteries"
* valueBoolean = true

Instance: reducedVisualAcuity
InstanceOf: PhenotypicFeature
Description: "Reduced visual acuity (HP:0007663)"
* id = "hp.0007663"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0007663 "Reduced visual acuity"
* valueBoolean = true

Instance: hpotonia 
InstanceOf: PhenotypicFeature
Description: "Hypotonia (HP:0001252)"
* id = "hp.0001252"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0001252 "Hypotonia"
* valueBoolean = true


Instance: globalDevelopmentalDelay
InstanceOf: PhenotypicFeature
Description: "Global developmental delay (HP:0001263)"
* id = "hp.0001263"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0001263 "Global developmental delay"
* valueBoolean = true

Instance: muscleWeakness
InstanceOf: PhenotypicFeature
Description: "Muscle weakness (HP:0001324)"
* id = "hp.0001324"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0001324 "Muscle weakness"
* valueBoolean = true


Instance: amyotrophy
InstanceOf: PhenotypicFeature
Description: "Skeletal muscle atrophy (HP:0003202)"
* id = "hp.0003202"
* status = #active "active"
* subject = Reference(Proband1)
* code = $hpo#HP:0003202 "Skeletal muscle atrophy"
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



Instance: muscleBiopsy
InstanceOf: Biosample
Description: "Biosample Example -- muscle biopsy"
* id = "biosample.specimen.id.2"
* collection.bodySite = $uberon#UBERON_0001388  "gastrocnemius"
//* type =  $efo#EFO_0010942 "primary tumor sample"
* subject = Reference(Proband1)
* identifier.value = "arbitrary identifier"
* extension[MaterialSample].valueCoding = $efo#EFO_0009655 "abnormal sample"
* processing.procedure = $ncit#NCIT_C51895 "Muscle Biopsy"
* collection.collectedDateTime = "2021-01-20"
