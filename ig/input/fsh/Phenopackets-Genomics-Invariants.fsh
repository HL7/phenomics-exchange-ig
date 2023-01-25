Invariant: phenopackets-subject-or-specimen-id // we may change the name of this invariant to be numbered. It was just kept to clearly reflect its purpose.
Description: "subject.id and/or specimen.id SHALL be present"
//Expression: "subject[Patient].identifier.exists() or specimen[Specimen].identifier.exists()" // we may need to revise this in corresponding patient and biosample mappings
Severity: #error
//XPath: ""//this is optional

//Place-holder for an invariant that links variation components and molecule context extension 
Invariant: phenopackets-moleculeContext-align-with-result-component
Description: "The extension[moleculeContext].value SHALL be aligned to the Variant results components for values 
                other than PPMC#0  'unspecified_molecule_context'. Where 
                - PPMC#1  'genomic' corresponds to variation-code; dna-chg; or genomic-dna-chg,
                - PPMC#2  'transcript' corresponds to variation-code; or dna-chg;
                - PPMC#3  'protein' corresponds to variation-code; or amino-acid-chg"
//Expression: ""
Severity: #error
//XPath: ""

Invariant: phenopackets-one-variation-identifier-component
Description: "Only one of the following components SHALL be used to describe the intended variation
                - component:variation-code
                - component:dna-chg
                - component:genomic-dna-chg.valueCodeableConcept
                - component:amino-acid-chg.valueCodeableConcept"
//Expression: ""
Severity: #error
//XPath: ""



//Place-holder for dbSNP-id variation identifier vs other CURIE identifiers invariant
Invariant: phenopackets-dbsnp-id-and-other-ids
Description: "component-dbSNP-id SHAll be used to represent dbSNP-ids. For other ids, corresponding components 
                SHALL be used"
//Expression: ""
Severity: #error
//XPath: ""

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


