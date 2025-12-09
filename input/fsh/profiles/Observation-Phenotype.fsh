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
* value[x] ^definition = "TODO: definition"
* value[x] ^comment = "TODO: comment"
* value[x] ^alias[+] = "First alias"
* value[x] ^alias[+] = "Second alias"

* component
* component ^short = "Phenotype components"
* component ^slicing.discriminator.type = #value
* component ^slicing.discriminator.path = "code.coding"
* component ^slicing.rules = #open
* 
component contains
    gestational-age-onset 0..1
* component[gestational-age-onset].code.coding = $PhenotypeComponent#GESTATIONAL_AGE_ONSET
* component[gestational-age-onset].value[x] only Quantity
* component[gestational-age-onset] ^short = "The gestational age of onset, in the form of a quantity of time"

* component contains
    age-onset 0..1
* component[age-onset].code.coding = $PhenotypeComponent#AGE_ONSET
* component[age-onset].value[x] only Quantity
* component[age-onset] ^short = "The age of onset since birth, in the form of a quantity of time"

* component contains
    age-range-onset 0..1
* component[age-range-onset].code.coding = $PhenotypeComponent#AGE_RANGE_ONSET
* component[age-range-onset].value[x] only Range
* component[age-range-onset] ^short = "The age of onset since birth, in the form of a range of time"

* component contains
    age-onset-coded 0..1
* component[age-onset-coded].code.coding = $PhenotypeComponent#AGE_ONSET_CODED
* component[age-onset-coded].value[x] only CodeableConcept
* component[age-onset-coded] ^short = "The age of onset since birth, in the form of a coded concept"

