Logical: AgeRangeDataModel
Id: age-range-data-model
Title: "AgeRange Data Model"
Description: """
    The AgeRange element is intended to be used when the age of a subject is represented by a bin, e.g., 5-10 years. 
    Bins such as this are used in some situations in order to protect the privacy of study participants, 
    whose age is then represented by bins such as 45-49 years, 50-54 years, 55-59 years, and so on.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-07-25"
* start 1..1 AgeDataModel "An Age message"
* end 1..1 AgeDataModel "An Age message"