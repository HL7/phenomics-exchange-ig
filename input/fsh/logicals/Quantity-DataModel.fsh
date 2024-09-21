Logical: QuantityDataModel
Id: quantity-data-model
Title: "Quantity Data Model"
Description: """
    This element is meant to denote quantities of items such as medications. 
    The unit of a dose can be expressed with NCIT terms such as Milligram, Microgram, or Unit. 
    The value should be expressed as a number.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* unit 1..1 OntologyClassDataModel "The kind of unit. REQUIRED."
* unit ^comment = """
    Ontology terms for units can be taken from the National Cancer Institute Thesaurus (NCIT), 
    from the subhierarchy for Unit of Measure (Code C25709).
    """
* value 1..1 decimal "the value of the quantity in the units e.g. 2.0 mg. REQUIRED."
* value ^comment = """
    The corresponding value of the quantity in the indicated units.
    """
* reference_range 0..1 ReferenceRangeDataModel "the normal range for the value"
