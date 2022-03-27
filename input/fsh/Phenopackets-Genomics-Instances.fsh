Instance: PhenopacketsVariantExample01
InstanceOf: PhenopacketsVariant // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Variant Example-1"
Description: "This is an example of phenopackets-genomic-interpretation 
              which is a phenopackets profile of the genomics reporting Variant profile. 
              It represents phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, 
              and VariantInterpretation building blocks."
//* id = "111.111.111.111"
* subject = Reference(phenopacketPatientExample01)  
* valueCodeableConcept = LNC#LA9633-4 "Present" 
// component[gene-studied]
* component[gene-studied].valueCodeableConcept.coding = HGNC#HGNC:3477 "ETF1"
//Place-holder for alternateIds
// component[ref-sequence-assembly]
* component[ref-sequence-assembly].valueCodeableConcept = LNC#LA26806-2 "GRCh38"
// component[cytogenetic-location]
* component[cytogenetic-location].valueCodeableConcept = LNC#LA21263-1 "10"
// component[exact-start-end]
* component[exact-start-end].valueRange.low.value = 121496701
* component[exact-start-end].extension[filterStatus].valueString = "PASS"
// component[coordinate-system]
* component[coordinate-system].valueCodeableConcept = LNC#LA30102-0 "1-based character counting"
// component[dbSNP-id]
* component[dbSNP-id].valueCodeableConcept = dbSNP#rs121918506 "rs121918506, FGFR2 : Missense Variant"
// component[ref-allele] 
* component[ref-allele].valueString = "T"
// component[alt-allele]
* component[alt-allele].valueString = "G"
// extension[acmgPathogenicity]
* extension[acmgPathogenicity].valueCodeableConcept.coding[0] = PPAPC#5  "PATHOGENIC"
// LOINC answerlist https://loinc.org/LL4034-6/
* extension[acmgPathogenicity].valueCodeableConcept.coding[+] = LNC#LA6668-3  "PATHOGENIC"
// extension[therapeuticActionability]
* extension[therapeuticActionability].valueCodeableConcept = PPTA#0  "UNKNOWN_ACTIONABILITY"
//extension[VrsObject]
* extension[VrsObject].valueAttachment.title =  "VrsObject Example"
// component[variation-code]
* component[variation-code].valueCodeableConcept = HGVS#NM_001144915.2 "NM_001144915.2:c.1427A>C"
// component[dna-chg]
// component[amino-acid-chg]
// component[genomic-dna-chg]
// extension[moleculeContext]
* extension[moleculeContext].valueCodeableConcept = PPMC#1 "genomic"
// component[functional-annotation]
* component[functional-annotation].valueCodeableConcept = SO#0001878 "feature_variant (SO:0001878)"
// component[allelic-state]
* component[allelic-state].valueCodeableConcept = GENO#0000135 "Heterozygous"

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
