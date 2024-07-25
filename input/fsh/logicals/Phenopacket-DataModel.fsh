Logical: PhenopacketDataModel
Id: phenopacket-data-model
Title: "Phenopacket Data Model"
Description: "Phenopacket Data Model"
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-05-29"
* id 1..1 string "arbitrary identifier. REQUIRED."
* subject 0..1 Reference "The proband. RECOMMENDED."
* phenotypic_features 0..* Reference(PhenotypicFeatureDataModel) "Phenotypic features observed in the proband. RECOMMENDED."
* measurements 0..* Reference "Measurements performed in the proband"
* biosamples 0..* Reference "samples (e.g., biopsies), if any"
* interpretations 0..* Reference "Interpretations related to this phenopacket"
* diseases 0..* Reference "Disease(s) diagnosed in the proband"
* medical_actions 0..* Reference "Medical actions performed"
* files 0..* Reference "list of files related to the subject, e.g. VCF or other high-throughput sequencing files"
* meta_data 1..1 BackboneElement "Information about ontologies and references used in the phenopacket. REQUIRED."
