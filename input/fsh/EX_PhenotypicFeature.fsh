Instance: arachnodactyly
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for arachnodactyly"
* id = "id.phenotypicfeature.1"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0001166 "Arachnodactyly"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"


Instance: lvdysfunction-excluded
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for exclusion of LV dysfunction"
* id = "id.phenotypicfeature.2"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0025168 "Left ventricular diastolic dysfunction"
* valueCodeableConcept = $LOINC#LA9634-2 "Absent"

Instance: MVP-with-onset
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for mitral value prolapse with onset"
* id = "id.phenotypicfeature.3"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0001634 "Mitral valve prolapse"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"
* effectiveDateTime = "2018-03-06"

Instance: CHF-with-severity
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for severe Low-output congestive heart failure"
* id = "id.phenotypicfeature.4"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0009805 "Low-output congestive heart failure"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"
* effectiveDateTime = "2018-03-06"
* component.code = $hpo#HP:0012824 "Severity"
* component.valueCodeableConcept = $hpo#HP:0012828 "Severe"


Instance: Polydactyly-with-modifier
InstanceOf: PhenotypicFeature
Description: "Bilateral postaxial Polydactyly, example to demonstrate use of Clinical Modifier"
* id = "id.bilateral-polydactyly.phenotypic-feature"
* status = #final "final"
* subject = Reference(example-patient)
* code = $hpo#HP:0001162 "Postaxial hand polydactyly"
* valueCodeableConcept = $LOINC#LA9633-4 "Present"
* effectiveDateTime = "2022-09-18"
* component.code = $hpo#HP:0012823 "Clinical modifier"
* component.valueCodeableConcept = $hpo#HP:0012832 "Bilateral"
