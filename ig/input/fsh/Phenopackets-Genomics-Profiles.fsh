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

