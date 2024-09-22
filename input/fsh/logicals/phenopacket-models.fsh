Logical: PhenopacketDataModel
Id: PhenopacketDataModel
Title: "Phenopacket Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Phenopacket."

* id 0..1 string "An identifier specific for this phenopacket."
* subject 0..1 IndividualDataModel "subject"
* phenotypic_features 0..1 PhenotypicFeatureDataModel "phenotypic_features"
* measurements 0..1 MeasurementDataModel "measurements"
* biosamples 0..1 BiosampleDataModel "biosamples"
* interpretations 0..1 InterpretationDataModel "interpretations"
* diseases 0..1 DiseaseDataModel "diseases"
* medical_actions 0..1 MedicalActionDataModel "medical_actions"
* files 0..1 FileDataModel "files"
* meta_data 0..1 MetaDataDataModel "meta_data"

Logical: FamilyDataModel
Id: FamilyDataModel
Title: "Family Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Family."

* id 0..1 string "An identifier specific for this family."
* proband 0..1 string "The individual representing the focus of this packet - e.g. the proband in rare disease cases or cancer patient"
* relatives 0..* string "Individuals related in some way to the patient. For instance, the individuals may be genetically related or may be members of a cohort. If this field is used, then it is expected that a pedigree will be included for genetically related individuals for use cases such as genomic diagnostics. If a phenopacket is being used to describe one member of a cohort, then in general one phenopacket will be created for each of the individuals in the cohort."
* consanguinous_parents 0..1 boolean "flag to indicate that the parents of the proband are consanguinous"
* pedigree 0..1 PedigreeDataModel "pedigree"
* files 0..1 FileDataModel "files"
* meta_data 0..1 MetaDataDataModel "meta_data"

Logical: CohortDataModel
Id: CohortDataModel
Title: "Cohort Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Cohort."

* id 0..1 string "id"
* description 0..1 string "description"
* members 0..* string "members"
* files 0..1 FileDataModel "files"
* meta_data 0..1 MetaDataDataModel "meta_data"

Logical: MetaDataDataModel
Id: MetaDataDataModel
Title: "MetaData Logical Model"
Description: "FHIR Logical Model for Phenopacket building block MetaData."

* created 0..1 dateTime "created"
* created_by 0..1 string "some kind of identifier for the contributor/ program ARGO sample_registration::program_id"
* submitted_by 0..1 string "information about the person/organisation/network that has submitted this phenopacket"
* resources 0..* ResourceDataModel "a listing of the ontologies and resources referenced in the phenopacket"
* updates 0..* UpdateDataModel "An OPTIONAL list of Updates to the phenopacket."
* phenopacket_schema_version 0..1 string "phenopacket-schema-version used to create this phenopacket"
* external_references 0..* ExternalReferenceDataModel "External identifiers for this message. These are considered different representation of the same record, not records which are in some other relation with the record at hand. For example this might be a PubMed reference to a study in which the individuals are reported."

Logical: ResourceDataModel
Id: ResourceDataModel
Title: "Resource Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Resource."

* id 0..1 string "for OBO Ontologies, the value of this string MUST always be the official OBO ID, which is always equivalent to the ID prefix in lower case. Examples: hp, go, mp, mondo Consult http:obofoundry.org for a complete list For other ontologies (e.g. SNOMED), use the prefix in identifiers.org"
* name 0..1 string "e.g. The Human Phenotype Ontology for OBO Ontologies, the value of this string SHOULD be the same as the title field on http:obofoundry.org however, this field is purely for information purposes and software should not encode any assumptions"
* url 0..1 string "For OBO ontologies, this should always be the PURL, e.g. http:purl.obolibrary.org/obo/hp.owl, http:purl.obolibrary.org/obo/hp.obo"
* version 0..1 string "for OBO ontologies, this should be the versionIRI"
* namespace_prefix 0..1 string "The prefix used in the CURIE of an OntologyClass e.g. HP, MP, ECO For example an HPO term will have a CURIE like this - HP:0012828 which should be used in combination with the iri_prefix to form a fully-resolvable IRI"
* iri_prefix 0..1 string "Full IRI prefix which can be used with the namespace_prefix and the OntologyClass::id to resolve to an IRI for a term. Tools such as the curie-util (https:github.com/prefixcommons/curie-util) can utilise this to produce fully-resolvable IRIs for an OntologyClass. e.g. Using the HPO term encoding the concept of 'Severe' OntologyClass: id: 'HP:0012828' label: 'Severe' Resource: namespace_prefix: 'HP' iri_prefix: 'http:purl.obolibrary.org/obo/HP_' the term can be resolved to http:purl.obolibrary.org/obo/HP_0012828"

