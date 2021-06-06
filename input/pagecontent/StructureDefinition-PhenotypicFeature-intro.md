# Introduction

In the phenopacket-schema, a Phenopacket representing clinical data about an individual can have zero to many 
[PhenotypicFeatures](https://phenopacket-schema.readthedocs.io/en/latest/phenotype.html).

This element is intended to be used to describe a phenotype that characterizes the subject of the Phenopacket, which in general is a patient or a proband of a study. and the phenotypes will be abnormalities described by an ontology such as the Human Phenotype Ontology. While this concept has
no exact correspondence in the FHIR standard, we shoose to base it on the FHIR [Condition](https://www.hl7.org/fhir/condition.html), which is used to specify a <cite>clinical condition, problem, diagnosis, or other event, situation, issue, or clinical concept that has risen to a level of concern</cite>.

1. In the GA4GH phenopacket, the ``description`` element is string that can be used for comments or arbitrary additional information. This corresponds to the ``text`` element of ``Condition`` (Text summary of the resource, for human interpretation).

2. In the GA4GH phenopacket, the ``type`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that corresponds to the ``code`` element of ``Condition``. While ``code`` is not required in ``Condition``, the ``PhenotypicFeature`` requires it (cardinality 1).

3. In the GA4GH phenopacket, ``excluded`` is a boolean that is false by default. If set true, the meaning is that the phenotypic feature indicated by the ``type`` element was explicitly excluded by clinical examination. The ``clinicalStatus`` element of Condition
uses a Preferred value set for the codes (active, relapse, remission, resolved) but it is valid to use other codes here. To represent the fact that a disease has been excluded, the SNOMED code 315215002,	<cite>Disorder excluded (situation)</cite>, or a comparable code should be used.

4. In the GA4GH phenopacket, the ``severity`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that corresponds to the optional ``severity`` element of ``Condition``. For this profile, we stipulate the severity must be supported.

5. In the GA4GH phenopacket, the ``modifiers`` element is a list of [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that can be empty or contain one or more ontology terms that are intended to provide more expressive or precise descriptions of a phenotypic feature, including attributes such as positionality and external factors that tend to trigger or ameliorate the feature. To ease adoption of this IG, we have chosen not to model this element of the GA4GH Phenopacket in this IG at present.

6. In the GA4GH phenopacket, the ``onset`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of onset of the phenotypic feature. This corresponds to ``onset`` in Condition.

7. In the GA4GH phenopacket, the ``resolution`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of resolution or abatement of the phenotypic feature. This corresponds to ``abatement`` in Condition.

8. In the GA4GH phenopacket, the ``evidence`` element is an [Element](https://phenopacket-schema.readthedocs.io/en/latest/element.html) that represents the the evidence for an assertion of the observation of the phenotypic feature. This corresponds to ``evidence`` in Condition.

Thus, all of the elements of the Phenopacket except one correspond to native elements of the FHIR ``Condition``. The element that does not correspond to an element in ``Condition`` is not essential (modifiers). In some cases, native EHR codes may include modifiers by precomposition that
software for FHIR to GA4GH Phenopacket transformation may break up into a core term and a modifier (e.g., left or right), depending on the use case.
