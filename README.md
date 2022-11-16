# GENCODE_V42_reference
 Reference preparation for proteogenomics data processing and downstream analysis


 ```shell

GENCODE_V42_reference
├── genome
│   ├── GRCh38.primary_assembly.genome.fa.gz, genome sequence, GRCh38 primary assembly.
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