Logical: UpdateDataModel
Id: UpdateDataModel
Title: "Update Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Update."

* timestamp 0..1 dateTime "timestamp"
* updated_by 0..1 string "Information about the person/organisation/network that has updated the phenopacket. OPTIONAL"
* comment 0..1 string "Textual comment about the changes made to the content and/or reason for the update. OPTIONAL"

Logical: IndividualDataModel
Id: IndividualDataModel
Title: "Individual Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Individual."

* id 0..1 string "An identifier for the individual. This must be unique within the record. ARGO mapping donor::submitter_donor_id"
* alternate_ids 0..* string "An optional list of alternative identifiers for this individual. This field is provided for the convenience of users who may have multiple mappings to an individual which they need to track."
* date_of_birth 0..1 dateTime "date_of_birth"
* time_at_last_encounter 0..1 TimeElementDataModel "An TimeElement object describing the age of the individual at the last time of collection. The Age object allows the encoding of the age either as ISO8601 duration or time interval (preferred), or as ontology term object. See http:build.fhir.org/datatypes"
* vital_status 0..1 VitalStatusDataModel "Vital status of the individual. If not present it is assumed that the individual is alive. If present it will default to 'false' i.e. the individual was alive when the data was collected. ARGO mapping donor::vital_status"
* sex 0..1 code "The phenotypic sex of the individual ARGO mapping sample_registration::gender (this is complicated as ARGO only have male/female/other which maps to the phenopacket Sex field)"
* karyotypic_sex 0..1 string "The karyotypic sex of the individual"
* gender 0..1 OntologyClassDataModel "Self-identified gender"
* taxonomy 0..1 OntologyClassDataModel "NCBI taxonomic identifier NCBITaxon e.g. NCBITaxon:9606 or NCBITaxon:1337 For resources where there may be more than one organism being studied it is advisable to indicate the taxonomic identifier of that organism, to its most specific level"

Logical: VitalStatusDataModel
Id: VitalStatusDataModel
Title: "VitalStatus Logical Model"
Description: "FHIR Logical Model for Phenopacket building block VitalStatus."


Logical: OntologyClassDataModel
Id: OntologyClassDataModel
Title: "OntologyClass Logical Model"
Description: "FHIR Logical Model for Phenopacket building block OntologyClass."

* id 0..1 string "a CURIE-style identifier e.g. HP:0100024, MP:0001284, UBERON:0001690. This is the primary key for the ontology class REQUIRED!"
* label 0..1 string "class label, aka name. E.g. \"Abnormality of cardiovascular system\""

Logical: ExternalReferenceDataModel
Id: ExternalReferenceDataModel
Title: "ExternalReference Logical Model"
Description: "FHIR Logical Model for Phenopacket building block ExternalReference."

* id 0..1 string "e.g. ISBN, PMID:123456, DOI:..., FHIR mapping: Reference.identifier"
* reference 0..1 string "A full or partial URL pointing to the external reference if no commonly resolvable identifier can be used in the `id` field FHIR mapping Reference.reference"
* description 0..1 string "Human readable title or display string for the reference FHIR mapping: Reference.display"

Logical: EvidenceDataModel
Id: EvidenceDataModel
Title: "Evidence Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Evidence."

* evidence_code 0..1 OntologyClassDataModel "The encoded evidence type using, for example the Evidence & Conclusion Ontology (ECO - http:purl.obolibrary.org/obo/eco.owl) FHIR mapping: Condition.evidence.code"
* reference 0..1 ExternalReferenceDataModel "FHIR mapping: Condition.evidence.detail"

Logical: ProcedureDataModel
Id: ProcedureDataModel
Title: "Procedure Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Procedure."

* code 0..1 OntologyClassDataModel "FHIR mapping: Procedure.code"
* body_site 0..1 OntologyClassDataModel "FHIR mapping: Procedure.bodySite"
* performed 0..1 TimeElementDataModel "When the procedure was performed."

