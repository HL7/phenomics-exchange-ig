# Introduction

In the phenopacket-schema, A Phenopacket is an anonymous phenotypic description of an individual or biosample with potential genes of interest and/or diagnoses. It can be used for multiple use cases. For instance, it can be used to describe the phenotypic findings observed in an individual with a disease that is being studied or for an individual in whom the diagnosis is being sought. The phenopacket can contain information about genetic findings that are causative of the disease, or alternatively it can contain a reference to a VCF file if exome sequencing is being performed as a part of the differential diagnostic process. A Phenopacket can also be used to describe the constitutional phenotypic findings of an individual with cancer (a Biosample should be used to describe the phenotypic abnormalities directly associated with an extirpated or biopsied tumor). 


## The FHIR Condition and the GA4GH phenopacket-schema PhenotypicFeature

We represent the GA4GH phenopacket-schema ``PhenotypicFeature`` by profiling the standard FHIR [Condition](http://hl7.org/fhir/R4/condition.html).