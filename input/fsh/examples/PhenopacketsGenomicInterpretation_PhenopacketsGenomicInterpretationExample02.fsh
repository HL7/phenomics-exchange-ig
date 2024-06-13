Instance: PhenopacketsGenomicInterpretationExample02
InstanceOf: PhenopacketsGenomicInterpretation // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Genomic Interpretation Example-2"
Description: "This is an example of phenopackets-variant which is a phenopackets profile of
              the genomics reporting Genomics Report profile.
              It represents phenopackets GenomicInterpretation building block, i.e., the
              interpretation for an individual variant or gene."
* identifier.value = "02"
* specimen = Reference(phenopacketSpecimenExample01) // we may need to use a real specimen example
* subject = Reference(phenopacketPatientExample01)
* category[Genetics] = http://terminology.hl7.org/CodeSystem/v2-0074#GE "Genetics"
* modifierExtension[interpretationStatus].valueCodeableConcept = PPIS#0  "UNKNOWN_STATUS"
* result[variant] = Reference(PhenopacketsVariantExample01)
* conclusion = "A rare genetic form of obesity characterized by morbid obesity, hypertension, type 2 diabetes mellitus and dyslipidemia leading to early coronary disease, myocardial infarction and congestive heart failure. Intellectual disability and decreased sperm counts or azoospermia have also been reported."
* conclusionCode.coding = $sct#783549006 "Obesity due to centrosomal protein 19 deficiency (disorder)"
* code = http://loinc#123 "some loinc code"
