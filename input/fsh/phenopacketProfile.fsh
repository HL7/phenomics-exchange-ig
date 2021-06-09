Profile: Phenopacket
Parent: Composition
Id: composition-phenopacket
Title: "Phenopacket profile"
Description: "This is the main element that represents the Phenopacket in FHIR."
* ^status = #draft
* id 1..1 MS 
* subject only Reference(Individual)
* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code"
* section ^slicing.ordered = true
* section ^slicing.rules = #closed
* section contains
    phenotypic_features 0..1 and 
    measurements 0..* and 
    biosamples 0..* and
    //interpretations 0..* and
    diseases 0..1
* section[phenotypic_features].title = "phenotypic_features" (exactly)
* section[phenotypic_features].code = $SectionType#phenotypic_features
* section[phenotypic_features].entry only Reference(PhenotypicFeature)
* section[measurements].title = "measurements" (exactly)
* section[measurements].code = $SectionType#measurements
* section[measurements].entry only Reference(Measurement)
* section[diseases].title = "diseases" (exactly)
* section[diseases].code = $SectionType#diseases
* section[diseases].entry only Reference(Disease)
* section[biosamples].title = "biosamples" (exactly)
* section[biosamples].code = $SectionType#biosamples
* section[biosamples].entry only Reference(Biosample)