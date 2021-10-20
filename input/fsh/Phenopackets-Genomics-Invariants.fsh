Invariant: phenopackets-subject-or-specimen-id // we may change the name of this invariant to be numbered. It was just kept to cleary reflect its purpose.
Description: "subject.id and/or specimen.id SHALL be presentsub"
Expression: "subject.identifier.exists() or specimen.identifier.exists()" // we may need to revise this in corresponding patient and biosample mappings
Severity: #error
//XPath: ""//this is optional
