Logical: OntologyClassDataModel
Id: ontology-class-data-model
Title: "OntologyClass Data Model"
Description: """
    This element is used to represent classes (terms) from ontologies, and is used in many places throughout the Phenopacket standard. 
    It is a simple, two element message that represents the identifier and the label of an ontology class.
    The ID SHALL be a CURIE-style identifier e.g. HP:0100024, MP:0001284, UBERON:0001690, i.e., the primary key for the ontology class. 
    The label should be the corresponding class name. The Phenopacket standard REQUIRES that the id and the label match in the original ontology. 
    We note that occasionally, ontology maintainers change the primary label of a term.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-07-25"
* id 1..1 string "a CURIE-style identifier e.g. HP:0001875. REQUIRED."
* id ^definition = """
    The ID of an OntologyClass element MUST take the form of a CURIE format. 
    In order that the class is resolvable, it MUST reference the namespace prefix of a Resource named in the MetaData.
    """
* label 1..1 string "human-readable class name e.g. Neutropenia. REQUIRED."
* label ^definition = """
    The the human-readable label for the concept. 
    This MUST match the ID in the ontology referenced by the namespace prefix in a Resource named in the MetaData.
    """