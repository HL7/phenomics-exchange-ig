# GA4GH Phenopacket FHIR Implementation Guide

The goal of the phenopacket-schema is to define the phenotypic description of a patient/sample in the context of rare disease, common/complex disease, or cancer. The schema as well as source code in Java, C++, and Python is available from the phenopacket-schema [GitHub repository](https://github.com/phenopackets/phenopacket-schema).

The phenopacket schema is being developed under the auspices of the Global Alliance for Genomics and Health, [GA4GH](https://www.ga4gh.org/). The native version is developed using Google's [Protocol buffers](https://developers.google.com/protocol-buffers), i.e., protobuf (version 3).

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
