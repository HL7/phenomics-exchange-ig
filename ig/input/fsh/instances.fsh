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