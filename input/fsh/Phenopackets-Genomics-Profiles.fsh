Profile: PhenopacketsVariant
Parent: http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/variant // Genomics Reporting Variant profile
Id: phenopackets-variant
Title: "Phenopackets Variant"
Description: "A profile of Genomics Reporting Variant profile that represents relevant phenopackets building blocks."
* ^status = #draft // This would be changed later to active
* ^version = "0.1.0"
* ^date = "2021-10-18T06:00:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Aly Khalifa"
//Phenopackets GeneDescriptor
//This is a placeholder for all Must-support elements (MS)
// Placeholder for constrained elements of 0..0 cardinlaity
* component[gene-studied] 1..1
* component[gene-studied].valueCodeableConcept from https://www.genenames.org/ //This is already the default and extensible binding
//* component[gene-studied].valueCodeableConcept.coding.code from https://www.genenames.org/ // value_id => HGNC ID
//* component[gene-studied].valueCodeableConcept.coding.display from https://www.genenames.org/ //symbol => HGNC approved symbol
// component[gene-studied].valueCodeableConcept.coding.code from https://www.genenames.org/ //value_id => HGNC ID
//* component[gene-studied].valueCodableConcept.text from https://www.genenames.org/ //description => HGNC approved name
//* component[gene-studied].valueCodeableConcept.coding.system = https://www.genenames.org/ // "HUGO Gene Nomenclature Committee"
//alternate_ids and alternate_symbols would be additional codings.codes and codings.display
* component[gene-studied].extension contains RelatedConceptID named relatedConceptID 0..*

//Declaring an extension for xrefs
Extension: RelatedConceptID
Id: related-concept-id
Title: "Related Concept ID"
Description: "Used to provide identifiers to alternative resources representing related, but not equivalent concepts, for example gene ortholog ids"
* value[x] only Identifier
//* valueIdentifier 0..1 //We may not need to declare this

//Declaring an extension for additional identifier of the variant
Extension: AdditionalVariantIdentifier
Id: additional-variant-identifier
Title: "Additional Variant Identifier"
Description: "Used to  list of unique identifiers where available. If this is a dbSNP variant, component[dbSNP-id] should be used instead."
* value[x] only Identifier

//Declaring an extension for Phred score of alternative alleles
Extension: PhredQualityScore
Id: phred-quality-score
Title: "Phred Quality Score"
Description: "Used to include Phred-scaled quality score for the assertion made in ALT."
* value[x] only integer // Do you prefer another FHIR data type?

// Declaring an extension for the filter status
Extension: FilterStatus
Id: filter-status
Title: "Filter Status"
Description: "Filter status: PASS if this position has passed all filters." // More informative description may need to be added.
*  value[x] only CodeableConcept or string

//Phenopackets VcfRecord
* component[ref-sequence-assembly] 1..1 // genome_assembly
* component[cytogenetic-location] 1..1 // chrom
* component[exact-start-end] 1..1 // pos
* component[exact-start-end].extension contains FilterStatus named filterStatus 0..1 // filter. PASS if this position has passed all filters
* component[coordinate-system] 1..1 // pos
* component[dbSNP-id] 0..1 // id
// Used to  list of unique identifiers where available. If this is a dbSNP variant, component[dbSNP-id] should be used instead.
* component[dna-chg].extension contains AdditionalVariantIdentifier named additionalVariantIdentifier 0..*
* component[ref-allele] 1..1 // ref
//* component:genomic-ref-seq 0..1 // may be used to formally identify ref-sequence
* component[alt-allele] 1..1 // alt. Is it really one alternative allele?
* component[alt-allele].extension contains PhredQualityScore named phredQualityScore 0..1
//place holder for VcfRecord.info element. More discussions are needed.
* component[alt-allele].extension contains VCFInfo named vcfInfo 0..1

Extension: VCFInfo
Id: vcf-info
Title: "VCF Info"
Description: "Additional information: Semicolon-separated series of additional information fields from VCF info field."
* value[x] only string

Profile: PhenopacketsGenomicInterpretation
Parent: https://hl7.org/fhir/uv/genomics-reporting/genomics-report.html // Genomics Reporting Genomics Report profile
Id: phenopackets-genomic-interpretation
Title: "Phenopackets Genomic Interpretation"
Description: ""A profile of Genomics Reporting Genomics Report profile that represents relevant phenopackets building blocks.""
* ^status = #draft // This would be changed later to active
* ^version = "0.1.0"
* ^date = "2021-10-18T09:00:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Aly Khalifa"
//Phenopackets GenomicInterpretation

Invariant: phenopackets-subject-or-specimen-id // we may change the name of this invariant to be numbered. It was just kept to cleary reflect its purpose.
Description: "subject.id and/or specimen.id SHALL be presentsub"
Expression: "subject.identifier.exists() or specimen.identifier.exists()" // we may need to revise this in corresponding patient and biosample mappings
Severity: #error
XPath: ""












