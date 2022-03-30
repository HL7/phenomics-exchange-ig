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
//* ^short = "A phenopackets profile of the genomics reporting Variant profile. It represents
            //phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, and VariantInterpretation building blocks."
//This is a placeholder for all Must-support elements (MS). Based on a team discussion, all elements should be MS.
* component[gene-studied] and 
component[ref-sequence-assembly] and 
component[cytogenetic-location] and
component[exact-start-end] and
component[coordinate-system] and
component[dbSNP-id] and
component[ref-allele] and
component[alt-allele] and
//extension[acmgPathogenicity] and // Moved down by the end of the profile
//extension[therapeuticActionability] and // Moved down by the end of the profile
component[variation-code] and
component[dna-chg] and
component[amino-acid-chg] and
component[genomic-dna-chg] and
// component[copy-number] and
// component[cytogenomic-nomenclature] and
//extension[moleculeContext] and // Moved down by the end of the profile
component[functional-annotation] and
component[allelic-state] MS // SU

// The invariant flags, are dictated autimatically by their presence, no need to explicitly declare them.
// Placeholder for constrained elements of 0..0 cardinlaity and mandatory elements in parent profile
// * bodySite 0..0
// * extension[observation-secondaryFinding] 0..0
// * basedOn 0..0
// * partOf 0..0
* status = #unknown /*This is 1..1 element in parent profile. This status code 
                    was selected to avoid providing any un-necessary information 
                    according to phenopackets V2 specification*/
* category 1..1 //This is 1..* element in parent profile.
//category.code = #laboratory //This is 1..1 element in parent profile and this is the fixed value. 
// code 1..1 //This is 1..1 element in parent profile as 1..1 with fixed value
// * focus 0..0
// * encounter 0..0
// * effectiveDateTime 0..0
// * issued 0..0
// * performer 0..0
//* valueCodeableConcept = LNC#LA9633-4 "Present" 
/*This is 1..1 element value[x] in parent profile as 1..1 and we selected #Present as a fixed value.*/
// * dataAbsentReason 0..0
// * note 0..0
// bodysite 0..0 //There are two elements of the same name, i.e., bodySite
// * method 0..0
// * specimen 0..0 //This may be modified later
// * device 0..0
// * referenceRange 0..0
// * hasMember 0..0
// * derivedFrom 0..0
// * component[dna-chg-type] 0..0 //This may be modified later.
// * component[genomic-source-class] 0..0 //This may be modified later.
// * component[amino-acid-chg-type] 0..0 //This may be modified later
// * component[transcript-ref-seq] 0..0 //This may be modified later
// * component[genomic-ref-seq] 0..0 //This may be modified later
// * component[sample-allelic-frequency] 0..0
// * component[allelic-read-depth] 0..0
// * component[copy-number] 0..0 //This may be modified later
// * component[variant-length] 0..0
// * component[outer-start-end] 0..0
// * component[inner-start-end] 0..0
// * component[chromosome-copy-number-change-type] 0..0	
// * component[arrCGH-ratio] 0..0
// * component[complex-var-type] 0..0
// * component[cytogenomic-nomenclature] 0..0 //This may be modified later
// * component[variant-inheritance] 0..0

// Placeholer for descriptions, i.e., ^short
* component[gene-studied] ^short = "Phenopackets GeneDescriptor: This element represents an identifier for a gene, 
                                    using the Gene Descriptor from the VRSATILE Framework."
* component[ref-sequence-assembly] ^short = "Phenopackets VcfRecord.genome_assembly: Identifier for the genome assembly 
                                             used to call the allele. REQUIRED."
* component[cytogenetic-location] ^short = "Phenopackets VcfRecord.chrom: Chromosome or contig identifier."
* component[exact-start-end] ^short = "Phenopackets VcfRecord.pos: The reference position, with the 1st base having position 1.
                                       Check component[coordinate-system]"
* component[coordinate-system] ^short = "Phenopackets VcfRecord.pos: The reference position, with the 1st base having position 1.
                                         Check component[exact-start-end]"
* component[dbSNP-id] ^short = "Phenopackets VcfRecord.id: If this is a dbSNP variant its number(s) should be used.
                                Check component:variation-code[valueCodeableConcept], component:genomic-dna-chg[valueCodeableConcept],
                                and component:amino-acid-chg[valueCodeableConcept] for relevant variant codes/ids."
* component[ref-allele] ^short = "Phenopackets VcfRecord.ref: Reference base"
* component[alt-allele] ^short = "Phenopackets VcfRecord.alt: Alternate base."

