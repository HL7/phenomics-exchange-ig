Instance: bladderCarcinoma
InstanceOf: Biosample
Description: "Biosample Example for bladder carcinoma"
* id = "biosample.specimen.id.1"
* collection.bodySite = $uberon#UBERON_0001256  "wall of urinary bladder"
* type =  $efo#EFO_0010942 "primary tumor sample"
* subject = Reference(example-patient)
* identifier.value = "arbitrary identifier"
* extension[HistologicalDiagnosis].valueCodeableConcept =  $ncit#NCIT_C39853 "Infiltrating Urothelial Carcinoma"
* extension[TumorProgression].valueCoding = $ncit#NCIT_C84509 "Primary Malignant Neoplasm"
* extension[TumorGrade].valueCoding = $ncit#NCIT_C36136 "Grade 2 Lesion"
* extension[PathologicalStage].valueCoding = $ncit#NCIT_C28054 "Stage II"
* extension[PathologicalTnmFinding].valueCoding = $ncit#NCIT_C48726  "T2b Stage Finding"
* extension[PathologicalTnmFinding].valueCoding = $ncit#NCIT_C48705  "N0 Stage Finding"
* extension[PathologicalTnmFinding].valueCoding = $ncit#NCIT_C48699  "M0 Stage Finding"
* extension[MaterialSample].valueCoding = $efo#EFO_0009655 "abnormal sample"
* processing.procedure = $ncit#NCIT_C5189 "Radical Cystoprostatectomy"
* collection.collectedDateTime = "2021-01-20"
