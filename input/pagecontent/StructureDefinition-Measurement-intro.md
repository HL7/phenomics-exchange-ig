# Introduction

In the phenopacket-schema, a Phenopacket representing clinical data about an individual can have zero to many 
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


1. In the GA4GH phenopacket, the ``description`` element is string that can be used for comments or arbitrary additional information. We do not consider this to be an essential or even recommended part of the ``Measurement`` and choose not to model it explictly in this IG. Implementers of software to transform FHIR code to GA4GH phenopacket code are free to use this field to record additional information in the FHR record as dictated by project needs, but that is outside the scope of this IG.


2. In the GA4GH phenopacket, the ``assay`` element an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes the assay used to produce the measurement.  This corresponds to the ``code`` element of the ``Observation``. For instance, we might use a LOINC code to denote a laboratory test.

3. In the GA4GH phenopacket, the ``measurement_value`` is either a [Value](https://phenopacket-schema.readthedocs.io/en/latest/value.html) or a [ComplexValue](https://phenopacket-schema.readthedocs.io/en/latest/complex-value) that represents the result of the measurement.  This corresponds to the ``value`` element of the ``Observation``. Software for transforming this IG into a GA4GH phenopacket must support transforming the following subelements of the value element.

- valueQuantity
- valueCodeableConcept
- valueString
- valueBoolean
(to be discussed)

4. In the GA4GH phenopacket, the ``time_observed`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of onset of the phenotypic feature. In this IG, implementers should represent this data using the standard ``effective`` element of the ``Observation``, which represents the clinically relevant time/time-period for observation. Software for transforming this IG into a GA4GH phenopacket must support the various ways time periods can be represented (the beginning and end of a time period should be interpreted as the onset and resolution. If the end of the period conincides with the time of the clinical encounter, this should be interpreted as indicating there has not been resolution of the phenotypic feature).

5. In the GA4GH phenopacket, the ``procedure`` element is  an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes the clinical procdure performed to acquire the sample used for the measurement. This is usuallu omitted for standard clinical
tests that are performed on blood samples in which the procedure is venipuncture (blood draw). This element corresponds roughly to the ``method`` element of the ``Observation``. If appropriate, software for transforming this IG into a GA4GH phenopacket may use other elements of an observation to determing the best code (e.g., ``device``).








