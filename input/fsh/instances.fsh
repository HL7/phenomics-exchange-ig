Instance: karyotypic-sex-invalid-1
InstanceOf: Observation
Title: "An INVALID karyotypic sex Observation instance."
Usage: #example
* status = #final
* code = $GSSO#GSSO:000113
* valueCodeableConcept = $observation-karyotypic-sex#XXW

Instance: karyotypic-sex-valid-1
InstanceOf: Observation
Title: "A VALID karyotypic sex Observation instance."
Usage: #example
* status = #final
* code = $GSSO#GSSO:000113
* valueCodeableConcept = $observation-karyotypic-sex#XX

Instance: phenotypic-abnormality-invalid-1
InstanceOf: Observation
Title: "An INVALID phenotypic abnormality Observation example."
Usage: #example
* extension.url = "http://github.com/phenopackets/core-ig/ig-tools/validation-error-count"
* extension.valueInteger = 4
* status = #final
* code = $hpo#HP:0001249 "Intellectual disability"
* code.text = "Intellectual disability"
* valueBoolean = true
* component[0].code = $hpo#HP:0012824 "Severity"
* component[=].valueCodeableConcept = $hpo#HP:0012825 "Mild"
* component[+].code = $hpo#HP:0012824 "Severity"
* component[=].valueCodeableConcept = $hpo#HP:0012825 "Mild"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:0410401 "Worse in evening"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:0031375 "Refractory"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:999999999 "Non existant modifier"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueCodeableConcept = $hpo#HP:0003577 "Congenital onset"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueQuantity = 0 http://some/unit/system#Day "Day"
* component[+].code = $OTHER#OTHER "Severity"
* component[=].valueCodeableConcept = $OTHER#OTHERTHING "Mild"

Instance: phenotypic-abnormality-invalid-meta-profile
InstanceOf: Observation
Usage: #example
* status = #final
* code = $hpo#HP:0001249 "Intellectual disability"
* code.text = "Intellectual disability"
* valueBoolean = true
* component[0].code = $hpo#HP:0012824 "Severity"
* component[=].valueCodeableConcept = $hpo#HP:0012825 "Mild"
* component[+].code = $hpo#HP:0012824 "Severity"
* component[=].valueCodeableConcept = $hpo#HP:0012825 "Mild"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:0410401 "Worse in evening"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:0031375 "Refractory"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:999999999 "Non existant modifier"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueCodeableConcept = $hpo#HP:0003577 "Congenital onset"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueQuantity = 0 http://some/unit/system#Day "Day"
* component[+].code = $OTHER#OTHER "Severity"
* component[=].valueCodeableConcept = $OTHER#OTHERTHING "Mild"

Instance: phenotypic-abnormality-valid-1
InstanceOf: Observation
Title: "A valid phenotypic abnormality Observation example."
Usage: #example
* status = #final
* code = $hpo#HP:0001249 "Intellectual disability"
* code.text = "Intellectual disability"
* valueBoolean = true
* component[0].code = $hpo#HP:0012824 "Severity"
* component[=].valueCodeableConcept = $hpo#HP:0012825 "Mild"
* component[+].code = $hpo#HP:0012823 "Clinical modifier"
* component[=].valueCodeableConcept = $hpo#HP:0410401 "Worse in evening"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueCodeableConcept = $hpo#HP:0003577 "Congenital onset"
* component[+].code = $hpo#HP:0003674 "Onset"
* component[=].valueQuantity = 0 http://some/unit/system#Day "Day"
* component[+].code = $OTHER#OTHER "Severity"
* component[=].valueCodeableConcept = $OTHER#OTHERTHING "Mild"

