Logical: TimeIntervaltDataModel
Id: timeinterval-data-model
Title: "TimeInterval Data Model"
Description: """
    An time interval is meant to denote an interval of time whose begin and end is defined by Timestamp.
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* start 1..1 TimestampDataModel "begin of interval. REQUIRED."
* start ^comment = """
    The date and time of the start of the interval.
    """
* start ^example[0].label = "TimeInterval start"
* start ^example[0].valueString = "2020-03-15T13:00:00Z"
* end 1..1 TimestampDataModel "end of interval. REQUIRED."
* end ^comment = """
    The date and time of the end of the interval.
    """
* end ^example[0].label = "TimeInterval end"
* end ^example[0].valueString = "2020-03-25T09:00:00Z"