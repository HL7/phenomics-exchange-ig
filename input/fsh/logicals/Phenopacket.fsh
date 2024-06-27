Logical: PhenopacketModel
Id: phenopacket-model
Title: "Phenopacket Logical Model"
Description: "Phenopacket LogicalModel"
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-05-29"
* id 1..1 string "arbitrary identifier. REQUIRED."
* subject 0..1 Reference "The proband. RECOMMENDED."
* phenotypic_features 0..* Reference(PhenotypicFeatureModel) "Phenotypic features observed in the proband. RECOMMENDED."
* measurements 0..* Reference "Measurements performed in the proband"
* biosamples 0..* Reference "samples (e.g., biopsies), if any"
* interpretations 0..* Reference "Interpretations related to this phenopacket"
* diseases 0..* Reference "Disease(s) diagnosed in the proband"
* medical_actions 0..* Reference "Medical actions performed"
* files 0..* Reference "list of files related to the subject, e.g. VCF or other high-throughput sequencing files"
* meta_data 1..1 BackboneElement "Information about ontologies and references used in the phenopacket. REQUIRED."

Logical: PhenotypicFeatureModel
Id: phenotypic-feature-model
Title: "PhenotypicFeature Logical Model"
Description: "PhenotypicFeature LogicalModel"
Characteristics: #can-be-target
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-05-29"
* description 0..1 string "human-readable verbiage NOT for structured text"
* type 1..1 BackboneElement "term denoting the phenotypic feature. REQUIRED."
  * id 1..1 string "a CURIE-style identifier e.g. HP:0001875. REQUIRED."
  * label 1..1 string "human-readable class name e.g. Neutropenia. REQUIRED."
* excluded 0..1 boolean "defaults to false"
* severity 0..1 BackboneElement "description of the severity of the feature described in type. For instance terms from HP:0012824"
* modifiers 0..* BackboneElement "For instance one or more terms from HP:0012823"
* onset 0..1 BackboneElement "Age or time at which the feature was first observed."
* resolution 0..1 BackboneElement "Age or time at which the feature resolved or abated."
* evidence 0..* Reference "the evidence for an assertion of the observation of a type. RECOMMENDED."

Mapping: PhenotypicFeature-FHIR
Id: FHIR
Title: "PhenotypicFeature LogicalModel FHIR Mapping"
Source: PhenotypicFeatureModel
* -> "Observation"
* type -> "Observation.code"