Instance: arachnodactyly
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for arachnodactyly"
* id = "id.1"
* status = #active "active"
* subject = Reference(example-patient)
* code = $hpo#HP:0001166 "Arachnodactyly"
* valueBoolean = true


Instance: lvdysfunction-excluded
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for exclusion of LV dysfunction"
* id = "id.2"
* status = #active "active"
* subject = Reference(example-patient)
* code = $hpo#HP:0025168 "Left ventricular diastolic dysfunction"
* valueBoolean = false

Instance: MVP-with-onset
InstanceOf: PhenotypicFeature
Description: "PhenotypicFeature Example for mitral value prolapse with onset"
* id = "id.3"
* status = #active "active"
* subject = Reference(example-patient)
* code = $hpo#HP:0001634 "Mitral valve prolapse"
* valueBoolean = true
* effectiveDateTime = "2018-03-06"