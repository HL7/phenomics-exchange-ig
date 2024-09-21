Logical: ProcedureDataModel
Id: procedure-data-model
Title: "Procedure Data Model"
Description: """
    The Procedure element represents a clinical procedure performed on a subject. 
    For example a surgical or diagnostic procedure such as a biopsy.
    If the Procedure element is used, it must contain a code element, 
    but only need contain the body_site element if needed.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* code 1..1 OntologyClassDataModel "clinical procedure performed. REQUIRED."
* code ^comment = """
    This element is an OntologyClass that represents clinical procedure performed on a subject. 
    For instance, Biopsy of Soft Palate would be represented as follows.
    """
* bodySite 0..1 OntologyClassDataModel "specific body site where the procedure was performed"
* bodySite ^comment = """
    In cases where it is not possible to represent the procedure adequately with a single OntologyClass, 
    the body site should be indicated using a separate ontology class. 
    For instance, the following indicates a punch biopsy on the skin of the forearm.
    """
* performed 0..1 TimeElementDataModel "age/time when the procedure was performed"