Logical: GestationalAgeDataModel
Id: GestationalAgeDataModel
Title: "GestationalAge Logical Model"
Description: "FHIR Logical Model for Phenopacket building block GestationalAge."

* weeks 0..1 integer "weeks"
* days 0..1 integer "days"

Logical: AgeDataModel
Id: AgeDataModel
Title: "Age Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Age."

* iso8601duration 0..1 string "The :ref:`ISO 8601<metadata_date_time>` age of this object as ISO8601 duration or time intervals. e.g. P40Y10M05D)"

Logical: AgeRangeDataModel
Id: AgeRangeDataModel
Title: "AgeRange Logical Model"
Description: "FHIR Logical Model for Phenopacket building block AgeRange."

* start 0..1 AgeDataModel "start"
* end 0..1 AgeDataModel "end"

Logical: TimeIntervalDataModel
Id: TimeIntervalDataModel
Title: "TimeInterval Logical Model"
Description: "FHIR Logical Model for Phenopacket building block TimeInterval."

* start 0..1 dateTime "start"
* end 0..1 dateTime "end"

Logical: TimeElementDataModel
Id: TimeElementDataModel
Title: "TimeElement Logical Model"
Description: "FHIR Logical Model for Phenopacket building block TimeElement."

* gestational_age 0..1 GestationalAgeDataModel "gestational_age"
* age 0..1 AgeDataModel "age"
* age_range 0..1 AgeRangeDataModel "age_range"
* ontology_class 0..1 OntologyClassDataModel "ontology_class"
* timestamp 0..1 dateTime "timestamp"
* interval 0..1 TimeIntervalDataModel "interval"

Logical: FileDataModel
Id: FileDataModel
Title: "File Logical Model"
Description: "FHIR Logical Model for Phenopacket building block File."

* uri 0..1 string "URI for the file e.g. file:data/genomes/file1.vcf.gz or https:opensnp.org/data/60.23andme-exome-vcf.231?1341012444"

Logical: BiosampleDataModel
Id: BiosampleDataModel
Title: "Biosample Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Biosample."

