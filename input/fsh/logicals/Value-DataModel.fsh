Logical: ValueDataModel
Id: value-data-model
Title: "Value Data Model"
Description: """
    The value element is meant to be used as part of the Measurement element, and it represents the outcome of a measurement.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* value[x] 1..1 QuantityDataModel or OntologyClassDataModel "the outcome (value) of a measurement. REQUIRED." // needs to be [x] because it can be either QuantityDataModel or OntologyClassDataModel
