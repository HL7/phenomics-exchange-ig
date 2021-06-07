Instance: excluded-disease
InstanceOf: Disease
Description: "Phenopacket Example for an excluded disease"
* id = "id.1"
* clinicalStatus = $sct#315215002 "Disorder excluded (situation)"
* code  = $sct#87628006  "Bacterial infectious disease"
* subject = Reference(example-patient)


Instance: vitreoretinochoroidopathy
InstanceOf: Disease
Description: "Phenopacket Example for autosomal dominant vitreoretinochoroidopathy"
* id = "id.2"
* clinicalStatus = $ClinStatus#active "Active"
* code = $sct#711162004 "Autosomal dominant vitreoretinochoroidopathy (disorder)"
* subject = Reference(example-patient)

Instance: example-patient
InstanceOf: Patient
Description: "Example of Patient"
* identifier.use = #usual
* identifier.type = $IDTYPE#MR "Medical Record Number"
* identifier.system = "http://hospital.example.org"
* identifier.value = "m123"
* name.family = "Anyperson"
* name.given[0] = "Anyname"
* name.given[1] = "A."
* contact.telecom[0].system = #phone
* contact.telecom[0].value = "777-444-2222"
* contact.telecom[0].use = #home
* contact.telecom[1].system = #email
* contact.telecom[1].value = "anyname.anyperson@example.com"
* gender = #male
* birthDate = "2001-01-20"
* address.line = "123 Any St"
* address.city = "Anytown"
* address.postalCode = "12345"
* address.country = "US"
* communication.language = urn:ietf:bcp:47#en-US "English (Region=United States)"
* communication.language.text = "English"