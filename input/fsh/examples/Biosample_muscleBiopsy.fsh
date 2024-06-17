Instance: muscleBiopsy
InstanceOf: Biosample
Description: "Biosample Example -- muscle biopsy"
* id = "biosample.specimen.id.2"
* collection.bodySite = $uberon#UBERON_0001388  "gastrocnemius"
//* type =  $efo#EFO_0010942 "primary tumor sample"
* subject = Reference(Proband1)
* identifier.value = "arbitrary identifier"
* extension[MaterialSample].valueCodeableConcept = $efo#EFO_0009655 "abnormal sample"
* processing.procedure = $ncit#NCIT_C51895 "Muscle Biopsy"
* collection.collectedDateTime = "2021-01-20"
