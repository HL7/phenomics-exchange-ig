Instance: CHF-with-severity
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for severe Low-output congestive heart failure"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0009805 "Low-output congestive heart failure"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"
* effectiveDateTime = "2018-03-06"
* component.code = $hpo#HP:0012824 "Severity"
* component.valueCodeableConcept = $hpo#HP:0012828 "Severe"
