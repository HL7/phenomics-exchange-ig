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

ValueSet: Onset
Id: Onset
Title: "Onset ValueSet"
Description: "Set of HPO codes that denote the onset of a disease or phenotypic feature. The codes are descendants of Onset (HP:0003674) or from SNOMED_CT (282032007)."
* ^status = #active
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T10:26:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* include codes from system $hpo where concept is-a #HP:0003674
* include codes from system SNOMED_CT where concept descendent-of #282032007


ValueSet: Severity
Id: Severity
Title: "Severity"
Description: "Phenotypic feature severity codes from the Human Phenotype Ontology and SNOMED CT."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $hpo where concept descendent-of #HP:0012824
* include codes from system SNOMED_CT where concept descendent-of #272141005


ValueSet: Test
Id: test
Title: "test"
Description: "ValueSet description here"
* ^status = #draft
* include codes from system $hpo where concept is-a #HP:0000001