# Introduction

In the phenopacket-schema, a Phenopacket representing clinical data about an individual can have zero to many 
[PhenotypicFeatures](https://phenopacket-schema.readthedocs.io/en/latest/phenotype.html).

This element is intended to be used to describe a phenotype that characterizes the subject of the Phenopacket, which in general is a patient or a proband of a study. and the phenotypes will be abnormalities described by an ontology such as the Human Phenotype Ontology. While this concept has
no exact correspondence in the FHIR standard, we shoose to base it on the FHIR [Observation](https://www.hl7.org/fhir/observation.html), which is used to specify a <cite>Measurements and simple assertions made about a patient, device or other subject</cite>. In our case, a PhenotypicFeature
is intended to be an assertion about a specific phenotypic abnormality that is a component of a disease.

1. In the GA4GH phenopacket, the ``description`` element is string that can be used for comments or arbitrary additional information. We do not consider this to be an essential or even recommended part of the ``PhenotypicFeature`` and choose not to model it explictly in this IG. Implementers of software to transform FHIR code to GA4GH phenopacket code are free to use this field to record additional information in the FHR record as dictated by project needs, but that is outside the scope of this IG.

2. In the GA4GH phenopacket, the ``type`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that corresponds to the ``code`` element of ``Condition``. For the intended use cases of the phenopacket, all `PhenotypicFeature``s should be terms used for a specific project should come from a single ontology or at most a small number of ontologies. The ``code`` element should be set to the superclass of all such codes in the ontology. For instance, to use [Human Phenotype Ontology](https://hpo.jax.org/app/) phenotypic feature codes, the superclass should be indicated here -- [Phenotypic abnormality](https://hpo.jax.org/app/browse/term/HP:0000118)(HP:0000118). The actual code should be indicated in the value section of the ``Observation``, as a ``valueCodeableConcept``. In this IG, we have constrained the ``value`` field to be a ``valueCodeableConcept`` with cardinality 1. We do not contrain the field to be a concept from a particular ontology. We envision that other IGs for specific use cases will additionally constrain this IG.


3. In the GA4GH phenopacket, ``excluded`` is a boolean that is false by default. If set true, the meaning is that the phenotypic feature indicated by the ``type`` element was explicitly excluded by clinical examination. The equivalent
way of doing this in FHIR is to include a 'negated' coding as shown in the following.

```
"valueCodeableConcept": {
  "coding": [
	{
	  "system": "http://snomed.info/sct",
	  "code": "260385009",
	  "display": "Negative"
	}, {
	  "system": "http://github.com/phenopackets/core-ig/CodeSystem/hpo",
	  "code": "HP:0002875",
	  "display": "Exertional dyspnea"
	}
],
}
```



4. In the GA4GH phenopacket, the ``severity`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass). The ``modifiers`` element is a list of [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that can be empty or contain one or more ontology terms that are intended to provide more expressive or precise descriptions of a phenotypic feature, including attributes such as positionality and external factors that tend to trigger or ameliorate the feature. 

The features cannot easily be represented in the framework of an ``Observation``, but they are not needed for the vast majority of intended downstream applications in the field of rare disease. To ease adoption of this IG, we have chosen not to model these element of the GA4GH Phenopacket in this IG at present, but may choose to introduce them as extensions to meet future needs as appropriate.

5. In the GA4GH phenopacket, the ``onset`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of onset of the phenotypic feature. Similarly,  the ``resolution`` element is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of resolution or abatement of the phenotypic feature. In this IG, implementers should represent this data using the standard ``effective`` element of the ``Observation``, which represents the clinically relevant time/time-period for observation. Software for transforming this IG into a GA4GH phenopacket must support the various ways time periods can be represented (the beginning and end of a time period should be interpreted as the onset and resolution. If the end of the period conincides with the time of the clinical encounter, this should be interpreted as indicating there has not been resolution of the phenotypic feature).

7. In the GA4GH phenopacket, the ``evidence`` element is an [Element](https://phenopacket-schema.readthedocs.io/en/latest/element.html) that represents the the evidence for an assertion of the observation of the phenotypic feature. There is no
corresponding element in the ``Observation``. Software for transforming this IG into a GA4GH phenopacket is free to add an evidence field corresponding to the needs of the project, but this is beyond the scope of this IG.


