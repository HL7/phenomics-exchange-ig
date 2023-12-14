# Introduction

In the phenopacket-schema, an Individual can have zero to many 
[Diseases](https://phenopacket-schema.readthedocs.io/en/latest/disease.html). 
The disease is a diagnosis, i.e., an inference or hypothesis about the cause 
underlying the observed phenotypic abnormalities. Some use cases of the 
phenopacket-schema involve genomics diagnostics for rare disease. In this
case, a patient may receive a general diagnosis such as 
[inherited retinal dystrophy](https://www.ebi.ac.uk/ols/ontologies/mondo/terms?iri=http%3A%2F%2Fpurl.obolibrary.org%2Fobo%2FMONDO_0019118)
(MONDO:0019118), and this would be the term that is entered in the Disease field of the phenopacket.
In this example, analysis of the phenotypic abnormalities and the variants in whole-genome sequencing
leads to the diagnosis of [cone-rod dystrophy 16](https://www.ebi.ac.uk/ols/ontologies/mondo/terms?iri=http%3A%2F%2Fpurl.obolibrary.org%2Fobo%2FMONDO_0013786) (MONDO:0013786). In this case, we would use the Ontology term MONDO:0013786 to denote
the diagnosis in the Interpretation TODO -- ADD LINK. In other cases, we may know the etiological (molecular) 
or other precise diagnosis at the time the Phenopacket is generated, and the specific term would be used here.

Thus, the Disease element can be used to model disease diagnoses at different levels of granularity depending 
on the preciseness of the clinical diagnosis.

## The FHIR Condition and the GA4GH phenopacket-schema Disease.

The GA4GH ``Disease`` element can be coded using the native FHIR [Condition](http://hl7.org/fhir/R4/condition.html) element. The following explains how this should be done.

1. In the GA4GH phenopacket, the ``term`` element is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that represents the disease diagnosis. This corresponds to the ``code`` element of Condition.

2. In the GA4GH phenopacket, ``excluded`` is a boolean that is false by default. If set true, the meaning is that the disease indicated by the ``term`` element was explicitly excluded by clinical examination. The ``clinicalStatus`` element of Condition
uses a Preferred value set for the codes (active, relapse, remission, resolved) but it is valid to use other codes here. To represent the fact that a disease has been excluded, the SNOMED code 315215002,	<cite>Disorder excluded (situation)</cite>, or a comparable code should be used.

3. In the GA4GH phenopacket, ``onset`` is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of onset of the disease. This corresponds to ``onset`` in Condition.

4.  In the GA4GH phenopacket, ``resolution`` is a [TimeElement](https://phenopacket-schema.readthedocs.io/en/latest/time-element.html) that represents the time or age of resolution or abatement of the disease. This corresponds to ``abatement`` in Condition.

5.  In the GA4GH phenopacket, ``disease_stage`` is a list of  [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that represent the disease stage.  For instance, there are four stages of heart failure (A,B,C,D) ranging from 
<cite>high risk of developing heart failure</cite> to <cite>advanced heart failure</cite>. The FHIR Condition element represents the
same information using an optional, single code. Software for transforming FHIR to GA4GH phenopackets may transform single composite codes into a list of codes if appropriate, but that is outside the scope of this IG.


6. In the GA4GH phenopacket, ``clinical_tnm_finding`` is a list of  [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that represent TNM findings score the progression of cancer with respect to the originating tumor (T), spread to lymph nodes (N), and presence of metastases (M). Users should consider the [mCODE](https://mcodeinitiative.org/) FHIR IG for representing cancer
patients rather than this IG; both can be transformed into a GA4GH phenopacket. Therefore, we do not recommended modelling this aspect of the GA4GH
phenopacket using this IG.


7. In the GA4GH phenopacket, ``primary_site`` is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that represents the primary site of disease.  This corresponds to ``bodySite`` in Condition.

8. In the GA4GH phenopacket, ``laterality`` is an [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html#rstontologyclass) that represents the laterality (left or right) of the primary site of sites (if applicable). There is not element in Condition
that explicitly represents laterality. We recommend that if this is an important data element, a code be used that contains a reference to
laterality, e.g., SNOMED 44029006, <cite>Left lung structure (body structure)</cite>. Software for transforming FHIR to GA4GH phenopackets may 
infer the appropriate laterality term for right or left if needed.




