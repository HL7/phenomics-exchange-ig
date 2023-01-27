# GA4GH Phenopackets

The [Global Alliance for Genomics and Health](https://www.ga4gh.org/) (GA4GH) Phenopacket standard intendds to support global exchange of computable case-level phenotypic information for all types of disease diagnosis and research. The Phenopacket standard is a freely available, community-driven standard that streamlines exchange and systematic use of phenotypic data, which will enable sophisticated computational analysis of both clinical and genomic information to help improve our understanding of diseases and our ability to manage them.

A Phenopacket represents an individual proband or patient and includes information about the individual such as age (which can be represented in multiple ways including ranges to protect privacy) and sex, any existing disease diagnoses. Almost all elements of a Phenopacket are optional. A simple Phenopacket containing only information about the proband and a list of phenotypic features is all that is required for use cases of Mendelian genomic disease diagnostics. More comprehensive Phenopackets containing additional data about biosamples and treatment may be appropriate for use cases surrounding rare disease, common/complex disease, or cancer.

The schema as well as source code in Java, C++, and Python is available from the phenopacket-schema [GitHub repository](https://github.com/phenopackets/phenopacket-schema).

The phenopacket schema is being developed under the auspices of the Global Alliance for Genomics and Health, [GA4GH](https://www.ga4gh.org/). The native version is developed using Google's [Protocol buffers](https://developers.google.com/protocol-buffers), i.e., protobuf (version 3).


# GA4GH Phenopacket FHIR Implementation Guide

This implementation guide is a set of rules about how FHIR resources are used (or should be used) to implement Phenopackets in an EHR setting. The focus of this IG is to support rare disease use cases.


### Understanding FHIR (Prerequisite)

This implementation guide uses terminology, notations and design principles that are specific to FHIR. Before reading this implementation guide, its important to be familiar with some of the basic principles of FHIR as well as general guidance on how to read FHIR specifications. Readers who are unfamiliar with FHIR are encouraged to read (or at least skim) the following prior to reading the rest of this implementation guide.

- [FHIR overview](http://hl7.org/fhir/overview.html)
- [Developer's Introduction](http://hl7.org/fhir/overview-dev.html)
- [Clinical Introduction](http://hl7.org/fhir/overview-clinical.html)
- [FHIR data types](http://hl7.org/fhir/datatypes.html)
- [Using codes](http://hl7.org/fhir/terminologies.html)
- [References between resources](http://hl7.org/fhir/references.html)
- [How to read resource and profile definitions](http://hl7.org/fhir/formats.html)
- [Base resource](http://hl7.org/fhir/resource.html)

This implementation guide builds on FHIR v4.0.1: R4.


Shahim: PR build demo.