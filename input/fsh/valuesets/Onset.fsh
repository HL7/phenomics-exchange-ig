ValueSet: Onset
Id: Onset
Title: "Onset ValueSet"
Description: "Set of HPO codes that denote the onset of a disease or phenotypic feature. The codes are descendants of Onset (HP:0003674) or from SNOMED_CT (282032007)."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
* insert ShareableValueSet
* insert SCT-copyright
* ^experimental = false
* ^date = "2021-06-03T10:26:00-04:00"
* include codes from system $hpo where concept is-a #HP:0003674
* include codes from system SNOMED_CT where concept descendent-of #282032007
