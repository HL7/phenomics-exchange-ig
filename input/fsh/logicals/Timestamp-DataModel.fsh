Logical: TimestampDataModel
Id: timestamp-data-model
Title: "Timestamp Data Model"
Description: """
    In phenopackets we define the Timestamp as an ISO-8601 date time string.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* timestamp 1..1 string "An ISO-8601 date time string"
* timestamp ^comment = """
    The format for this is “{year}-{month}-{day}T{hour}:{min}:{sec}[.{frac_sec}]Z” 
    where {year} is always expressed using four digits while {month}, {day}, {hour}, {min}, 
    and {sec} are zero-padded to two digits each. 
    The fractional seconds, which can go up to 9 digits (i.e. up to 1 nanosecond resolution), are optional. 
    The “Z” suffix indicates the timezone (“UTC”); the timezone is required.
    """
* timestamp ^example[0].label = "Timestamp"
* timestamp ^example[0].valueString = "2021-06-02T16:52:15.01Z"