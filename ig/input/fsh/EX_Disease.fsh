Instance: excluded-disease
InstanceOf: Disease
Description: "Phenopacket Example for an excluded disease"
* id = "id.disease.1"
* clinicalStatus = $ClinStatus#active "Active"
* code  = $sct#87628006  "Bacterial infectious disease"
* subject = Reference(example-patient)


Instance: vitreoretinochoroidopathy
InstanceOf: Disease
Description: "Phenopacket Example for autosomal dominant vitreoretinochoroidopathy"
* id = "id.disease.2"
* clinicalStatus = $ClinStatus#active "Active"
* code = $sct#711162004 "Autosomal dominant vitreoretinochoroidopathy (disorder)"
* subject = Reference(example-patient)

Instance: CHF-stageIII
InstanceOf: Disease
Description: "Congestive heart failure, New York Heart Association stage III"
* id = "id.disease.3"
* clinicalStatus = $ClinStatus#active "Active"
* code = $mondo#MONDO_0005009 "congestive heart failure"
* subject = Reference(example-patient)
* stage.summary = $efo#EFO:0003148 "moderate heart failure"
* stage.type = $sct#260998006 "Clinical staging"