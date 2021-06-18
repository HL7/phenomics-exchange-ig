# Introduction

In the phenopacket-schema, an Individual can have zero to many [MedicalAction](https://phenopacket-schema.readthedocs.io/en/latest/medical-action.html) messages. A ``MedicalAction`` can refer to a ``Procedure``, ``Treatment``, ``RadiationTherapy``, or ``TherapeuticRegimen``. The ``Treatment``
message represents treatment with an agent such as a drug (pharmaceutical agent), broadly defined as prescription and over-the-counter medicines, vaccines, and large-molecule biologic therapies.

## The FHIR MedicationAdministration and the GA4GH phenopacket-schema Treatment.

We represent the GA4GH [Treatment](https://phenopacket-schema.readthedocs.io/en/latest/treatment.html) element by profiling a FHIR [MedicationAdministration](https://www.hl7.org/fhir/medicationadministration.html).

1. In the GA4GH phenopacket, the ``agent`` element is a required [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes the drug or therapeutic agent. It corresponds to the ``medication`` element of ``MedicationAdministration``.

2. In the GA4GH phenopacket, the ``route_of_administration`` element is an optional [OntologyClass](https://phenopacket-schema.readthedocs.io/en/latest/ontologyclass.html) that denotes how was the drug administered, e.g., by mouth or intravenously.  It corresponds to the ``dosage.route`` element of ``MedicationAdministration``.

3. In the GA4GH phenopacket, the ``dose_intervals`` element is a potentially empty list of [DoseIntervals](https://phenopacket-schema.readthedocs.io/en/latest/dose-interval.html). FHIR models the dosage in the ``dosage`` element and the time interval in which a given dose is administered with the ``effective`` element. Software for transforming FHIR to GA4GH phenopacket should extract information from both fields to instantiate [DoseIntervals](https://phenopacket-schema.readthedocs.io/en/latest/dose-interval.html). In the In the GA4GH phenopacket, one [Treatment](https://phenopacket-schema.readthedocs.io/en/latest/treatment.html) can contain a list of multiple [DoseIntervals](https://phenopacket-schema.readthedocs.io/en/latest/dose-interval.html). In FHIR, multiple ``MedicationAdministration`` elements would be used. Software for transforming FHIR to GA4GH phenopacket is allowed to combine data into a single [Treatment](https://phenopacket-schema.readthedocs.io/en/latest/treatment.html) with multiple  [DoseIntervals](https://phenopacket-schema.readthedocs.io/en/latest/dose-interval.html).

4. In the GA4GH phenopacket, the ``drug_type`` element is an enumeration (UNKNOWN_DRUG_TYPE, PRESCRIPTION, EHR_MEDICATION_LIST,ADMINISTRATION_RELATED_TO_PROCEDURE). This corresponds to the ``category`` field of ``MedicationAdministration``. 