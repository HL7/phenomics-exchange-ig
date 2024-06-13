Profile: Treatment
Parent: MedicationAdministration
Id: Treatment
Title: "Treatment"
Description: "This profile defines the GA4GH Treatment element in terms of the FHIR MedicationAdministration"
* insert Publisher
* insert SD-WG
* insert PR_CS_VS_Version
//* ^status = #active
* ^date = "2021-06-18T09:49:00-04:00"
* category MS
* category ^short = "Corresponds to drug_type (GA4GH)"
* medication[x] 1..1 MS
* effective[x] MS
* effective[x] ^short = "Information from effective and dosage is required for dose_intervals (GA4GH)"
* dosage MS
* dosage ^short = "Information from effective and dosage is required for dose_intervals (GA4GH)"
* dosage.route MS
* dosage.route ^short = "Corresponds to route_of_administration (GA4GH)"
