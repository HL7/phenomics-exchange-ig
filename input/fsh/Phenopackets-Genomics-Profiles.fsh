//we need to add the FHIR Clinical Genomics-Genomics Reporting Implementation Guide STU1 as a dependency
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
//This is a placeholder for all Must-support elements (MS). Based on a team discussion, all elements should be MS.
* component[gene-studied] and 
component[ref-sequence-assembly] and 
component[cytogenetic-location] and
component[exact-start-end] and
component[coordinate-system] and
component[dbSNP-id] and
component[ref-allele] and
component[alt-allele] and
extension[acmgPathogenicity] and
extension[therapeuticActionability] and
component[variation-code] and
component[dna-chg] and
component[amino-acid-chg] and
component[genomic-dna-chg] and
// component[copy-number] and
// component[cytogenomic-nomenclature] and
extension[moleculeContext] and
component[functional-annotation] and
component[allelic-state] MS SU

// The invariant flags, are dictated autimatically by their presence, no need to explicitly declare them.
// Placeholder for constrained elements of 0..0 cardinlaity

// Placeholer for descriptions, i.e., ^short
* component[gene-studied] 1..1 //Also represents the VariationDescriptor.gene_context
* component[gene-studied].valueCodeableConcept from https://www.genenames.org/ //This is already the default and extensible binding
* component[gene-studied].valueCodeableConcept obeys phenopackets-primary-and-alternate-ids-or-labels
//* component[gene-studied].valueCodeableConcept.coding.code from https://www.genenames.org/ // value_id => HGNC ID
//* component[gene-studied].valueCodeableConcept.coding.display from https://www.genenames.org/ //symbol => HGNC approved symbol
// component[gene-studied].valueCodeableConcept.coding.code from https://www.genenames.org/ //value_id => HGNC ID
//* component[gene-studied].valueCodeableConcept.text from https://www.genenames.org/ //description => HGNC approved name
//* component[gene-studied].valueCodeableConcept.coding.system = https://www.genenames.org/ // "HUGO Gene Nomenclature Committee"
//alternate_ids and alternate_symbols would be additional codings.codes and codings.display
* component[gene-studied].extension contains RelatedConceptID named relatedConceptID 0..* //xref

//Phenopackets VcfRecord
* component[ref-sequence-assembly] 1..1 // genome_assembly
* component[cytogenetic-location] 1..1 // chrom
* component[exact-start-end] 1..1 // pos
* component[exact-start-end].extension contains FilterStatus named filterStatus 0..1 // filter. PASS if this position has passed all filters
* component[coordinate-system] 1..1 // pos
* component[dbSNP-id] 0..1 // id
// Used to  list of unique identifiers where available. If this is a dbSNP variant, component[dbSNP-id] should be used instead. Other IDs could be used by various variation components, e.g.,  using HGVS
* component[dbSNP-id] obeys phenopackets-dbsnp-id-and-other-ids

* component[ref-allele] 1..1 // ref
//* component:genomic-ref-seq 0..1 // may be used to formally identify ref-sequence
* component[alt-allele] 1..1 // alt. Is it really one alternative allele?
* component[alt-allele].extension contains PhredQualityScore named phredQualityScore 0..1
//place holder for VcfRecord.info element. More discussions are needed.
* component[alt-allele].extension contains VCFInfo named vcfInfo 0..1 //VcfRecord
//VariantInterpretation
* extension contains
    AcmgPathogenicityClassification named acmgPathogenicity 1..1
    TherapeuticActionability named therapeuticActionability 1..1
    VrsObject named vrsObject  1..1 // Variation as VRS
    MoleculeContext named moleculeContext  1..1 // VariationDescriptor.molecule_context
* extension[acmgPathogenicity] ^defaultValue[x] only CodeableConcept
* extension[acmgPathogenicity] ^defaultValueCodeableConcept = PPAPC#0 "NOT_PROVIDED"
* extension[therapeuticActionability] ^defaultValue[x] only CodeableConcept
* extension[therapeuticActionability] ^defaultValueCodeableConcept = PPTA#0  "UNKNOWN_ACTIONABILITY"
//VariationDescriptor
* component[amino-acid-chg] 0..1 //protein variations
* component[genomic-dna-chg] 0..1 //genomic variations, structural variants
//* component[copy-number] 0..1 //copy number variation
* component[variation-code] 0..1 //for simple variants. "This term is used to report the unique identifier of the simple variant found in this study."
//* component[cytogenomic-nomenclature] 0..1 //"Fully describes a variant with a single code. Typically a large variant such as a mosaic, abnormal chromosome numbers,"
* component[dna-chg] 0..1 //transcript variations
* component[dna-chg].extension contains AdditionalVariantIdentifier named additionalVariantIdentifier 0..*
//obeys phenopackets-one-variation-identifier-component
* component[variation-code] obeys phenopackets-one-variation-identifier-component
* component[dna-chg] obeys phenopackets-one-variation-identifier-component
* component[genomic-dna-chg] obeys phenopackets-one-variation-identifier-component
* component[amino-acid-chg] obeys phenopackets-one-variation-identifier-component
//obeys phenopackets-moleculeContext-align-with-result-component
* component[variation-code] obeys phenopackets-moleculeContext-align-with-result-component
* component[dna-chg] obeys phenopackets-moleculeContext-align-with-result-component
* component[genomic-dna-chg] obeys phenopackets-moleculeContext-align-with-result-component
* component[amino-acid-chg] obeys phenopackets-moleculeContext-align-with-result-component

