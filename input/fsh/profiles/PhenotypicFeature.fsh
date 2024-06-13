Profile: PhenotypicFeature
Parent: Observation
Id: PhenotypicFeature
Title: "Phenotypic Feature"
Description: "This profile defines the GA4GH PhenotypicFeature element in terms of the FHIR Observation"
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
* specimen ..0
* device ..0
* referenceRange ..0
* hasMember ..0
* component MS
* component ^short = "GA4GH severity and modifiers should be coded as CodeableConcepts in the code field of the component"
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open
* component ^slicing.description = "Severity of Phenotypic Feature"
* component contains
    severity 0..1
//* component[severity] ^short = "Severity of phenotypic feature"
* component[severity].code.coding = $hpo#HP:0012824 "Severity"
* component[severity].value[x] only CodeableConcept
* component[severity].value[x] from HpoSeverityVS
* component ^slicing.discriminator.type = #pattern
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open
* component ^slicing.description = "Modifier of Phenotypic Feature"
* component ^slicing.ordered = false
* component contains
    modifier 0..
* component[modifier].code.coding = $hpo#HP:0012823 "Clinical modifier"
* component[severity].value[x] only CodeableConcept
* component[modifier].value[x] from PhenotypicModifierValueSet
