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

Extension: DiagnosticMarker
Id: DiagnosticMarker
Title: "Diagnostic Marker"
Description: "Clinically relevant biomarkers. Most of the assays such as immunohistochemistry (IHC) are covered by the NCIT under the sub-hierarchy NCIT:C36292 (Laboratory Test Result), e.g. NCIT:C68748 (HER2/Neu Positive), NCIT:C131711 (Human Papillomavirus-18 Positive)."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from DiagnosticMarker (example)

Extension: HistologicalDiagnosis
Id: HistologicalDiagnosis
Title: "Histological Diagnosis"
Description: "This is the pathologist’s diagnosis and may often represent a refinement of the clinical diagnosis (which could be reported in the Phenopacket that contains this Biosample). Normal samples would be tagged with the term “NCIT:C38757”, “Negative Finding”."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from HistologicalDiagnosis (example)


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

Extension: MaterialSample
Id: MaterialSample
Title: "Material Sample"
Description: "Type of sample (diseases, control, etc.)"
* ^version = "0.1.0"
* ^date = "2021-05-28T17:06:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept

Extension: MeasurementExt
Id: MeasurementExt
Title: "Measurement (Biosample)"
Description: "Term representing a measurement made on a Biosample"
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* ^context.type = #element
* ^context.expression = "Specimen"
* value[x] only Reference(Measurement)

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


Extension: PathologicalStage
Id: PathologicalStage
Title: "Pathological Tumor Stage"
Description: "This element can be used if the phenopacket describes cancer. Tumor staging describes the extent of growth of cancer, including the tumor and, if applicable, affected lymph nodes and distant metastases. This element should not be confused with clinical stage."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from TumorStage (example)

Extension: PathologicalTnmFinding
Id: PathologicalTnmFinding
Title: " Pathological TNM Finding"
Description: "Pathological TNM findings, if applicable. Corresponds to pathological_tnm_finding (GA4GH)"
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from TumorStage (example)


Extension: PhenotypicFeatureExt
Id: PhenotypicFeatureExt
Title: "Phenotypic Feature (Biosample)"
Description: "Term representing phenotypic features of a Biosample"
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* ^context.type = #element
* ^context.expression = "Specimen"
* value[x] only Reference(PhenotypicFeature)


Extension: Taxonomy
Id: Taxonomy
Title: "Taxonomy"
Description: "Corresponds to taxonomy (GA4GH). For resources where there may be more than one organism being studied it is advisable to indicate the taxonomic identifier of that organism, to its most specific level."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Biosample"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from Taxonomy (required)


Extension: TumorGrade
Id: TumorGrade
Title: "Tumor Grade"
Description: "List of terms representing the tumor grade."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from TumorGrade (example)

Extension: TumorProgression
Id: TumorProgression
Title: "Tumor Progression"
Description: "This field can be used to indicate if a specimen is from the primary tumor, a metastasis or a recurrence. There are multiple ways of representing this using ontology terms, and the terms chosen should have a specific meaning that is application specific."
* ^version = "0.1.0"
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^context.type = #element
* ^context.expression = "Specimen"
* valueCodeableConcept only CodeableConcept
* valueCodeableConcept from TumorProgression (example)