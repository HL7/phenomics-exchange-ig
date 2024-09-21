Logical: TypedQuantityDataModel
Id: typed-quantity-data-model
Title: "TypedQuantity Data Model"
Description: """
    The Complex Value element consists of a list of TypedQuantity elements.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* type 1..1 OntologyClassDataModel "OntologyClass to describe the type of the measurement. REQUIRED."
* quantity 1..1 QuantityDataModel "Quantity denoting the outcome of the measurement. REQUIRED."