Profile: Biosample
Parent: Specimen
Id: Biosample
Title: "Biosample"
Description: "A unit of biological material from which the substrate molecules (e.g. genomic DNA, RNA, proteins) for molecular analyses (e.g. sequencing, array hybridisation, mass-spectrometry) are extracted."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^status = #active
* ^date = "2021-06-08T09:49:00-04:00"
* identifier 1..1 MS
* identifier ^short = "Corresponds to id (GA4GH), i.e.,  a specimen identifier"
* type MS
* type ^short = "Corresponds to sample_type (GA4GH)"
* subject only Reference(Patient)
* subject MS
* subject ^short = "Patient.identifier corresponds to individual_id (GA4GH)"
* note MS
* note ^short = "Corresponds to description (GA4GH)"
* collection.bodySite MS
* collection.bodySite ^short = "Anatomical collection site. Corresponds to sampled_tissue (GA4GH)"
* extension contains
    Taxonomy named Taxonomy 0..1 MS and
    HistologicalDiagnosis named HistologicalDiagnosis 0.. MS and
    TumorProgression named TumorProgression 0..1 MS and
    TumorGrade named TumorGrade 0.. MS and
    PathologicalStage named PathologicalStage 0.. MS and
    PathologicalTnmFinding named PathologicalTnmFinding 0.. MS and
    DiagnosticMarker named DiagnosticMarker 0.. MS and
    MaterialSample named MaterialSample 0..1 MS
* collection.collected[x] MS
* collection.collected[x] ^short = "Corresponds to time_of_collection (GA4GH)"
* processing.procedure MS
* processing.procedure ^short = "Corresponds to procedure (GA4GH)"
