CodeSystem: Categories
Id: categories
Title: "Categories"
Description: "Various categories or tags"
* ^version = "0.0.1"
* ^status = #draft
* ^experimental = true
* ^content = #complete
* #phenotype "Phenotype"


CodeSystem: PhenotypicFeatureStatusCS
Id: phenotypicFeatureStatusCS
Title: "Categories"
Description: "Various categories or tags"
* ^version = "0.1.0"
* ^status = #active
* ^content = #complete
* #Absent "Absent"
* #Present "Present"

CodeSystem: HtsFormat
Id: HtsFormat
Title: "HTS Format"
Description: "An enumeration used to represent different high-throughput sequencing file formats."
* ^version = "0.1.0"
* ^status = #active
* ^date = "2020-02-14T16:13:10+10:00"
* ^publisher = "Alejandro Metke"
* ^contact.name = "Alejandro Metke"
* ^content = #complete
* #UNKNOWN "Unknown"
* #SAM "SAM"
* #BAM "BAM"
* #CRAM "CRAM"
* #VCF "VCF"
* #BCF "BCF"
* #GVCF "GVCF"

CodeSystem: KaryotypicSexCS
Id: KaryotypicSex
Title: "Karyotypic sex code system"
Description: "karyotypic sex of an individual (also known as chromosomal sex)"
* ^version = "0.0.1"
* ^date = "2021-05-28T17:06:00-04:00"
* ^publisher = "GA4GH Phenopacket Working Group"
* ^content = #complete
* #UNKNOWN_KARYOTYPE "UNKNOWN_KARYOTYPE" "Untyped or inconclusive karyotyping"
* #XX "XX karyotypic sex" "Karyotype with two X chromosomes"
* #XY "XY karyotypic sex" "Karyotype with one X chromosome and one Y chromosome"
* #XO "XO karyotypic sex" "Karyotype with one X chromosome"
* #XXY "XXY karyotypic sex" "Karyotype with two X chromosomes and one Y chromosome"
* #XXX "XXX karyotypic sex" "Karyotype with three X chromosomes"
* #XXYY "XXYY karyotypic sex" "Karyotype with two X chromosomes and two Y chromosomes"
* #XXXY "XXXY karyotypic sex" "Karyotype with three X chromosomes and one Y chromosome"
* #XXXX "XXXX karyotypic sex" "Karyotype with four X chromosomes"
* #XYY "XYY karyotypic sex" "Karyotype with one X chromosome and two Y chromosomes"
* #OTHER_KARYOTYPE "Other karyotype" "Karyotype with sex chromosomes other than XX,XY,X0,XXY,XXX,XXYY,XXXY,XXXX, or XYY"