Instance: hpo-flat
InstanceOf: CodeSystem
Usage: #definition
* url = "http://github.com/phenopackets/core-ig/CodeSystem/hpo"
* version = "0.0.1"
* name = "HPO"
* title = "A stub HPO CodeSystem"
* status = #active
* experimental = true
* description = "A stub for the real HPO CodeSystem to use in other resources until we have a permanent HPO setup."
* hierarchyMeaning = #is-a
* content = #complete
* property[0].code = #synonym
* property[=].description = "Holds synonyms as strings"
* property[=].type = #string
* property[+].code = #xref
* property[=].description = "Holds references to other codes in the form of Coding. This could be done in ConceptMap as well and that would be more useful. This is just a demo for how this works."
* property[=].type = #Coding
* property[+].code = #parent
* property[=].uri = "http://hl7.org/fhir/concept-properties#parent"
* property[=].type = #code
* concept[0].code = #HP:0000001
* concept[=].display = "All"
* concept[+].code = #HP:0000118
* concept[=].display = "Phenotypic abnormality"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000001
* concept[+].code = #HP:0000707
* concept[=].display = "Abnormality of the nervous system"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000118
* concept[+].code = #HP:0003429
* concept[=].display = "CNS hypomyelination"
* concept[=].definition = "Reduced amount of myelin in the central nervous system resulting \n\t\tfrom defective myelinogenesis."
* concept[=].designation.language = #en
* concept[=].designation.use = $sct#900000000000013009 "Synonym"
* concept[=].designation.value = "hypomyelination"
* concept[=].property[0].code = #parent
* concept[=].property[=].valueCode = #HP:0000707
* concept[=].property[+].code = #synonym
* concept[=].property[=].valueString = "hypomyelination"
* concept[=].property[+].code = #xref
* concept[=].property[=].valueCoding = $umls#C0544820
* concept[=].property[+].code = #xref
* concept[=].property[=].valueCoding = $umls#C4025616
* concept[=].property[+].code = #xref
* concept[=].property[=].valueCoding = $sct#111007000
* concept[+].code = #HP:0001249
* concept[=].display = "Intellectual disability"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000707
* concept[+].code = #HP:0001298
* concept[=].display = "Encephalopathy"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000707
* concept[+].code = #HP:0000486
* concept[=].display = "Strabismus"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000118
* concept[+].code = #HP:0002650
* concept[=].display = "Scoliosis"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000118
* concept[+].code = #HP:0012823
* concept[=].display = "Clinical modifier"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000001
* concept[+].code = #HP:0012824
* concept[=].display = "Severity"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0012823
* concept[+].code = #HP:0012825
* concept[=].display = "Mild"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0012824
* concept[+].code = #HP:0012826
* concept[=].display = "Moderate"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0012824
* concept[+].code = #HP:0410401
* concept[=].display = "Worse in evening"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0012823
* concept[+].code = #HP:0031375
* concept[=].display = "Refractory"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0012823
* concept[+].code = #HP:0031797
* concept[=].display = "Clinical course"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000001
* concept[+].code = #HP:0003674
* concept[=].display = "Onset"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0031797
* concept[+].code = #HP:0003577
* concept[=].display = "Congenital onset"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0003674
* concept[+].code = #HP:0003623
* concept[=].display = "Neonatal onset"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0003674
* concept[+].code = #HP:0002664
* concept[=].display = "Neoplasm"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000118
* concept[+].code = #HP:0011793
* concept[=].display = "Neoplasm by anatomical site"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0002664
* concept[+].code = #HP:0001627
* concept[=].display = "Abnormal heart morphology"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0000118
* concept[+].code = #HP:0001671
* concept[=].display = "Abnormal cardiac septum morphology"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0001627
* concept[+].code = #HP:0011994
* concept[=].display = "Abnormal atrial septum morphology"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0001671
* concept[+].code = #HP:0011545
* concept[=].display = "Abnormal connection of the cardiac segments"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0001627
* concept[+].code = #HP:0011563
* concept[=].display = "Abnormal ventriculoarterial connection"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0011545
* concept[+].code = #HP:0001654
* concept[=].display = "Abnormal heart valve morphology"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0001627
* concept[+].code = #HP:0001641
* concept[=].display = "Abnormal pulmonary valve morphology"
* concept[=].property.code = #parent
* concept[=].property.valueCode = #HP:0001654

