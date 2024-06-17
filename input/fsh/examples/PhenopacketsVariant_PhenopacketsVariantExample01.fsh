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
* category[Genetics] = http://terminology.hl7.org/CodeSystem/v2-0074#GE "Genetics"
* modifierExtension[interpretationStatus].valueCodeableConcept = PPIS#0  "UNKNOWN_STATUS"
* result[variant] = Reference(PhenopacketsVariantExample01)
* conclusion = "The detected variant is Likely-Pathogenic of Pfeiffer syndrome"
* conclusionCode.coding = $sct#70410008 "Acrocephalosyndactyly type V (disorder)"
* code = http://loinc#123 "some loinc code"
