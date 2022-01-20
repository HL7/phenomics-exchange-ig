# Introduction

In the phenopacket-schema, a Phenopacket representing clinical data about an individual can have zero to many 
[PhenotypicFeatures](https://phenopacket-schema.readthedocs.io/en/latest/phenotype.html).

This element is intended to be used to describe a phenotype that characterizes the subject of the Phenopacket, which in general is a patient or a proband of a study. and the phenotypes will be abnormalities described by an ontology such as the Human Phenotype Ontology. While this concept has
no exact correspondence in the FHIR standard, we shoose to base it on the FHIR [Observation](https://www.hl7.org/fhir/observation.html), which is used to specify a <cite>Measurements and simple assertions made about a patient, device or other subject</cite>. In our case, a PhenotypicFeature
is intended to be an assertion about a specific phenotypic abnormality that is a component of a disease.

1. In the GA4GH phenopacket, the ``description`` element is string that can be used for comments or arbitrary additional information. We do not consider this to be an essential or even recommended part of the ``PhenotypicFeature`` and choose not to model it explictly in this IG. Implementers of software to transform FHIR code to GA4GH phenopacket code are free to use this field to record additional information in the FHR record as dictated by project needs, but that is outside the scope of this IG. For instance, implementations may record information in the ``note`` field that will be inserted into the ``description`` element of the GA4GH ``PhenopacketFeature``. However, we recommend that implementers avoid using free text wherever possible.

2. In the GA4GH phenopacket, the ``type`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that corresponds to the ``code`` element of ``Observation``. 


3. In the GA4GH phenopacket, ``excluded`` is a boolean that is false by default. If set true, the meaning is that the phenotypic feature indicated by the ``type`` element was explicitly excluded by clinical examination. In this IG, if
a phenotype term is observed, then the ``value`` should be set to the LOINC code for [present](https://loinc.org/LL1937-3/), and if the phenotypic
feature was explicitly exclude, the ``value`` should be set to the LOINC code for [absent](https://loinc.org/LL1937-3/).


If the phenotypic feature was excluded,
the ``value`` field should be set to ``false``. We show an observed and excluded phenotypic feature in the Examples.



4. In the GA4GH phenopacket, the ``severity`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass). The ``modifiers`` element is a list of [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that can be empty or contain one or more ontology terms that are intended to provide more expressive or precise descriptions of a phenotypic feature, including attributes such as positionality and external factors that tend to trigger or ameliorate the feature. 

The features cannot easily be represented in the framework of an ``Observation``, but they are not needed for the vast majority of intended downstream applications in the field of rare disease. To ease adoption of this IG, we have chosen not to model these element of the GA4GH Phenopacket in this IG at present, but may choose to introduce them as extensions to meet future needs as appropriate.

5. In the GA4GH phenopacket, the ``onset`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of onset of the phenotypic feature. Similarly,  the ``resolution`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of resolution or abatement of the phenotypic feature. In this IG, implementers should represent this data using the standard ``effective`` element of the ``Observation``, which represents the clinically relevant time/time-period for observation. Software for transforming this IG into a GA4GH phenopacket must support the various ways time periods can be represented (the beginning and end of a time period should be interpreted as the onset and resolution. If the end of the period conincides with the time of the clinical encounter, this should be interpreted as indicating there has not been resolution of the phenotypic feature).

7. In the GA4GH phenopacket, the ``evidence`` element is an [Element](https://phenopacket-schema.readthedocs.io/en/latest/element.html) that represents the the evidence for an assertion of the observation of the phenotypic feature. There is no
corresponding element in the ``Observation``. Software for transforming this IG into a GA4GH phenopacket is free to add an evidence field corresponding to the needs of the project, but this is beyond the scope of this IG.


