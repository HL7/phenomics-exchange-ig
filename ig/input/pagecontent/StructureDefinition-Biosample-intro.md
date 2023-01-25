# Introduction

In the phenopacket-schema, an Individual can have zero to many [Biosamples](https://phenopacket-schema.readthedocs.io/en/latest/biosample.html). A Biosample refers to a unit of biological material from which the substrate molecules (e.g. genomic DNA, RNA, proteins) for molecular analyses (e.g. sequencing, array hybridisation, mass-spectrometry) are extracted. Examples would be a tissue biopsy, a single cell from a culture for single cell genome sequencing or a protein fraction from a gradient centrifugation. Several instances (e.g. technical replicates) or types of experiments (e.g. genomic array as well as RNA-seq experiments) may refer to the same Biosample.

## The FHIR Specimen and the GA4GH phenopacket-schema Biosample.

1. In the GA4GH phenopacket, the ``id`` element is a required string identifier. This corresponds to the ``identifier`` element of Specimen (this profile specifies this field to be required).

2. In the GA4GH phenopacket, the ``individual_id`` is a string identifier corresponding to the patient from whom the Biosample is derived. Software  to transform FHIR code to GA4GH phenopacket code should generally extract an individual id from the ``subject`` field of the ``Specimen``. This IG
constraints ``subject`` to be a ``Patient``. The identifier field from the ``Patient`` object should be used for the ``individual_id``. If the former is not available, implementers can omit the ``individual_id`` or set it to another value that is appropriate for the application.

3. In the GA4GH phenopacket, the ``derived_from_id`` is a string identifier of the biosample from which the current biosample was derived. For instance, a given patient may have one `Biosample`` with id ``example.1`` representing a biopsy. We can choose to represent an RNA sample derived
from the biopsy as a separate ``Biosample`` object and would set ``derived_from_id = example.1``. This feature is intended to serve the needs of biobanks and we choose not to represent it explicitly in the FHIR IG.

4. In the GA4GH phenopacket, the ``description`` is a string with arbitrary text. This string should be initialized with the contents of the ``note`` element of the ``Specimen``.

5.  In the GA4GH phenopacket, the ``sampled_tissue`` is an optional [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes the tissue from which the sample was taken. It should be initialized from the ``collection.bodySite`` field, if available.

6.  In the GA4GH phenopacket, the ``sample_type`` is an optional  [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes the type of material, e.g., RNA, DNA, Cultured cells. If available, this field should be initialized based on infomration from the
``collection`` and ``processing`` fields of the FHIR ``Specimen``.

7. In the GA4GH phenopacket, ``phenotypic_features`` and ``measurement_value`` represent PhenotypeFeatures or Measurements that pertain specifically to the Biosample. In FHIR, we represent this using the corresponding fields of the upper level Phenopacket but require these to reference the ``id`` of this Biospecimen. Software for transforming FHIR to GA4GH Phenopackets should place such  PhenotypeFeatures or Measurements in the [Biosample](https://phenopacket-schema.readthedocs.io/en/latest/biosample.html).

