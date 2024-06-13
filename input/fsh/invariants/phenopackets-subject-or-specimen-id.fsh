Invariant: phenopackets-subject-or-specimen-id // we may change the name of this invariant to be numbered. It was just kept to clearly reflect its purpose.
Description: "subject.id and/or specimen.id SHALL be present"
//Expression: "subject[Patient].identifier.exists() or specimen[Specimen].identifier.exists()" // we may need to revise this in corresponding patient and biosample mappings
Severity: #error
//XPath: ""//this is optional
