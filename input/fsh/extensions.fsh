Extension: ValidationErrorCountExt
Id: ext-validation-error-count
Title: "Validation error count"
Description: "An extension to use on any example resource to indicate count of number of validation errors expected based on the intended profile. This is a tooling related extension."
* ^status = #draft
* ^kind = #resource
* ^context.type = #element
* ^context.expression = "Resource"
//* . = "http://github.com/phenopackets/core-ig/ig-tools/validation-error-count" (exactly)
* value[x] only integer


Extension: KaryotypicSex
Id: KaryotypicSex
Title: "Karyotypic Sex"
Description: "Karyotypic sex of an individual (also known as chromosomal sex)."
* ^version = "0.1.0"
* ^date = "2021-05-28T17:06:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* ^context.type = #element
* ^context.expression = "Patient"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from KaryotypicSex (required)

Extension: Onset
Id: Onset
Title: "Onset"
Description: "Describes the age at which a phenotypic feature was first noticed or diagnosed."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Observation"
* value[x] only dateTime or string or Age or CodeableConcept or Period or Range

Extension: CodedOnset
Id: CodedOnset
Title: "Coded Onset"
Description: "The onset of a disease using an ontology class."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Condition"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from Onset (required)