ValueSet: HistologicalDiagnosis
Id: HistologicalDiagnosis
Title: "HistologicalDiagnosis"
Description: "Histological diagnosis codes from NCIT."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
* insert ShareableValueSet
* ^experimental = false
* ^date = "2020-02-14T16:13:10+10:00"
* include codes from system $ncit where concept descendent-of #NCIT:C28101
* include codes from system $ncit where concept descendent-of #NCIT:C2991
