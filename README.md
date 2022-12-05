# GENCODE_V42_reference
 Reference preparation for proteogenomics data processing and downstream analysis

### Download reference from GENCODE 

Reference files were download from GENCODE and the human release 42 basic and CHR only annotation was selected. Links of reference files used in reference preparation are listed below.
GENCODE V42
https://www.gencodegenes.org/human/release_42.html

Genome sequence: GRCh38 primary assembly
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/GRCh38.primary_assembly.genome.fa.gz

Gene annotation: GENCODE V42, basic, CHR only
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.basic.annotation.gtf.gz
1.  It contains the basic gene annotation on the reference chromosomes only
2.  This is a subset of the corresponding comprehensive annotation, including only those transcripts tagged as 'basic' in every gene

Entrez gene ids mapping
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.EntrezGene.gz

Entrez gene ids mapping
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.EntrezGene.gz

Gene symbol mapping
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.HGNC.gz

RefSeq mapping
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.RefSeq.gz

SwissProt mapping
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.SwissProt.gz

Protein sequence
https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.pc_translations.fa.gz

HGNC gene description
Download on 11/15/2022 from https://www.genenames.org/download/custom/, approved symbols only.





 ```shell

GENCODE_V42_reference
├── genome
│   ├── GRCh38.primary_assembly.genome.fa.gz, GRCh38 primary assembly genome sequence.
│
├── gene_annotation
│   ├── GENCODE.V42.basic.CHR.gtf.zip, GENCODE V42 basic and CHR only annotation.
│   ├── GENCODE.V42.basic.CHR.isoform.selection.mapping.txt, comprehensive mapping table with primary and secondary isoform selection.
│   ├── GENCODE.V42.basic.CHR.primary.selection.gtf.zip, gene annotation with only primary isoform selection. 
│
├── Gistic2_reference
│   ├── GENCODE.V42.basic.CHR.no.chrM.mat, Gistic2 reference based on GENCODE V42 basic and CHR only annotation.
│
├── protein_database
│   ├── GENCODE.V42.basic.CHR.protein.selection.mapping.txt, mapping table for transcript guided redundant protein sequence removal.
│   ├── GENCODE.V42.basic.CHR.maxquant_contaminants.fa, protein database with filtered MaxQuant contaminants.
│   ├── GENCODE.V42.basic.CHR.immunopeptidomic_contaminants.fa, protein database with contaminants for immunopeptidomic analysis.
│   ├── GENCODE.V42.basic.CHR.combined_contaminants.fa, protein database with union of above two contaminant database.

```

