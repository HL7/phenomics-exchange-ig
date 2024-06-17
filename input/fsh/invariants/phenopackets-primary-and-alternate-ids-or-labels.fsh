//Place-holder for primary identifier and alternate identifiers invariant
/* This invariant is to be used with: 
    - VariationDescriptor.label+description and VariationDescriptor.alternateLabels
    - GeneDescriptor.value_id+symbol and GeneDescriptor.alternate_symbols
*/
Invariant: phenopackets-primary-and-alternate-ids-or-labels
Description: "primary ID SHALL be present in this component, while alternate id/lables and their associated ids/lables
                 SHALL be added to it, if present. They SHALL be add as additional codings within the valueCodeableConcept
                 of this element/component"
//Expression: ""
Severity: #warning //Is it better to be #error?
//XPath: ""
