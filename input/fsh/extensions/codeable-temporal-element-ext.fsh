Extension: codeableTemporalElementExt
Id: codeable-temporal-element-ext
Title: "Codeable temporal element extension"
Description: """
    An extension to represent the value of a quantitative temporal element in the form of a concept.

    The extension is intentionally generic in nature. The meaning of the temporal concept is taken from
    the context it is used in, and the concepts used in the value should conceptually make sense in that context.
    This extension should be used on the most specific element possible so that the coded value can be interpreted
    withing that element.

    For example, it can be used on Observation.effective.valuePeriod.start have a coded start value.
"""
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^date = "2020-02-14T16:13:10+10:00"
//* ^context.type = #element
//* ^context.expression = "Observation"
* value[x] only CodeableConcept
