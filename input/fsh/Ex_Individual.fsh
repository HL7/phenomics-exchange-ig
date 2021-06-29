Instance: example-patient
InstanceOf: Individual
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