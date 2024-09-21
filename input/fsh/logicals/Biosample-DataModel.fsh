Logical: BiosampleDataModel
Id: biosample-data-model
Title: "Biosample Data Model"
Description: """
    A Biosample refers to a unit of biological material from which the substrate molecules 
    (e.g. genomic DNA, RNA, proteins) for molecular analyses 
    (e.g. sequencing, array hybridisation, mass-spectrometry) are extracted. 
    Examples would be a tissue biopsy, a single cell from a culture for single cell 
    genome sequencing or a protein fraction from a gradient centrifugation. Several instances 
    (e.g. technical replicates) or types of experiments (e.g. genomic array as well as 
    RNA-seq experiments) may refer to the same Biosample.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* id 1..1 string "Arbitrary identifier. REQUIRED."
* individual_id 0..1 string "Arbitrary identifier. RECOMMENDED."
* derived_from_id 0..1 string "id of the biosample from which the current biosample was derived (if applicable)"
* description 0..1 string "arbitrary text"
* sampled_tissue 0..1 OntologyClassDataModel "Tissue from which the sample was taken"
* sample_type 0..1 OntologyClassDataModel "type of material, e.g., RNA, DNA, Cultured cells"
* phenotypic_features 0..* PhenotypicFeatureDataModel "List of phenotypic abnormalities of the sample. RECOMMENDED."
* measurements 0..* MeasurementDataModel "List of measurements of the sample"
* taxonomy 0..1 OntologyClassDataModel "Species of the sampled individual"
* time_of_collection 0..1 TimeElementDataModel "Age of the proband at the time the sample was taken. RECOMMENDED."
* histological_diagnosis 0..1 OntologyClassDataModel "Disease diagnosis that was inferred from the histological examination. RECOMMENDED."
* tumor_progression 0..1 OntologyClassDataModel "Indicates primary, metastatic, recurrent. RECOMMENDED."
* tumor_grade 0..1 OntologyClassDataModel "Term representing the tumor grade"
* pathological_stage 0..1 OntologyClassDataModel "Pathological stage, if applicable. RECOMMENDED."
* pathological_tnm_finding 0..* OntologyClassDataModel "Pathological TNM findings, if applicable. RECOMMENDED."
* diagnostic_markers 0..* OntologyClassDataModel "Clinically relevant biomarkers. RECOMMENDED."
* procedure 0..1 ProcedureDataModel "The procedure used to extract the biosample. RECOMMENDED."
* files 0..* FileDataModel "list of files related to the biosample, e.g. VCF or other high-throughput sequencing files"
* material_sample 0..1 OntologyClassDataModel "Status of specimen (tumor tissue, normal control, etc.). RECOMMENDED."
* sample_processing 0..1 OntologyClassDataModel "how the specimen was processed"
* sample_storage 0..1 OntologyClassDataModel "how the specimen was stored"