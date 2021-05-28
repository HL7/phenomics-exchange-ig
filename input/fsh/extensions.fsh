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