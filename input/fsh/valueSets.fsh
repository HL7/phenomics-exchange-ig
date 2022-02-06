ValueSet: DiagnosticMarker
Id: DiagnosticMarker
Title: "Diagnostic Marker"
Description: "Codes to indicate clinically relevant bio markers."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $ncit where concept descendent-of #NCIT:C36292

ValueSet: HistologicalDiagnosis
Id: HistologicalDiagnosis
Title: "HistologicalDiagnosis"
Description: "Histological diagnosis codes from NCIT."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $ncit where concept descendent-of #NCIT:C28101
* include codes from system $ncit where concept descendent-of #NCIT:C2991

ValueSet: KaryotypicSex
Id: KaryotypicSex
Title: "Karyotypic sex value set"
Description: "The karyotypic (chromosomal) sex of an individual"
* ^status = #active
* ^date = "2021-05-28T17:06:00-04:00"
* include codes from system KaryotypicSex


ValueSet: ObservationCategories
Id: observation-categories
Title: "Observation categories"
Description: "ValueSet description here"
* ^status = #draft
* include codes from valueset $observation-category
* Categories#phenotype


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


ValueSet: PhenotypicFeatureStatusValueSet
Id: phenotypicFeatureVS
Title: "Observation Codes for status of a PhenotypicFeature"
Description: "The LOINC codes for present if a feature is observed and absent if a feature was excluded."
* ^copyright = "This material contains content from LOINC (http://loinc.org). LOINC is copyright © 1995-2020, Regenstrief Institute, Inc. and the Logical Observation Identifiers Names and Codes (LOINC) Committee and is available at no cost under the license at http://loinc.org/license. LOINC® is a registered United States trademark of Regenstrief Institute, Inc"
* $LOINC#LA9633-4 "Present"
* $LOINC#LA9634-2 "Absent"



ValueSet: Onset
Id: Onset
Title: "Onset ValueSet"
Description: "Set of HPO codes that denote the onset of a disease or phenotypic feature. The codes are descendants of Onset (HP:0003674) or from SNOMED_CT (282032007)."
* ^status = #active
* ^version = "0.1.0"
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


ValueSet: Taxonomy
Id: Taxonomy
Title: "Taxonomy"
Description: "Taxonomic identifiers of an organism."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $ncbitaxon

ValueSet: TumorGrade
Id: TumorGrade
Title: "Tumor Grade"
Description: "Codes to indicate the grade of a tumor."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $ncit where concept descendent-of #NCIT:C28076

ValueSet: TumorProgression
Id: TumorProgression
Title: "Tumor Progression"
Description: "Codes to indicate if a specimen is from the primary tumor, a metastasis or a recurrence."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* $ncit#NCIT:C8509 "Primary Neoplasm"
* $ncit#NCIT:C3261 "Metastatic Neoplasm"
* $ncit#NCIT:C4798 "Recurrent Neoplasm"

ValueSet: TumorStage
Id: TumorStage
Title: "Tumor Stage"
Description: "Codes to represent the stage of a tumor."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* include codes from system $ncit where concept descendent-of #NCIT:C48232