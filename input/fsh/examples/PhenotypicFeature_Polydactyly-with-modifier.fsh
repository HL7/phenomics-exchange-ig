Instance: Polydactyly-with-modifier
InstanceOf: PhenotypicFeature
Description: "Bilateral postaxial Polydactyly, example to demonstrate use of Clinical Modifier"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0001162 "Postaxial hand polydactyly"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"
* effectiveDateTime = "2022-09-18"
* component.code = $hpo#HP:0012823 "Clinical modifier"
* component.valueCodeableConcept = $hpo#HP:0012832 "Bilateral"
