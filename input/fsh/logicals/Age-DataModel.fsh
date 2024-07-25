Logical: AgeDataModel
Id: age-data-model
Title: "Age Data Model"
Description: """
    The Age element allows the age of the subject to be encoded in several different ways that support different use cases. 
    Age is encoded as ISO8601 duration.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-07-25"
* iso8601duration 1..1 string "An ISO8601 string represent age"
* iso8601duration ^comment = "If the Age message is used, the iso8601duration value must be present."