* component[variation-code] ^short = "Phenopackets VariationDescriptor primary (label + description) and 
                                      (alternate_labels) of the variation, if available. This is for a simple variant."
* component[dna-chg] ^short = "Phenopackets VariationDescriptor primary (label + description) and 
                                      (alternate_labels) of the variation, if available. This is for a single DNA marker."
* component[amino-acid-chg] ^short = "Phenopackets VariationDescriptor primary (label + description) and 
                                      (alternate_labels) of the variation, if available. This is for an amino acid change."
* component[genomic-dna-chg] ^short = "Phenopackets VariationDescriptor primary (label + description) and 
                                      (alternate_labels) of the variation, if available. This is for a structural variant."
// component[copy-number] ^short = "" //This is a place-holer if copy-number component will be considered in future
// component[cytogenomic-nomenclature] ^short = "" //This is a place-holer if cytogenomic-nomenclature component will be considered in future

* component[functional-annotation] ^short = "Phenopackets VariationDescriptor.structural_type: The structural variant type associated with 
                                             this variant, such as a substitution, deletion, or fusion. We RECOMMEND using 
                                             a descendent term of SO:0001537."
* component[allelic-state] ^short = "Phenopackets VariationDescriptor.allelic_state:The zygosity of the variant as determined in all of the samples represented in 
                                     this Phenopacket is represented using a list of terms taken from the Genotype 
                                     Ontology (GENO)."
//Phenopackets GeneDescriptor
* component[gene-studied] 1..1 //Also represents the VariationDescriptor.gene_context

//* component[gene-studied].valueCodeableConcept from https://www.genenames.org/ //This is already the default and extensible binding
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

//VariantInterpretation
* extension contains
    AcmgPathogenicityClassification named acmgPathogenicity 1..1
* extension contains
    TherapeuticActionability named therapeuticActionability 1..1
* extension contains
    VrsObject named vrsObject  0..1 // Variation as VRS
//place holder for VcfRecord.info element. More discussions are needed.
* extension contains VCFInfo named vcfInfo 0..1 //VcfRecord
* extension contains
    MoleculeContext named moleculeContext  1..1 // VariationDescriptor.molecule_context
//* extension[acmgPathogenicity] ^defaultValue[x] only CodeableConcept
//* extension[acmgPathogenicity] ^defaultValueCodeableConcept = PPAPC#0 "NOT_PROVIDED"
//* extension[therapeuticActionability] ^defaultValue[x] only CodeableConcept
//* extension[therapeuticActionability] ^defaultValueCodeableConcept = PPTA#0  "UNKNOWN_ACTIONABILITY"
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

/*component[variation-code].valueCodeableConcept is the attribute where one or more CURIE identifier could be added, 
    i.e. ID and alternate_ids as codings, while label would be the coding.display*/
