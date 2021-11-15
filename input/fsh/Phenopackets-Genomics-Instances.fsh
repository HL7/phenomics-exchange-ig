Instance: PhenopacketsVariantExample01
InstanceOf: PhenopacketsVariant // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Variant Example-1"
Description: "This is an example of phenopackets-genomic-interpretation 
              which is a phenopackets profile of the genomics reporting Variant profile. 
              It represents phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, 
              and VariantInterpretation building blocks."
* 

Instance: PhenopacketsGenomicInterpretationExample01
InstanceOf: PhenopacketsGenomicInterpretation // we may use the URL later to refer to this profile
Usage: #example // Should it be #inline? It is now #example to avoid any SUSHI compilation errors
Title: "Phenopackets Genomic Interpretation Example-1"
Description: "This is an example of phenopackets-variant which is a phenopackets profile of 
              the genomics reporting Genomics Report profile. 
              It represents phenopackets GenomicInterpretation building block, i.e., the 
              interpretation for an individual variant or gene."
* specimen = Reference(phenopacketSpecimenExample01) // we may need to use a real specimen example
* modifierExtension[interpretationStatus]= PPIS#0  "UNKNOWN_STATUS"
* result[variant] Reference(PhenopacketsVariantExample01)

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