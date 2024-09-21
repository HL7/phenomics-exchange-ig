Logical: MeasurementDataModel
Id: measurement-data-model
Title: "Measurement Data Model"
Description: """
    The measurement element is used to record individual measurements. 
    It can capture quantitative, ordinal (e.g., absent/present), or categorical measurements.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* description 0..1 string "free text."
* description ^comment = """
    Free-text description of the feature. 
    Note this is not a acceptable place to document/describe the phenotype
     - the type and onset etc… fields should be used for this purpose.
    """
* assay 1..1 OntologyClassDataModel "Class that describes the assay used to produce the measurement. REQUIRED."
* assay ^comment = """
    An ontology class which describes the assay used to produce the measurement. 
    For example “body temperature” (CMO:0000015) or “Platelets [#/volume] in Blood” (LOINC:26515-7) 
    FHIR mapping: Observation.code
    """
* measurement_value[x] 1..1 ValueDataModel or ComplexValueDataModel "The result of the measurement. REQUIRED." //needs to [x] to allow for Value or ComplexValue
* time_observed 0..1 TimeElementDataModel "Time at which measurement was performed. RECOMMENDED."
* time_observed ^comment = """
    The time at which the measurement was made.
    """
* procedure 0..1 ProcedureDataModel "Clinical procdure performed to acquire the sample used for the measurement" 
* procedure ^comment = """
    Clinical procedure performed on the subject in order to obtain the sample used for the measurement. 
    Examples include blood draw and biopsy. 
    If the procedure can be inferred from the measurement or if the details of the measurement 
    are deemed unimportant (e.g., a blood glucose test is performed on a blood sample obtained 
    with some procedure that is not specified), this element can be omitted.
    """ 