# Modeling Decisions

 > "All models are wrong, but some are useful".

The GA4GH Phenopacket and this IG intend to support [deep phenotyping](phenotype.md). The phenopacket
organizes information relevant to deep phenotyping and computational analysis for research or for
computational differental diagnosis approaches. Here, we discuss the motivations for the decisions we made for this IG.

## PhenotypicFeature: Observation or Condition?

In FHIR, an [Observation](https://www.hl7.org/fhir/observation.html) represents a neasurement or simple assertion made about a patient, including
vital signs, laboratory Data, imaging results, clinical Findings, device measurements (e.g., EKG), results of clinical assessment tools such as the 
APGAR or a Glasgow Coma scores, and related entities.

In contrast, a [Condition](https://www.hl7.org/fhir/condition.html) represents a clinical condition, problem, diagnosis, or other event, situation, issue, or clinical concept that has risen to a level of concern. The FHIR documentation notes 

 > This resource is not typically used to record information about subjective and objective information that 
   might lead to the recording of a Condition resource. Such signs and symptoms are typically captured using the 
   Observation resource; although in some cases a persistent symptom, e.g. fever, headache may be captured as a 
   condition before a definitive diagnosis can be discerned by a clinician. By contrast, headache may be captured 
   as an Observation when it contributes to the establishment of a meningitis Condition. 

Deep phenotyping can be defined as the precise and comprehensive analysis of phenotypic abnormalities in which the individual components of the phenotype are observed and described, generally in such a way as to be computationally accessible. This process involves the synthesis of a list of
of phenotypic abnormalities that characterize a patient in order to support differential diagnostics by literature search or computational analysis to search for candidate diseases with comparable phenotypic profiles. For instance, the [Human Phenotype Ontology](https://hpo.jax.org/app/) provides a comprehensive logical standard to describe and computationally analyze phenotypic abnormalities found in human disease.  The HPO project has computational models of over 8000 rare genetic diseases and numerous algorithms have been developed that compare the phenotypic profile of a patient (i.e., a list of HPO terms) with these models using specificity weighted, fuzzy matching.

The intended use of PhenotypicFeature's is thus to contribute to the establishment of Conditions (diagnoses that require clinical attention). Therefore, we model the PhenotypicFeature as an [Observation](https://www.hl7.org/fhir/observation.html). We note that there can be overlap with 
[Condition](https://www.hl7.org/fhir/condition.html). For instance, the Mendelian disease [Bardet-Biedl syndrome](https://www.ncbi.nlm.nih.gov/books/NBK1363/) is often characterized by diabetes mellitus. Clearly, this should be recorded as a [Condition](https://www.hl7.org/fhir/condition.html) in the medical record of the patient. However, in the context of the Phenopacket, it would be regarded as a feature (observation) that supports the diagnosis of the underlying condition (Bardet-Biedl syndrome). Therefore, in this case we would code Diabetes mellitus as an observation, ideally using the corresponding term [Diabetes mellitus](https://hpo.jax.org/app/browse/term/HP:0000819) of the HPO. Of course, this should only be done in the context of the Phenopacket and would be incorrect in other FHIR contexts.


