Logical: PhenotypicFeatureDataModel
Id: phenotypic-feature-data-model
Title: "PhenotypicFeature Data Model"
Description: "PhenotypicFeature Data Model"
Characteristics: #can-be-target
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-05-29"
* description 0..1 string "human-readable verbiage NOT for structured text"
* type 1..1 OntologyClassDataModel "term denoting the phenotypic feature. REQUIRED."
* excluded 0..1 boolean "defaults to false"
* severity 0..1 OntologyClassDataModel "description of the severity of the feature described in type. For instance terms from HP:0012824"
* modifiers 0..* OntologyClassDataModel "For instance one or more terms from HP:0012823"
* onset 0..1 TimeElementDataModel "Age or time at which the feature was first observed."
* resolution 0..1 TimeElementDataModel "Age or time at which the feature resolved or abated."
* evidence 0..* Reference "the evidence for an assertion of the observation of a type. RECOMMENDED."

Mapping: PhenotypicFeature-FHIR
Id: FHIR
Title: "PhenotypicFeature LogicalModel FHIR Mapping"
Source: PhenotypicFeatureDataModel
* -> "Observation"
* type -> "Observation.code"