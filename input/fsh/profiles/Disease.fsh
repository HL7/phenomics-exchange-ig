Profile: Disease
Parent: Condition
Id: Disease
Title: "Disease profile"
Description: "This profile stipulates that a FHIR Condition must have a codeable concept that represents the disease. The concepts can be taken from various ontologies, but for rare-disease concepts, we recommend MONDO."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^status = #active
* ^date = "2021-06-03T09:49:00-04:00"
//* extension contains
//    CodedOnset named CodedOnset ..1 MS //and
//    TumorStage named TumorStage ..1 MS
//* code MS
//* subject MS
//* onset[x] MS
