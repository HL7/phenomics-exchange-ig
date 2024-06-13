Instance: phenotypic-abnormality-invalid-1
InstanceOf: Observation
Title: "An INVALID phenotypic abnormality Observation example."
Description: "An INVALID phenotypic abnormality Observation example."
Usage: #example
//* extension.url = "http://github.com/phenopackets/core-ig/ig-tools/validation-error-count"
//* extension.valueInteger = 4
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
