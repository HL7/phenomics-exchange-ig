Instance: DevelopmentalDelay
InstanceOf: Phenopacket
Description: "Example use case for a child with undiagnosed developmental delay"
* identifier.value = "id.treatment.1"
* status = #preliminary "preliminary"
* type = $LOINC#11516-2 "Physician Episode of care medical records"
* date = "2018-03-16"
* title = "Phenopacket (static snapshot of clinical findings to support differential diagnosis of a child with developmental delay)."
* author = Reference(PeterGeneticist)
* subject = Reference(Proband1)
* section[phenotypic_features].entry[+] = Reference(longPhiltrum)
* section[phenotypic_features].entry[+] = Reference(microphthalmia)
* section[phenotypic_features].entry[+] = Reference(retinalDetachment)
* section[phenotypic_features].entry[+] = Reference(tga)
* section[phenotypic_features].entry[+] = Reference(reducedVisualAcuity)
* section[phenotypic_features].entry[+] = Reference(lowSetEars)
* section[phenotypic_features].entry[+] = Reference(globalDevelopmentalDelay)
* section[phenotypic_features].entry[+] = Reference(muscleWeakness)
* section[phenotypic_features].entry[+] = Reference(hypotonia)
* section[phenotypic_features].entry[+] = Reference(amyotrophy)
* section[phenotypic_features].entry[+] = Reference(fiberSizeVariability)
* section[biosamples].entry[+] = Reference(muscleBiopsy)
* section[diseases].entry[0] = Reference(intellectualDisabilityDisease)








