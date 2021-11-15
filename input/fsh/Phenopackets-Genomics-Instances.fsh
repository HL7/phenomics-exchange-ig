Instance: PhenopacketsVariantExample01
InstanceOf: PhenopacketsVariant // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Variant Example-1"
Description: "This is an example of phenopackets-genomic-interpretation 
              which is a phenopackets profile of the genomics reporting Variant profile. 
              It represents phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, 
              and VariantInterpretation building blocks."
// component[gene-studied]
* component[gene-studied].valueCodeableConcept.coding[HGNC] = HGNC#HGNC:3477 "ETF1"
//Place-holder for alternateIds
// component[ref-sequence-assembly]
* component[ref-sequence-assembly].valueCodeableConcept = LNC#LA26806-2 "GRCh38"
// component[cytogenetic-location]
* component[cytogenetic-location].valueCodeableConcept = LNC#LA21263-1 "10"
// component[exact-start-end]
* component[exact-start-end].valueRange.low = 121496701
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
* extension[acmgPathogenicity].valueCodeableConcept = PPAPC#5  "PATHOGENIC"
// extension[therapeuticActionability]
* extension[therapeuticActionability].valueCodeableConcept = PPTA#0  "UNKNOWN_ACTIONABILITY"
// component[variation-code]
* component[variation-code].valueCodeableConcept = HGVS#NM_001144915.2 "NM_001144915.2:c.1427A>C"
// component[dna-chg]
// component[amino-acid-chg]
// component[genomic-dna-chg]
// extension[moleculeContext]
* extension[moleculeContext].valueCodeableConcept = PPMC#1  "genomic"
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
* modifierExtension[interpretationStatus].valueCodeableConcept = PPIS#0  "UNKNOWN_STATUS"
* result[variant] = Reference(PhenopacketsVariantExample01)

Instance: phenopacketSpecimenExample01
InstanceOf: Specimen
Usage: #example
Title: "phenopacket Specimen Example01"
Description: " This is an incomplete example that used as 
               a placeholder for a curated specimen example"
* id = "01"               
* identifier.value = "01"
* text = " This is an incomplete example that used as 
               a placeholder for a curated specimen example"