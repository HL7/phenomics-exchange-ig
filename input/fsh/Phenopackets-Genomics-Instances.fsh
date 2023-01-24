Instance: PhenopacketsVariantExample01
InstanceOf: PhenopacketsVariant // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Variant Example-1"
Description: "This is an example of phenopackets-genomic-interpretation 
              which is a phenopackets profile of the genomics reporting Variant profile. 
              It represents phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, 
              and VariantInterpretation building blocks."
* status = #final

Instance: PhenopacketsGenomicInterpretationExample01
InstanceOf: PhenopacketsGenomicInterpretation // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Genomic Interpretation Example-1"
Description: "This is an example of phenopackets-variant which is a phenopackets profile of 
              the genomics reporting Genomics Report profile. 
              It represents phenopackets GenomicInterpretation building block, i.e., the 
              interpretation for an individual variant or gene."
* specimen = Reference(phenopacketSpecimenExample01) // we may need to use a real specimen example
* subject = Reference(phenopacketPatientExample01)
* category = http://terminology.hl7.org/CodeSystem/v2-0074#GE "Genetics"
* id = "PhenopacketsGenomicInterpretationExample01" 
* modifierExtension[interpretationStatus].valueCodeableConcept = PPIS#0  "UNKNOWN_STATUS"
* result[variant] = Reference(PhenopacketsVariantExample01)
* conclusion = "The detected variant is Likely-Pathogenic of Pfeiffer syndrome"
* conclusionCode.coding = $sct#70410008 "Acrocephalosyndactyly type V (disorder)"
* code = http://loinc#123 "some loinc code"

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
* category = http://terminology.hl7.org/CodeSystem/v2-0074#GE "Genetics"
* id = "PhenopacketsGenomicInterpretationExample02" 
* modifierExtension[interpretationStatus].valueCodeableConcept = PPIS#0  "UNKNOWN_STATUS"
* result[variant] = Reference(PhenopacketsVariantExample01)
* conclusion = "A rare genetic form of obesity characterized by morbid obesity, hypertension, type 2 diabetes mellitus and dyslipidemia leading to early coronary disease, myocardial infarction and congestive heart failure. Intellectual disability and decreased sperm counts or azoospermia have also been reported."
* conclusionCode.coding = $sct#783549006 "Obesity due to centrosomal protein 19 deficiency (disorder)"
* code = http://loinc#123 "some loinc code"

Instance: phenopacketSpecimenExample01
InstanceOf: Specimen
Usage: #example
Title: "phenopacket Specimen Example01"
Description: " This is an incomplete example that used as 
               a placeholder for a curated specimen example"
* id = "phenopacketSpecimenExample01"               
* identifier.value = "01"
* identifier.use = #temp
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">This is an incomplete example that used as 
               a placeholder for a curated specimen example</div>"
* subject = Reference(phenopacketPatientExample01)               

Instance: phenopacketPatientExample01
InstanceOf: Patient
Usage: #example
Title: "phenopacket Patient Example01"
Description: "This is an example of a patient resource to be used in the assocaited patient examples. It is not representative of phenopackets patient's data representation"
* id = "phenopacketPatientExample01"
* identifier.value = "04"
* identifier.use = #temp
* name.given = "John"
* name.family = "Doe"
* gender = #unknown


Instance: PhenopacketPractitionerExample01
InstanceOf: Practitioner
Usage: #example
Title: "phenopacket Practitioner Example01"
Description: " This is an incomplete example that used as 
               a placeholder for a curated Practitioner example"
* id = "PhenopacketPractitionerExample01"               
* identifier.value = "03"
* identifier.use = #temp
* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">This is an incomplete example that used as 
               a placeholder for a curated Practitioner example</div>"
* name.text = "John T. Practitioner"  
