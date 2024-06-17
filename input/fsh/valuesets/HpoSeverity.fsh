ValueSet: HpoSeverityVS
Id: HpoSeverity
Title: "Hpo Severity Value Set"
Description: "The HPO codes for phenotypic feature severity"
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
* insert ShareableValueSet
* ^experimental = false
* ^date = "2022-09-19T16:13:10+10:00"
// This would be equivalent to the following* include codes from system $hpo where concept descendent-of #hpo:0012824
* $hpo#HP:0012828 "Severe"
* $hpo#HP:0012826 "Moderate"
* $hpo#HP:0012825 "Mild"
* $hpo#HP:0012827 "Borderline"
* $hpo#HP:0012829 "Profound"
