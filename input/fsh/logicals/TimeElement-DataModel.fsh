Logical: TimeElementDataModel
Id: time-element-data-model
Title: "TimeElement Data Model"
Description: """
    This element intends to bundle all of the various ways of denoting time or age in phenopackets schema. 
    Starting with version 2, other elements will be required to use a TimeElement rather than any of the more specific elements. 
    For instance, the version 1.0 of PhenotypicFeature uses an OntologyClass for the age of onset of the phenotypic feature. 
    Version 2 will replace this with a TimeElement. 
    This will mean that all references to time and age throughout the phenopacket standard are uniform. 
    That this change was needed became obvious when trying to model an acute phenotypic abnormality such as an episode of fever occurring one day before admission to the hospital.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-07-25"
* gestational_age 0..1 string "measure of the age of a pregnancy" // change type to GestationalAge
* gestational_age ^definition = """
    A measure of the age of a pregnancy. 
    Gestation, defined as the time between conception and birth, is measured in weeks and days from the first day of the last menstrual period. 
    See GestationalAge.
    """
* age 0..1 AgeDataModel "represents age as a ISO8601 duration (e.g., P40Y10M05D)."
* age ^definition = """
    This element can be used to represent age as a ISO8601 duration (e.g., P40Y10M05D). See Age.
    """
* age_range 0..1 AgeRangeDataModel "indicates that the individual's age lies within a given range"
* age_range ^definition = """
    This element can be used indicates that the individual's age lies within a given range, which may be desirable to help preserve privacy. 
    See AgeRange
    """
* ontology_class 0..1 OntologyClassDataModel "indicates the age of the individual as an ontology class" 
* ontology_class ^definition = """
    If an OntologyClass is used to represent the age of onset of a phenotypic feature, then terms for age of onset can be chosen from the Onset subhierarchy of the HPO. 
    See OntologyClass.
    """
* timestamp 0..1 TimestampDataModel "indicates a specific time"
* timestamp ^definition = """
    A Timestamp can be used to represent a specific time. 
    Note that all timestamps in a phenopacket can be shifted by the same amount to help preserve privacy if desired.
    """
* interval 0..1 TimeIntervaltDataModel "indicates an interval of time"
* interval ^definition = """
    This element can be used to represent a specific interval of time. 
    See TimeInterval.
    """