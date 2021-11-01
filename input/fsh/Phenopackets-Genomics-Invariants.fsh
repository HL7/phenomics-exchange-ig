Invariant: phenopackets-subject-or-specimen-id // we may change the name of this invariant to be numbered. It was just kept to cleary reflect its purpose.
Description: "subject.id and/or specimen.id SHALL be present"
Expression: "subject.identifier.exists() or specimen.identifier.exists()" // we may need to revise this in corresponding patient and biosample mappings
Severity: #error
//XPath: ""//this is optional

//Place-holder for an invariant that links variation components and molecule context extension 
Invariant: phenopackets-moleculeContext-align-with-result-component
Description: "The extension[moleculeContext].value SHALL be aligned the Variant results components for values 
                other than PPMC#0  'unspecified_molecule_context'. Where "
//Expression: ""
Severity: #error
//XPath: ""

//Place-holder for dbsnp-id variation identifier vs other CURIE identifiers invariant