* id 0..1 string "biosamples SAMN08666232 Human Cell Atlas The Biosample id This is unique in the context of the server instance. ARGO mapping specimen::submitter_specimen_id"
* individual_id 0..1 string "The id of the individual this biosample was derived from. ARGO mapping specimen::submitter_donor_id"
* derived_from_id 0..1 string "The id of the parent biosample this biosample was derived from."
* description 0..1 string "The biosample's description. This attribute contains human readable text. The \"description\" attributes should not contain any structured data."
* sampled_tissue 0..1 OntologyClassDataModel "UBERON class describing the tissue from which the specimen was collected. PDX-MI mapping: 'Specimen tumor tissue' FHIR mapping: Specimen.type ARGO mapping sample_registration::specimen_tissue_source"
* sample_type 0..1 OntologyClassDataModel "Recommended use of EFO term to describe the sample. e.g. Amplified DNA, ctDNA, Total RNA, Lung tissue, Cultured cells... ARGO mapping sample_registration::sample_type"
* phenotypic_features 0..* PhenotypicFeatureDataModel "Phenotypic characteristics of the BioSample, for example histological findings of a biopsy."
* measurements 0..* MeasurementDataModel "measurements"
* taxonomy 0..1 OntologyClassDataModel "NCBI taxonomic identifier (NCBITaxon) of the sample e.g. NCBITaxon:9606"
* time_of_collection 0..1 TimeElementDataModel "An TimeElement describing either the age of the individual this biosample was derived from at the time of collection, or the time itself. See http:build.fhir.org/datatypes"
* histological_diagnosis 0..1 OntologyClassDataModel "This is the pathologist’s diagnosis and may often represent a refinement of the clinical diagnosis given in the Patient/Clinical module. Should use the same terminology as diagnosis, but represent the pathologist’s findings. Normal samples would be tagged with the term \"NCIT:C38757\", \"Negative Finding\" ARGO mapping specimen::tumour_histological_type"
* tumor_progression 0..1 OntologyClassDataModel "Is the specimen tissue from the primary tumor, a metastasis or a recurrence? Most likely a child term of NCIT:C7062 (Neoplasm by Special Category) NCIT:C3677 (Benign Neoplasm) NCIT:C84509 (Primary Malignant Neoplasm) NCIT:C95606 (Second Primary Malignant Neoplasm) NCIT:C3261 (Metastatic Neoplasm) NCIT:C4813 (Recurrent Malignant Neoplasm)"
* tumor_grade 0..1 OntologyClassDataModel "Potentially a child term of NCIT:C28076 (Disease Grade Qualifier) or equivalent See https:www.cancer.gov/about-cancer/diagnosis-staging/prognosis/tumor-grade-fact-sheet"
* pathological_stage 0..1 OntologyClassDataModel "ARGO mapping specimen::pathological_tumour_staging_system ARGO mapping specimen::pathological_stage_group"
* pathological_tnm_finding 0..* OntologyClassDataModel "ARGO mapping specimen::pathological_t_category ARGO mapping specimen::pathological_n_category ARGO mapping specimen::pathological_m_category"
* diagnostic_markers 0..* OntologyClassDataModel "Clinically relevant bio markers. Most of the assays such as IHC are covered by the NCIT under the sub-hierarchy NCIT:C25294 (Laboratory Procedure). e.g. NCIT:C68748 (HER2/Neu Positive), NCIT:C131711 (Human Papillomavirus-18 Positive)"
* procedure 0..1 ProcedureDataModel "Clinical procedure performed on the subject in order to extract the biosample. ARGO mapping specimen::specimen_anatomic_location - Procedure::body_site ARGO mapping specimen::specimen_acquisition_interval - Procedure::time_performed"
* files 0..* FileDataModel "Pointer to the relevant file(s) for the biosample. Files relating to the entire individual e.g. a germline exome/genome should be associated with the Phenopacket rather than the Biosample it was derived from."
* material_sample 0..1 OntologyClassDataModel "This element can be used to specify the status of the sample. For instance, a status may be used as a normal control, often in combination with another sample that is thought to contain a pathological finding. We recommend use of ontology terms such as: EFO:0009654 (reference sample) or EFO:0009655 (abnormal sample) ARGO mapping sample_registration::tumour_normal_designation"
* sample_processing 0..1 OntologyClassDataModel "Field to represent how the sample was processed. ARGO mapping specimen::specimen_processing"
* sample_storage 0..1 OntologyClassDataModel "Field to represent how the sample was stored ARGO mapping specimen::specimen_storage"

Logical: PhenotypicFeatureDataModel
Id: PhenotypicFeatureDataModel
Title: "PhenotypicFeature Logical Model"
Description: "FHIR Logical Model for Phenopacket building block PhenotypicFeature."

* description 0..1 string "Free-text description of the phenotype. Note this is not a acceptable place to document/describe the phenotype - the type and onset etc... fields should be used for this purpose."
* type 0..1 OntologyClassDataModel "The primary ontology class which describes the phenotype. For example \"HP:0001363\" \"Craniosynostosis\" FHIR mapping: Condition.identifier"
* excluded 0..1 boolean "Flag to indicate whether the phenotype was observed or not. Default is 'false', in other words the phenotype was observed. Therefore it is only required in cases to indicate that the phenotype was looked for, but found to be absent. More formally, this modifier indicates the logical negation of the OntologyClass used in the 'type' field. *CAUTION* It is imperative to check this field for correct interpretation of the phenotype!"
* severity 0..1 OntologyClassDataModel "Severity of the condition e.g. subclasses of HP:0012824-Severity or SNOMED:272141005-Severities FHIR mapping: Condition.severity"
* modifiers 0..* OntologyClassDataModel "subclasses of HP:0012823 ! Clinical modifier apart from Severity HP:0012824 - Severity"
* onset 0..1 TimeElementDataModel "the values of this will come from the HPO onset hierarchy i.e. subclasses of HP:0003674 FHIR mapping: Condition.onset"
* resolution 0..1 TimeElementDataModel "resolution"
* evidence 0..* EvidenceDataModel "Evidences for how the phenotype was determined."

Logical: MedicalActionDataModel
Id: MedicalActionDataModel
Title: "MedicalAction Logical Model"
Description: "FHIR Logical Model for Phenopacket building block MedicalAction."

* procedure 0..1 ProcedureDataModel "procedure"
* treatment 0..1 TreatmentDataModel "treatment"
* radiation_therapy 0..1 RadiationTherapyDataModel "radiation_therapy"
* therapeutic_regimen 0..1 TherapeuticRegimenDataModel "therapeutic_regimen"

