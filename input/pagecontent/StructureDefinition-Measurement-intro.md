# Introduction

In the phenopacket-schema, an Phenopacket representing clinical data about an individual can have zero to many 
[Measurements](https://phenopacket-schema.readthedocs.io/en/latest/measurement.html). The measurement element
is designed to capture quantitative, ordinal (e.g., absent/present), or categorical measurements. The difference between
a ``Measurement`` and a ``PhenotypicFeature`` is that the latter is intended to represent characteristic findings. The findings
are represented qualitatively, using ontology terms. In a measurement, an arbitrary result of an measuurement is recorded without
any committment as to whether it represents a characteristic clinical feature of the patient or not.

The ``Measurement`` object can be used to represent repeated measurements of the same quantity. This may be useful to represent
the time course of a disease. For instance, blood sugar measurements could be recorded in a patient with diabetes.

In some cases, it would be possible to represent a given clinical finding either as a ``Measurement`` or as a ``PhenotypicFeature``. For instance
a blood glucose value of 300 mg/dl could be represented numerically as a ``Measurement`` or it could be represented using 
the Human Phenotype Ontology (HPO) term for [Hyperglycemia](https://hpo.jax.org/app/browse/term/HP:0003074). While this IG can handle either representation
or both simultaneously, we recommended that users of the IG code clinical data in a consistent, agreed-upon fashion. For instance, for rare-disease
diagnostic genomics, a field in which HPO coding is commonly used, it may be preferable to not use the ``Measurement`` field at all and to code characteristic findings as ``PhenotypicFeature``s. On the other hand, to represent the time course of a quantitative laboratory finding in a study,
it would be preferable to encode the data using ``Measurement``s.

## The FHIR Observation and the GA4GH phenopacket-schema Measurement.

We represent the GA4GH phenopacket-schema ``Measurement`` by profiling the standard FHIR [Observation](http://hl7.org/fhir/R4/observation.html).