ValueSet: PhenotypicModifierValueSet
Id: PhenotypicModifierValueSet
Title: "Phenotypic modifier ValueSet"
Description: "Human Phenotype Ontology (HPO) Clinical Modifier terms"
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^url = "http://github.com/phenopackets/core-ig/ValueSet/phenotypic-modifier"
* insert ShareableValueSet
* ^experimental = false
* $hpo#HP:0012823
* include codes from system $hpo where concept is-a #HP:0012824
