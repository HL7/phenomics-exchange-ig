Logical: FileDataModel
Id: file-data-model
Title: "File Data Model"
Description: """
    The File message allows a Phenopacket to link the structured phenotypic data it contains to external files which can be used to inform analyses. 
    For example the file could link to sequencing data in VCF format as well as other data types.
    Given that File elements are listed in various locations such as the Phenopacket, Biosample, Family etc. 
    which can in turn be nested, individual files MUST be contained within their appropriate scope. 
    For example within a Phenopacket for germline samples of an individual or within the scope of the Phenopacket.
    Biosample in the case of genomic data derived from sequencing or other characterisation of that biosample. 
    Aggregate data types such as Cohort and Family MUST contain aggregate file data i.e. merged/multi-sample VCF at the level of the Family/Cohort, 
    but each member Phenopacket can contain its own locally-scope files pertaining to that individual/biosample(s).
    """
* insert Publisher
* insert PR_CS_VS_Version
* ^date = "2024-09-21"
* uri 1..1 string "A valid URI e.g. file://data/file1.vcf.gz or https://opensnp.org/data/60.23andme-exome-vcf.231?1341012444. REQUIRED."
* uri ^comment = """
    URI for the file e.g. file://data/genomes/file1.vcf.gz or https://opensnp.org/data/60.23andme-exome-vcf.231?1341012444.
    """
* individual_to_file_identifiers 0..1 string "The mapping between the Individual.id or Biosample.id to any identifier in the file. RECOMMENDED."
* individual_to_file_identifiers ^comment = """
    A map of identifiers mapping an individual referred to in the Phenopacket to an identifier used in the file. 
    The key values must correspond to the Individual::id for the individuals in the message or Biosample::id for biosamples, 
    the values must map to identifiers in the file.
    """
* file_attributes 0..1 string "A map of attributes pertaining to the file or its contents."
* file_attributes ^comment = """
    A map of attributes which a resource might want to share about the contents of a file. 
    For example a file containing genomic coordinates (e.g. VCF, BED) 
    SHOULD contain an entry with the key genomicAssembly and a value indicating the genome assembly the contents of the file was called against. 
    We recommend using the Genome Reference Consortium nomenclature e.g. GRCh37, GRCh38.
    """

