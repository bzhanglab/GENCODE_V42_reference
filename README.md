# GENCODE_V42_reference
 Reference preparation for proteogenomics data processing and downstream analysis

## Download references

```sh

Usage: bash download_reference.sh

```

Reference files were download from GENCODE and the human release 42 basic and CHR only annotation was selected. ALL required files were downloaded automatically, except HGNC gene description. It should be manually download from https://www.genenames.org/download/custom/, approved symbols only. Then move the file to the annotation folder and rename it as HGNC-approved-name.txt.

## Select isoforms and generate comprehensive mapping table

```sh

Usage: perl isoform_selection_and_mapping_table_generation.pl

```

Swiss-Prot and MANE Select are two major efforts that aim to select one high-quality representative transcript for each protein-coding gene. Leveraging these two resources, we developed a workflow (Figure 1) and selected one representative primary isoform for each protein coding gene (see section 6. Comprehensive mapping table). Moreover, 28 genes are associated with multiple Swiss-Prot proteins, and all non-primary proteins and their longest transcripts were designated as secondary isoforms for these genes. The MANE Plus Clinical isoforms were added as supplements of MANE Selects for clinical variant reporting. If a MANE Plus Clinical and a secondary isoform from Swiss-Prot correspond to the same proteins but different transcripts of a gene, the MANE Plus Clinical selected isoform was used as the secondary selected isoform. 

 [<img src="https://github.com/bzhanglab/GENCODE_V42_reference/blob/main/doc/isoform-selection.png" width=500 class="center">](https://github.com/bzhanglab/GENCODE_V42_reference)


