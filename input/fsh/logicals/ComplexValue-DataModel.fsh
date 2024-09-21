Logical: ComplexValueDataModel
Id: complex-value-data-model
Title: "ComplexValue Data Model"
Description: """
    This element is intended for complex measurements, 
    such as blood pressure where more than one component 
    quantity is required to describe the measurement.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* typed_quantities 1..* TypedQuantityDataModel "list of quantities required to fully describe the complex value. REQUIRED."