Extension: InterpretationStatus
Id: interpretation-status
Title: "Interpretation Status"
Description: "Describes the conclusion made about the genomic interpretation."
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
* value[x] only CodeableConcept
* valueCodeableConcept 1..1
* valueCodeableConcept from InterpretationStatusVS (required)
* . ^isModifier = true
* . ^isModifierReason = "The interpretation status could be REJECTED which may affect how the whole interpretation is interpreted."