//VRS object is modeled as extension of Attachment datatype as listed above
* component[variation-code].valueCodeableConcept.coding 1..*
//component[variation-code].valueCodeableConcept.text 0..1 //description
* component[dna-chg].valueCodeableConcept.coding 1..*
* component[genomic-dna-chg].valueCodeableConcept.coding 1..*
* component[amino-acid-chg].valueCodeableConcept.coding 1..*
//obeys phenopackets-primary-and-alternate-ids-or-labels
* component[variation-code].valueCodeableConcept obeys phenopackets-primary-and-alternate-ids-or-labels
* component[dna-chg].valueCodeableConcept obeys phenopackets-primary-and-alternate-ids-or-labels
* component[genomic-dna-chg].valueCodeableConcept obeys phenopackets-primary-and-alternate-ids-or-labels
* component[amino-acid-chg].valueCodeableConcept obeys phenopackets-primary-and-alternate-ids-or-labels
//VariationDescriptor.gene_context is represented above as component[gene-studied]
//VariationDescriptor.expressions is represented above as component[dna-chg].valueCodeableConcept-as one or more codings
//VariationDescriptor.vcf_record is represented above
* component[variation-code].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[dna-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[genomic-dna-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
* component[amino-acid-chg].extension contains RelatedConceptID named relatedConceptID 0..* //xref
//VariationDescriptor.alternate_labels is represented above as part of component[variation-code].valueCodeable
//VariationDescriptor.molecule_context is represented above as part of extension
//* extension[moleculeContext] ^defaultValue[x] only CodeableConcept
//* extension[moleculeContext] ^defaultValueCodeableConcept = PPMC#0  "unspecified_molecule_context" //molecule_context
* extension[moleculeContext] obeys phenopackets-moleculeContext-align-with-result-component
* component[functional-annotation].valueCodeableConcept from SequenceOntologyStructuralVariantVS (extensible) //structural_type
//VariationDescriptor.vrs_ref_allele_seq is represented above as part of component[ref-allele] and it is 1..1
* component[allelic-state].valueCodeableConcept from GenoOntologyAllelicStateVS (required) //allelic_state

* extension[acmgPathogenicity] and
extension[therapeuticActionability] and
extension[moleculeContext] MS // SU

* extension[acmgPathogenicity] ^short = "Phenopackets VariantInterpretation.acmg_pathogenicity_classification: One of the 
                                         five ACMG pathogenicity categories, default is UNCERTAIN_SIGNIFICANCE."
* extension[therapeuticActionability] ^short = "Phenopackets VariantInterpretation.therapeutic_actionability: The 
                                                therapeutic actionability of the variant, default is UNKNOWN_ACTIONABILITY."
* extension[moleculeContext] ^short = "Phenopackets VariationDescriptor.molecule_context: The molecular context of the vrs 
                                       variation."


Profile: PhenopacketsGenomicInterpretation
Parent: http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/genomics-report // Genomics Reporting Genomics Report profile
Id: phenopackets-genomic-interpretation
Title: "Phenopackets Genomic Interpretation"
Description: "A profile of Genomics Reporting Genomics Report profile that represents relevant 
              phenopackets building blocks."
* ^status = #draft // This would be changed later to active
* ^version = "0.1.0"
* ^date = "2021-10-18T09:00:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Aly Khalifa"
//* ^short = "A phenopackets profile of the genomics reporting Genomics Report profile. 
            //It represents phenopackets GenomicInterpretation building block, i.e., the interpretation for an 
            //individual variant or gene."
//Phenopackets GenomicInterpretation
* subject obeys phenopackets-subject-or-specimen-id
* specimen obeys phenopackets-subject-or-specimen-id
* subject 0..1 
* specimen 0..1 
* modifierExtension contains InterpretationStatus named interpretationStatus 1..1 // interpretation_status
* modifierExtension[interpretationStatus] ?!
* result[variant] 1..1 //this should be constrained to the newly developed variant profile, i.e., PhenopacketsVariant
* result[variant] only Reference(phenopackets-variant)
* subject and result[variant] MS // SU
* status = #unknown /*This is 1..1 element in parent profile. This status code 
                    was selected to avoid providing any un-necessary information 
                    according to phenopackets V2 specification*/
//* code = LNC#81247-9 "Master HL7 genetic variant reporting panel" /* This is 1..1 element in parent profile. LOINC may be asked to develop codes for phenopackets */
// Placeholer for descriptions, i.e., ^short
* subject ^short = "Phenopackets GenomicInterpretation.subject_or_biosample_id: The id of the patient 
                    or biosample that is the subject being interpreted.
                    Check specimen element."
* specimen ^short = "Phenopackets GenomicInterpretation.subject_or_biosample_id: The id of the patient 
                    or biosample that is the subject being interpreted.
                    Check subject element."
* modifierExtension[interpretationStatus] ^short = "Phenopackets GenomicInterpretation.interpretation_status: status of the interpretation."
* result[variant] ^short = "Phenopackets GenomicInterpretation.call: Represents the interpretation, 
                            i.e., oneof {GeneDescriptor|VariantInterpretation}."
//Place-holder for elements of 0..0 cardinality
// * extension[RelatedArtifact] 0..0
// * extension[RecommendedAction] 0..0
// * extension[SupportingInfo] 0..0
// * extension[risk] 0..0
// * basedOn 0..0
// * category 0..0
// * encounter 0..0
// * effectiveDateTime 0..0
// * issued 0..0
// * performer 0..0
// * resultsInterpreter 0..0
// * result[gen-grouper] 0..0
// * result[overall] 0..0
// * result[inh-dis-path] 0..0
// * result[som-diagnostic] 0..0
// * result[som-prognostic] 0..0
// * result[som-predictive] 0..0
// * result[med-metabolism] 0..0
// * result[med-efficacy] 0..0
// * result[med-transporter] 0..0
// * result[med-high-risk] 0..0
// * result[genotype] 0..0
// * result[haplotype] 0..0
// * result[sequence-phase-relation] 0..0
// * result[region-studied] 0..0
// * media 0..0
// * conclusion 0..0
// * conclusionCode 0..0
// * presentedForm 0..0

