Profile: ObservationPhenotype
Parent: Observation
Id: phenotype
Title: "Phenotype Observation profile"
Description: "This profile defines a phenotype representation"

* code 1..1 MS
* code ^short = "A code representing the phenotype"

* value[x] 1..1 MS SU
* value[x] only CodeableConcept
* value[x] from http://loinc.org/vs/LL1937-3
* value[x] ^short = "An assertion for the presence or absence of the phenotype"
// * value[x] ^definition = "TODO: definition"
// * value[x] ^comment = "TODO: comment"
// * value[x] ^alias[+] = "First alias"
// * value[x] ^alias[+] = "Second alias"

// * component
* component ^short = "Phenotype components"
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code"
* component ^slicing.rules = #open

* component contains
    age-onset 0..1
* component[age-onset].code = TemporaryPhenotypeComponent#AGE_ONSET
* component[age-onset].value[x] only Quantity
* component[age-onset].value[x] 1..1
* component[age-onset] ^short = "The age of onset since birth, in the form of a quantity of time"

* component contains
    age-onset-range 0..1
* component[age-onset-range].code = TemporaryPhenotypeComponent#AGE_ONSET_RANGE
* component[age-onset-range].value[x] only Range
* component[age-onset-range].value[x] 1..1
* component[age-onset-range] ^short = "The age of onset since birth, in the form of a range of time"

* component contains
    age-onset-coded 0..1
* component[age-onset-coded].code = TemporaryPhenotypeComponent#AGE_ONSET_CODED
* component[age-onset-coded].value[x] only CodeableConcept
* component[age-onset-coded].value[x] 1..1
* component[age-onset-coded] ^short = "The age of onset since birth, in the form of a coded concept"

* component contains
    age-onset-gestational 0..1
* component[age-onset-gestational].code = TemporaryPhenotypeComponent#AGE_ONSET_GESTATIONAL
* component[age-onset-gestational].value[x] only Quantity
* component[age-onset-gestational].value[x] 1..1
* component[age-onset-gestational] ^short = "The gestational age of onset, in the form of a quantity of time"

* component contains
    qualifiers 0..*
* component[qualifiers].code = TemporaryPhenotypeComponent#QUALIFIER
* component[qualifiers].value[x] only CodeableConcept
* component[qualifiers].value[x] 1..1
* component[qualifiers] ^short = "Phenotype qualifiers"

* component contains
    age-resolution 0..1
* component[age-resolution].code = TemporaryPhenotypeComponent#AGE_RESOLUTION
* component[age-resolution].value[x] only Quantity
* component[age-resolution].value[x] 1..1
* component[age-resolution] ^short = "The age of resolution since birth, in the form of a quantity of time"

* component contains
    age-resolution-range 0..1
* component[age-resolution-range].code = TemporaryPhenotypeComponent#AGE_RESOLUTION_RANGE
* component[age-resolution-range].value[x] only Range
* component[age-resolution-range].value[x] 1..1
* component[age-resolution-range] ^short = "The age of resolution since birth, in the form of a range of time"

* component contains
    age-resolution-coded 0..1
* component[age-resolution-coded].code = TemporaryPhenotypeComponent#AGE_RESOLUTION_CODED
* component[age-resolution-coded].value[x] only CodeableConcept
* component[age-resolution-coded].value[x] 1..1
* component[age-resolution-coded] ^short = "The age of resolution since birth, in the form of a coded concept"

* component contains
    age-resolution-gestational 0..1
* component[age-resolution-gestational].code = TemporaryPhenotypeComponent#AGE_RESOLUTION_GESTATIONAL
* component[age-resolution-gestational].value[x] only Quantity
* component[age-resolution-gestational].value[x] 1..1
* component[age-resolution-gestational] ^short = "The gestational age of resolution, in the form of a quantity of time"