Logical: TreatmentDataModel
Id: TreatmentDataModel
Title: "Treatment Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Treatment."

* agent 0..1 OntologyClassDataModel "agent"
* route_of_administration 0..1 OntologyClassDataModel "for instance, DrugCentral, RxNorm Drugbank concept"
* dose_intervals 0..* DoseIntervalDataModel "For instance, NCIT subhierarchy: Route of Administration (Code C38114)"
* drug_type 0..1 code "drug_type"
* cumulative_dose 0..1 QuantityDataModel "ARGO mapping chemotherapy::cumulative_drug_dosage"

Logical: DoseIntervalDataModel
Id: DoseIntervalDataModel
Title: "DoseInterval Logical Model"
Description: "FHIR Logical Model for Phenopacket building block DoseInterval."

* quantity 0..1 QuantityDataModel "quantity"
* schedule_frequency 0..1 OntologyClassDataModel "schedule_frequency"
* interval 0..1 TimeIntervalDataModel "interval"

Logical: RadiationTherapyDataModel
Id: RadiationTherapyDataModel
Title: "RadiationTherapy Logical Model"
Description: "FHIR Logical Model for Phenopacket building block RadiationTherapy."

* modality 0..1 OntologyClassDataModel "The modality of radiation therapy (e.g., electron, photon,…). REQUIRED. ARGO mapping radiation::radiation_therapy_modality"
* body_site 0..1 OntologyClassDataModel "The anatomical site where radiation therapy was administered. REQUIRED. ARGO mapping radiation::anatomical_site_irradiated"
* dosage 0..1 integer "The total dose given in units of Gray (Gy). REQUIRED. ARGO mapping radiation::radiation_therapy_dosage"
* fractions 0..1 integer "The total number of fractions delivered as part of treatment. REQUIRED. ARGO mapping radiation::radiation_therapy_fractions"

Logical: TherapeuticRegimenDataModel
Id: TherapeuticRegimenDataModel
Title: "TherapeuticRegimen Logical Model"
Description: "FHIR Logical Model for Phenopacket building block TherapeuticRegimen."

* external_reference 0..1 ExternalReferenceDataModel "external_reference"
* ontology_class 0..1 OntologyClassDataModel "ontology_class"

Logical: InterpretationDataModel
Id: InterpretationDataModel
Title: "Interpretation Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Interpretation."


Logical: DiagnosisDataModel
Id: DiagnosisDataModel
Title: "Diagnosis Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Diagnosis."

* disease 0..1 OntologyClassDataModel "The disease/condition assigned to the diagnosis.Details about this disease may be contained in the `diseases` field in the Phenopacket."
* genomic_interpretations 0..* GenomicInterpretationDataModel "genomic features containing the status of their contribution towards the diagnosis"

Logical: GenomicInterpretationDataModel
Id: GenomicInterpretationDataModel
Title: "GenomicInterpretation Logical Model"
Description: "FHIR Logical Model for Phenopacket building block GenomicInterpretation."

* subject_or_biosample_id 0..1 string "identifier for the subject of the interpretation. This MUST be the individual id or a biosample id of the enclosing phenopacket."

Logical: VariantInterpretationDataModel
Id: VariantInterpretationDataModel
Title: "VariantInterpretation Logical Model"
Description: "FHIR Logical Model for Phenopacket building block VariantInterpretation."

* acmg_pathogenicity_classification 0..1 string "acmg_pathogenicity_classification"
* therapeutic_actionability 0..1 string "therapeutic_actionability"
* variation_descriptor 0..1 string "variation_descriptor"

Logical: PedigreeDataModel
Id: PedigreeDataModel
Title: "Pedigree Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Pedigree."

* persons 0..* string "persons"

Logical: MeasurementDataModel
Id: MeasurementDataModel
Title: "Measurement Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Measurement."

* description 0..1 string "Free-text description of the feature. Note this is not a acceptable place to document/describe the phenotype - the type and onset etc... fields should be used for this purpose."
* assay 0..1 OntologyClassDataModel "An ontology class which describes the assay used to produce the measurement. For example \"body temperature\" (CMO:0000015) or \"Platelets [#/volume] in Blood\" (LOINC:26515-7) FHIR mapping: Observation.code"
* value 0..1 ValueDataModel "value"
* complex_value 0..1 ComplexValueDataModel "complex_value"