Instance: hpo
InstanceOf: CodeSystem
Usage: #definition
* url = "http://github.com/phenopackets/core-ig/CodeSystem/hpo"
* version = "0.0.1"
* name = "HPO"
* title = "A stub HPO CodeSystem"
* status = #active
* experimental = true
* description = "A stub for the real HPO CodeSystem to use in other resources until we have a permanent HPO setup."
* hierarchyMeaning = #is-a
* content = #complete
* property[0].code = #synonym
* property[=].description = "Holds synonyms as strings"
* property[=].type = #string
* property[+].code = #xref
* property[=].description = "Holds references to other codes in the form of Coding. This could be done in ConceptMap as well and that would be more useful. This is just a demo for how this works."
* property[=].type = #Coding
* property[+].code = #parent
* property[=].uri = "http://hl7.org/fhir/concept-properties#parent"
* property[=].type = #code
* concept.code = #HP:0000001
* concept.display = "All"
* concept.concept[0].code = #HP:0000118
* concept.concept[=].display = "Phenotypic abnormality"
* concept.concept[=].concept[0].code = #HP:0000707
* concept.concept[=].concept[=].display = "Abnormality of the nervous system"
* concept.concept[=].concept[=].concept[0].code = #HP:0003429
* concept.concept[=].concept[=].concept[=].display = "CNS hypomyelination"
* concept.concept[=].concept[=].concept[=].definition = "Reduced amount of myelin in the central nervous system resulting from defective myelinogenesis."
* concept.concept[=].concept[=].concept[=].designation.language = #en
* concept.concept[=].concept[=].concept[=].designation.use = $sct#900000000000013009 "Synonym"
* concept.concept[=].concept[=].concept[=].designation.value = "hypomyelination"
* concept.concept[=].concept[=].concept[=].property[0].code = #synonym
* concept.concept[=].concept[=].concept[=].property[=].valueString = "hypomyelination"
* concept.concept[=].concept[=].concept[=].property[+].code = #xref
* concept.concept[=].concept[=].concept[=].property[=].valueCoding = $umls#C0544820
* concept.concept[=].concept[=].concept[=].property[+].code = #xref
* concept.concept[=].concept[=].concept[=].property[=].valueCoding = $umls#C4025616
* concept.concept[=].concept[=].concept[=].property[+].code = #xref
* concept.concept[=].concept[=].concept[=].property[=].valueCoding = $sct#111007000
* concept.concept[=].concept[=].concept[+].code = #HP:0001249
* concept.concept[=].concept[=].concept[=].display = "Intellectual disability"
* concept.concept[=].concept[=].concept[+].code = #HP:0001298
* concept.concept[=].concept[=].concept[=].display = "Encephalopathy"
* concept.concept[=].concept[+].code = #HP:0000486
* concept.concept[=].concept[=].display = "Strabismus"
* concept.concept[=].concept[+].code = #HP:0002650
* concept.concept[=].concept[=].display = "Scoliosis"
* concept.concept[=].concept[+].code = #HP:0002664
* concept.concept[=].concept[=].display = "Neoplasm"
* concept.concept[=].concept[=].concept.code = #HP:0011793
* concept.concept[=].concept[=].concept.display = "Neoplasm by anatomical site"
* concept.concept[=].concept[+].code = #HP:0001627
* concept.concept[=].concept[=].display = "Abnormal heart morphology"
* concept.concept[=].concept[=].concept[0].code = #HP:0001671
* concept.concept[=].concept[=].concept[=].display = "Abnormal cardiac septum morphology"
* concept.concept[=].concept[=].concept[=].concept.code = #HP:0011994
* concept.concept[=].concept[=].concept[=].concept.display = "Abnormal atrial septum morphology"
* concept.concept[=].concept[=].concept[+].code = #HP:0011545
* concept.concept[=].concept[=].concept[=].display = "Abnormal connection of the cardiac segments"
* concept.concept[=].concept[=].concept[=].concept.code = #HP:0011563
* concept.concept[=].concept[=].concept[=].concept.display = "Abnormal ventriculoarterial connection"
* concept.concept[=].concept[=].concept[+].code = #HP:0001654
* concept.concept[=].concept[=].concept[=].display = "Abnormal heart valve morphology"
* concept.concept[=].concept[=].concept[=].concept.code = #HP:0001641
* concept.concept[=].concept[=].concept[=].concept.display = "Abnormal pulmonary valve morphology"
* concept.concept[+].code = #HP:0012823
* concept.concept[=].display = "Clinical modifier"
* concept.concept[=].concept[0].code = #HP:0012824
* concept.concept[=].concept[=].display = "Severity"
* concept.concept[=].concept[=].concept[0].code = #HP:0012825
* concept.concept[=].concept[=].concept[=].display = "Mild"
* concept.concept[=].concept[=].concept[+].code = #HP:0012826
* concept.concept[=].concept[=].concept[=].display = "Moderate"
* concept.concept[=].concept[+].code = #HP:0410401
* concept.concept[=].concept[=].display = "Worse in evening"
* concept.concept[=].concept[+].code = #HP:0031375
* concept.concept[=].concept[=].display = "Refractory"
* concept.concept[+].code = #HP:0031797
* concept.concept[=].display = "Clinical course"
* concept.concept[=].concept.code = #HP:0003674
* concept.concept[=].concept.display = "Onset"
* concept.concept[=].concept.concept[0].code = #HP:0003577
* concept.concept[=].concept.concept[=].display = "Congenital onset"
* concept.concept[=].concept.concept[+].code = #HP:0003623
* concept.concept[=].concept.concept[=].display = "Neonatal onset"

Instance: service-request-supporting-info
InstanceOf: SearchParameter
Usage: #definition
* url = "http://github.com/phenopackets/core-ig/SearchParameter/service-request-supporting-info"
* name = "ServiceRequestSupportingInfo"
* status = #active
* description = "Search ServiceRequest by supporting resource parameters"
* code = #supporting-info
* base = #ServiceRequest
* type = #reference
* expression = "ServiceRequest.supportingInfo"
* target = #Bundle
* comparator = #eq