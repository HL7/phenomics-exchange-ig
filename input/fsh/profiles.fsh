Profile: Biosample
Parent: Specimen
Id: Biosample
Title: "Biosample"
Description: "A unit of biological material from which the substrate molecules (e.g. genomic DNA, RNA, proteins) for molecular analyses (e.g. sequencing, array hybridisation, mass-spectrometry) are extracted."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-08T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* identifier 1..1 MS
* identifier ^short = "Corresponds to id (GA4GH)"
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
    PhenotypicFeatureExt named PhenotypicFeature 1.. MS and
    MeasurementExt named Measurement 1.. MS and
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



Profile: Disease
Parent: Condition
Id: Disease
Title: "Disease profile"
Description: "This profile stipulates that a FHIR Condition must have a codeable concept that represents the disease. The concepts can be taken from various ontologies, but for rare-disease concepts, we recommend MONDO."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
//* extension contains
//    CodedOnset named CodedOnset ..1 MS //and
//    TumorStage named TumorStage ..1 MS
//* code MS
//* subject MS
//* onset[x] MS

Profile: Individual
Parent: Patient
Id: Individual
Title: "Individual"
Description: "The subject of the Phenopacket is represented by an Individual element. This element intends to represent an individual human or other organism."
* ^version = "0.0.1"
* ^date = "2021-05-28T17:06:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* extension contains
 //   AgeOrAgeRange named AgeOrAgeRange ..1 MS and
    KaryotypicSex named KaryotypicSex 0..1 MS //and
//    Taxonomy named Taxonomy ..1 MS
* identifier MS
* gender MS
* birthDate MS


Profile: Measurement
Parent: Observation
Id: Measurement
Title: "Measurement"
Description: "This profile defines the GA4GH Measurement element in terms of the FHIR Observation"
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* identifier 0..0
* basedOn 0..0
* code 1..1 MS
* partOf 0..0
* category 0..0
* subject 0..0
* focus 0..0
* encounter 0..0
* issued 0..0
* performer 0..0
* dataAbsentReason 0..0

Profile: PhenotypicFeature
Parent: Observation
Id: PhenotypicFeature
Title: "Phenotypic Feature"
Description: "This profile defines the GA4GH PhenotypicFeature element in terms of the FHIR Condition"
* ^version = "0.1.0"
* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^contact.name = "Peter Robinson"
* code 1..1 MS
* value[x] only boolean
* value[x] 1..1 MS
* value[x] ^short = "true: observed; false: excluded"
* specimen ..0
* device ..0
* referenceRange ..0
* hasMember ..0
* component ..0

