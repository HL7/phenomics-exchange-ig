ValueSet: ObservationCategories
Id: observation-categories
Title: "Observation categories"
Description: "ValueSet description here"
* ^status = #draft
* include codes from valueset $observation-category
* Categories#phenotype

ValueSet: KaryotypicSex
Id: KaryotypicSex
Title: "Karyotypic sex value set"
Description: "The karyotypic (chromosomal) sex of an individual"
* ^status = #active
* ^date = "2021-05-28T17:06:00-04:00"
* include codes from system KaryotypicSex

ValueSet: PhenotypicAbnormalityValueSet
Id: phenotypic-abnormality
Title: "Phenotypic abnormality ValueSet"
Description: "ValueSet description here"
* ^status = #active
* $hpo#HP:0000118

ValueSet: PhenotypicComponentValueSet
Id: phenotypic-component
Title: "Phenotypic component ValueSet"
Description: "ValueSet description here"
* ^status = #active
* $hpo#HP:0012823
* $hpo#HP:0012824
* $hpo#HP:0003674

ValueSet: PhenotypicModifierValueSet
Id: PhenotypicModifierValueSet
Title: "Phenotypic modifier ValueSet"
Description: "ValueSet description here"
* ^url = "http://github.com/phenopackets/core-ig/ValueSet/phenotypic-modifier"
* ^status = #active
* $hpo#HP:0012823
* include codes from system $hpo where concept is-a #HP:0012824

ValueSet: PhenotypicOnsetValueSet
Id: phenotypic-onset
Title: "Phenotypic onset ValueSet"
Description: "ValueSet description here"
* ^status = #active
* $hpo#HP:0003674
* $hpo#HP:0003623

ValueSet: PhenotypicSeverityValueSet
Id: phenotypic-severity
Title: "Phenotypic severity ValueSet"
Description: "ValueSet description here"
* ^status = #active
* $hpo#HP:0012824

ValueSet: Test
Id: test
Title: "test"
Description: "ValueSet description here"
* ^status = #draft
* include codes from system $hpo where concept is-a #HP:0000001