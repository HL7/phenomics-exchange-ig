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

Extension: VCFInfo
Id: vcf-info
Title: "VCF Info"
Description: "Additional information: Semicolon-separated series of additional information fields from VCF info field."
* value[x] only string

Extension: InterpretationStatus
Id: interpretation-status
Title: "Interpretation Status"
Description: "Describes the conclusion made about the genomic interpretation."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from PPIS (required)

Extension: AcmgPathogenicityClassification
Id: acmg-pathogenicity-classification
Title: "ACMG Pathogenicity Classification"
Description: "One of the five ACMG pathogenicity categories, default is UNCERTAIN_SIGNIFICANCE."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from PPAPC (required)

Extension: TherapeuticActionability
Id: therapeutic-actionability
Title: "Therapeutic Actionability"
Description: "one of the five ACMG pathogenicity categories, or NOT_PROVIDED. The default is NOT_PROVIDED."
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from PPTA (required)