Logical: ValueDataModel
Id: ValueDataModel
Title: "Value Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Value."

* quantity 0..1 QuantityDataModel "quantity"
* ontology_class 0..1 OntologyClassDataModel "for use with things such as categories 'red', 'yellow' or 'absent'/'present'"

Logical: ComplexValueDataModel
Id: ComplexValueDataModel
Title: "ComplexValue Logical Model"
Description: "FHIR Logical Model for Phenopacket building block ComplexValue."

* typed_quantities 0..* TypedQuantityDataModel "The quantities required to fully describe the complex value. For example the systolic and diastolic blood pressure quantities"

Logical: QuantityDataModel
Id: QuantityDataModel
Title: "Quantity Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Quantity."

* unit 0..1 OntologyClassDataModel "For instance, NCIT subhierarchy, Unit of Measure (Code C25709), https:www.ebi.ac.uk/ols/ontologies/uo"
* value 0..1 decimal "the value of the quantity in the units e.g. 2.0 mg"
* reference_range 0..1 ReferenceRangeDataModel "Reference range for the quantity e.g. The normal range of platelets is 150,000 to 450,000 platelets/uL."

Logical: TypedQuantityDataModel
Id: TypedQuantityDataModel
Title: "TypedQuantity Logical Model"
Description: "FHIR Logical Model for Phenopacket building block TypedQuantity."

* type 0..1 OntologyClassDataModel "e.g. diastolic, systolic"
* quantity 0..1 QuantityDataModel "e.g. mm Hg"

Logical: ReferenceRangeDataModel
Id: ReferenceRangeDataModel
Title: "ReferenceRange Logical Model"
Description: "FHIR Logical Model for Phenopacket building block ReferenceRange."

* unit 0..1 OntologyClassDataModel "unit"
* low 0..1 decimal "low"
* high 0..1 decimal "high"

Logical: DiseaseDataModel
Id: DiseaseDataModel
Title: "Disease Logical Model"
Description: "FHIR Logical Model for Phenopacket building block Disease."

* term 0..1 OntologyClassDataModel "The identifier of this disease e.g. MONDO:0007043, OMIM:101600, Orphanet:710, DOID:14705 (note these are all equivalent) ARGO mapping primary_diagnosis::submitter_primary_diagnosis_id"
* excluded 0..1 boolean "Flag to indicate whether the disease was observed or not. Default is 'false', in other words the disease was observed. Therefore it is only required in cases to indicate that the disease was looked for, but found to be absent. More formally, this modifier indicates the logical negation of the OntologyClass used in the 'term' field. *CAUTION* It is imperative to check this field for correct interpretation of the disease!"
* onset 0..1 TimeElementDataModel "The onset of the disease. The values of this will come from the HPO onset hierarchy i.e. subclasses of HP:0003674 FHIR mapping: Condition.onset ARGO mapping primary_diagnosis::age_at_diagnosis"
* resolution 0..1 TimeElementDataModel "resolution"
* disease_stage 0..* OntologyClassDataModel "Disease staging, the extent to which a disease has developed. For cancers, see https:www.cancer.gov/about-cancer/diagnosis-staging/staging Valid values include child terms of NCIT:C28108 (Disease Stage Qualifier) ARGO mapping primary_diagnosis::clinical_tumour_staging_system ARGO mapping primary_diagnosis::clinical_stage_group"
* clinical_tnm_finding 0..* OntologyClassDataModel "Cancer findings in the TNM system that is relevant to the diagnosis of cancer. See https:www.cancer.gov/about-cancer/diagnosis-staging/staging Valid values include child terms of NCIT:C48232 (Cancer TNM Finding) ARGO mapping primary_diagnosis::clinical_t_category ARGO mapping primary_diagnosis::clinical_n_category ARGO mapping primary_diagnosis::clinical_m_category"
* primary_site 0..1 OntologyClassDataModel "The text term used to describe the primary site of disease, as categorized by the World Health Organization's (WHO) International Classification of Diseases for Oncology (ICD-O). This categorization groups cases into general"
* laterality 0..1 OntologyClassDataModel "The term used to indicate laterality of diagnosis, if applicable. (Codelist reference: NCI CDE: 4122391)"