/*component[variation-code].valueCodeable is the attribute where one or more CURIE identifier could be added, 
    i.e. ID and alternate_ids as codings, while label would be the coding.display*/
//VRS object is modeled as extension of Attachment datatype as listed above
* component[variation-code].valueCodeable.coding 1..*
//component[variation-code].valueCodeable.text 0..1 //description
* component[dna-chg].valueCodeable.coding 1..*
* component[genomic-dna-chg].valueCodeable.coding 1..*
* component[amino-acid-chg].valueCodeable.coding 1..*
//obeys phenopackets-primary-and-alternate-ids-or-labels
* component[variation-code].valueCodeable obeys phenopackets-primary-and-alternate-ids-or-labels
* component[dna-chg].valueCodeable obeys phenopackets-primary-and-alternate-ids-or-labels
* component[genomic-dna-chg].valueCodeable obeys phenopackets-primary-and-alternate-ids-or-labels
* component[amino-acid-chg].valueCodeable obeys phenopackets-primary-and-alternate-ids-or-labels
//VariationDescriptor.gene_context is represented above as component[gene-studied]
//VariationDescriptor.expressions is represented above as component[dna-chg].valueCodeableConcept-as one or more codings
//VariationDescriptor.vcf_record is represented above
* component[variation-code].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[dna-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[genomic-dna-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[amino-acid-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
//VariationDescriptor.alternate_labels is represented above as part of component[variation-code].valueCodeable
//VariationDescriptor.molecule_context is represented above as part of extension
* extension[moleculeContext] ^defaultValue[x] only CodeableConcept
* extension[moleculeContext] ^defaultValueCodeableConcept = PPMC#0  "unspecified_molecule_context" //molecule_context
* extension[moleculeContext] obeys phenopackets-moleculeContext-align-with-result-component
* component[functional-annotation].valueCodeableConcept from SequenceOntologyStructuralVariantVS (preferred) //structural_type
//VariationDescriptor.vrs_ref_allele_seq is represented above as part of component[ref-allele] and it is 1..1
* component[allelic-state].valueCodeableConcept from GenoOntologyAllelicStateVS (required) //allelic_state



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
* subject 0..1 obeys phenopackets-subject-or-specimen-id
* specimen 0..1 obeys phenopackets-subject-or-specimen-id
* modifierExtension contains 
    InterpretationStatus named interpretationStatus 1..1 // interpretation_status
* modifierExtension[interpretationStatus] ?!
* result[variant] 1..1 //this should be constrained to the newly developed variant profile, i.e., PhenopacketsVariant
* result[variant] Reference(phenopackets-variant)
* subject and specimen and result[variant] MS SU
* status = #unknown /*This is 1..1 element in parent profile. This status code 
                    was selected to avoid providing any un-necessary information 
                    according to phenopackets V1 specification*/
* code = LNC#phenopackets-genomic-interpretation // This is 1..1 element in parent profile. This is a hypothetical LOINC code. LOINC may be asked to develop codes for phenopackets
//Place-holder for elements of 0..0 cardinality
* RelatedArtifact 0..0
* RecommendedAction 0..0
* SupportingInfo 0..0
* diagnosticReport-risk 0..0
* basedOn 0..0
* category 0..0
* encounter 0..0
* effective[x] 0..0
* issued 0..0
* performer 0..0
* resultsInterpreter 0..0
* result[gen-grouper] 0..0
* result[overall] 0..0
* result[inh-dis-path] 0..0
* result[som-diagnostic] 0..0
* result[som-prognostic] 0..0
* result[som-predictive] 0..0
* result[med-metabolism] 0..0
* result[med-efficacy] 0..0
* result[med-transporter] 0..0
* result[med-high-risk] 0..0
* result[genotype] 0..0
* result[haplotype] 0..0
* result[sequence-phase-relation] 0..0
* result[region-studied] 0..0
* media 0..0
* conclusion 0..0
* conclusionCode 0..0
* presentedForm 0..0

