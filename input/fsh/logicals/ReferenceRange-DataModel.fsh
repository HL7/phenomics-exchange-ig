Logical: ReferenceRangeDataModel
Id: reference-range-data-model
Title: "ReferenceRange Data Model"
Description: """
    This elements is provided to support the Measurement element, 
    which can be used to report a numerical value such as LOINC:26515-7, Platelets [#/volume] in Blood. 
    The normal range for circulating platelets is 150,000 to 450,000 platelets per microliter.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* unit 1..1 OntologyClassDataModel "Ontology term describing the unit. REQUIRED."
* low 1..1 decimal "lower range of normal. REQUIRED."
* high 1..1 decimal "upper range of normal. REQUIRED."
