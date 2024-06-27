//we need to add the FHIR Clinical Genomics-Genomics Reporting Implementation Guide STU1 as a dependency
Profile: PhenopacketsVariant
Parent: http://hl7.org/fhir/uv/genomics-reporting/StructureDefinition/variant // Genomics Reporting Variant profile
Id: phenopackets-variant
Title: "Phenopackets Variant"
Description: "A profile of Genomics Reporting Variant profile that represents relevant phenopackets building blocks."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^status = #draft // This would be changed later to active
* ^date = "2021-10-18T06:00:00-04:00"
//* ^publisher = "GA4GH Phenopacket Working Group"
//* ^contact.name = "Aly Khalifa"
//* ^short = "A phenopackets profile of the genomics reporting Variant profile. It represents
            //phenopackets GeneDescriptor, VariationDescriptor, VcfRecord, and VariantInterpretation building blocks."
//This is a placeholder for all Must-support elements (MS). Based on a team discussion, all elements should be MS.
* value[x] ^slicing.discriminator.type = #type
* value[x] ^slicing.discriminator.path = "$this"
* value[x] ^slicing.rules = #closed
* value[x] only CodeableConcept
* valueCodeableConcept from http://loinc.org/vs/LL1971-2 (required)