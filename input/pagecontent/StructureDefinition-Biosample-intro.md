# Introduction

In the phenopacket-schema, an Individual can have zero to many [Biosamples](https://phenopacket-schema.readthedocs.io/en/latest/biosample.html). A Biosample refers to a unit of biological material from which the substrate molecules (e.g. genomic DNA, RNA, proteins) for molecular analyses (e.g. sequencing, array hybridisation, mass-spectrometry) are extracted. Examples would be a tissue biopsy, a single cell from a culture for single cell genome sequencing or a protein fraction from a gradient centrifugation. Several instances (e.g. technical replicates) or types of experiments (e.g. genomic array as well as RNA-seq experiments) may refer to the same Biosample.

## The FHIR Specimen and the GA4GH phenopacket-schema Biosample.

1. In the GA4GH phenopacket, the ``id`` element is a required string identifier. This corresponds to the ``identifier`` element of Specimen.