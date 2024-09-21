Profile: PhenotypicFeature
Parent: Observation
Id: PhenotypicFeature
Title: "Phenotypic Feature"
Description: "This is an Observation profile to represent a phenotypic feature (a phenotype) of a patient. It is inspired by and aligned with the [GA4GH PhenotypicFeature entity](https://phenopacket-schema.readthedocs.io/en/latest/phenotype.html)."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* code 1..1 MS
* value[x] only CodeableConcept
* value[x] from http://loinc.org/vs/LL1937-3 (required)
* value[x] 1..1 MS
* value[x] ^short = "LOINC code for presence absence"
* value[x] ^definition = "LOINC code for presence absence"
//* specimen ..0
//* device ..0
//* referenceRange ..0
//* hasMember ..0
* component MS
//* component ^short = "GA4GH severity and modifiers should be coded as CodeableConcepts in the code field of the component"

// See: https://build.fhir.org/ig/HL7/fhir-shorthand/reference.html#step-1-specify-the-slicing-logic
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open
* component ^slicing.description = "Phenotype modifiers"

// See: https://build.fhir.org/ig/HL7/fhir-shorthand/reference.html#step-2-define-the-slices
* component contains
    severity 0..1 and
    modifier 0..*

// See: https://build.fhir.org/ig/HL7/fhir-shorthand/reference.html#step-3-constrain-the-slice-contents
* component[severity] ^short = "The phenotype severity"
* component[severity].code = $hpo#HP:0012824 (exactly)
* component[severity].value[x] only CodeableConcept
* component[severity].value[x] from HpoSeverityVS (preferred)

* component[modifier] ^short = "Other phenotype modifiers"
* component[modifier].code = $hpo#HP:0012823
* component[modifier].value[x] only CodeableConcept
* component[modifier].value[x] from PhenotypicModifierValueSet (preferred)


// url: https://loinc.org/vs/LL6109-4