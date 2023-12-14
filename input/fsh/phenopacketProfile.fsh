Profile: Phenopacket
Parent: Composition
Id: Phenopacket
Title: "Phenopacket profile"
Description: "This is the main element that represents the Phenopacket in FHIR."
* ^status = #draft
* identifier 1..1 MS 
* subject only Reference(Individual)
* section ^slicing.discriminator.type = #value
* section ^slicing.discriminator.path = "code"
* section ^slicing.ordered = true
* section ^slicing.rules = #closed
* section contains
    phenotypic_features 0..* and 
    measurements 0..* and 
    biosamples 0..* and
    interpretations 0..* and
    diseases 0..1 and
    files 0..* and
    medicalActions 0..*
* section[phenotypic_features].title = "phenotypic_features" (exactly)
* section[phenotypic_features].code = $SectionType#phenotypic_features
* section[phenotypic_features].entry only Reference(PhenotypicFeature)
* section[measurements].title = "measurements" (exactly)
* section[measurements].code = $SectionType#measurements
* section[measurements].entry only Reference(Measurement)
* section[biosamples].title = "biosamples" (exactly)
* section[biosamples].code = $SectionType#biosamples
* section[biosamples].entry only Reference(Biosample)
// Genomic component phenopackets-genomic-interpretation (PhenopacketsGenomicInterpretation)that may include one or more pehnopacket variant profiles
* section[interpretations] ^short = "represent the interpretation of a genomic analysis, such as the report from a diagnostic laboratory."
* section[interpretations].title = "interpretations" (exactly)
* section[interpretations].code = $SectionType#interpretations
* section[interpretations].entry only Reference(PhenopacketsGenomicInterpretation)
* section[diseases].title = "diseases" (exactly)
* section[diseases].code = $SectionType#diseases
* section[diseases].entry only Reference(Disease)
//placeholder for document reference
* section[files] ^short = "relevant documents and files."
* section[files].title = "files" (exactly)
* section[files].code = $SectionType#files
* section[files].entry only Reference(DocumentReference)
//placeholder for medical actions including procedures, medication statment,
* section[medicalActions] ^short = "relevant procedures, radiation therapies, therapeutic regimens, and treatments."
* section[medicalActions].title = "medicalActions" (exactly)
* section[medicalActions].code = $SectionType#medicalActions
* section[medicalActions].entry only Reference(Procedure or 
                                               Medication or 
                                               MedicationStatement or 
                                               MedicationDispense or 
                                               MedicationAdministration or 
                                               MedicationRequest)