# Genomic Diagnostics

Whole-exome sequencing (WES) and whole-genome sequencing (WGS) have greatly accelerated the pace of elucidation of the genetic basis of Mendelian disease and offer clear diagnostic benefits for patients with rare disease. One of the main tenets of genomic medicine is that knowledge of the genetic etiology of a condition can be used to guide development of preventative or therapeutic interventions [Posey, 2019](https://ojrd.biomedcentral.com/articles/10.1186/s13023-019-1127-0).  

## Phenotype-driven genomic diagnostics

The analysis of WES or WGS data generally involves a pipeline in which the tens of thousands (WES) or millions (WGS) of identified variants are filter
to remove variants unlikely to be causative for a rare dsease (for instance, variants with a high population frequency). Remaining variants are 
then prioritized according to a variety of approaches. One powerful approach has been to employ computational phenotype analysis can serve to assess each candidate gene’s relevance to the clinical abnormalities observed in the patient [Smedley, 2015](https://genomemedicine.biomedcentral.com/articles/10.1186/s13073-015-0199-2).

A primary use case of this IG is to support this kind of phenotype-driven genomic diagnostics. The clinician would collect a list of all phenotypic abnormalities observed in the patient being investigated. If available, additional information such as the age of onset of individual phenotypic abnormalities and other modifiers would be provided. Excluded abnormalities would be coded if appropriate. For rare disease, the [Human Phenotype Ontology](https://hpo.jax.org/app/) provides the broadest and deepest coverage, with currently over 16,000 terms. The term list can be used to inform analysis of WES of WGS data using tools such as [Exomiser](https://www.nature.com/articles/nprot.2015.124). 

## Phenotype-driven genomic diagnostics in an EHR context

It is envisaged that a FHIR Phenopacket can be used to accompany a [ServiceRequest](https://www.hl7.org/fhir/servicerequest.html) for WES or WGS diagnostics. 

## Research use cases

FHIR Phenopackets can also be used to exchange information about study participants in mutlicenter rare disease cohort research projects. 
