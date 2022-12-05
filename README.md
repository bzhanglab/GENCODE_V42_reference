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

 [<img src="https://github.com/bzhanglab/GENCODE_V42_reference/blob/main/doc/isoform-selection.png" width=800 class="center">](https://github.com/bzhanglab/GENCODE_V42_reference)



## Prepare matched Gistic2 reference

```sh

Usage: perl prepare_gistic2_reference.pl

```

A rg table of transcripts, except transcripts from chrM, were extracted from GENCODE V42 Basic (CHR) annotation (Figure 2). Hg38 cytoBand were downloaded from UCSC. Then rg and cytoBand tables were reformat following Gistic2 reference format. A Matlab script file main_convert.m will be copied to the folder gistic_reference. You should manually run this script to generate the final Gistics reference: GENCODE.V42.basic.CHR.no.chrM.mat

 [<img src="https://github.com/bzhanglab/GENCODE_V42_reference/blob/main/doc/rg.png" width=800 class="center">](https://github.com/bzhanglab/GENCODE_V42_reference)


## Prepare matched protein database
```sh

Usage: perl prepare_protein_database.pl

```

#### Redundant protein sequence removal

Matched protein database, gencode.v42.pc_translations.fa, was download from GENCODE. Only proteins from coding transcripts in GENCODE V42 Basic (CHR) annotation were retained (63,723 proteins) and others were discarded (47,330 proteins). To remove redundant protein sequences, we developed a transcript guided workflow to pick representable protein IDs for proteins with the same sequences (Figure 3). The coding transcripts were grouped into 50,827 transcript groups with the same protein sequences. If a transcript group has only one transcript, the transcript is selected (43,419). If a transcript group has multiple transcripts, all transcripts were ordered by presence of primary selection, secondary selection, Swissprot mapped, MANE selected, longest transcript and alphabetic order of transcript IDs. If multiple transcripts passed a criterion, the longest transcript will be selected. Then only proteins encoded from selected transcripts were kept.

 [<img src="https://github.com/bzhanglab/GENCODE_V42_reference/blob/main/doc/protein_selection.png" width=800 class="center">](https://github.com/bzhanglab/GENCODE_V42_reference)

#### Evaluation of contaminants

We evaluated three protein contaminant databases which are GPMDB_cRAp (118), MaxQuant (246), and contaminants for immunopeptidomic from Karl (642), respectively. 
The MaxQuant contaminant database has 246 unique IDs and 245 unique sequences. Q8N1N4-2 was removed as it has the same sequence with Q7RTT2. Then we removed 42 contaminant proteins which with the same sequences with regular proteins. There are 203 proteins remained in MaxQuant database after filtering. The GPMDB_cRAp contaminant database has 118 unique IDs and 116 unique protein sequences. P0DUB6|AMY1A_HUMAN, P0DTE8|AMY1C_HUMAN, and P0DTE7|AMY1B_HUMAN have the same protein sequence and only P0DUB6|AMY1A_HUMAN was kept. Then we removed 67 contaminant proteins which with the same sequences with regular proteins. The filtered GPMDB_cRAp database has 49 protein sequences remained. No proteins were filter out from Karl’s database based on above method. While the overlap is still low between the three contaminant databases (Figure 4). Then we generated a combined contaminant database with union protein sequences (817) from the three filtered contaminant databases.

  [<img src="https://github.com/bzhanglab/GENCODE_V42_reference/blob/main/doc/Evaluation_of_contaminants.png" width=800 class="center">](https://github.com/bzhanglab/GENCODE_V42_reference)


The headers of regular proteins were format as: 
> protein_ID|transcript_ID|gene_ID|gene_symbol gene_description.
ENSP00000510254 of KRAS is shown here as an example:
>ENSP00000510254|ENST00000692768|ENSG00000133703|KRAS KRAS proto-oncogene, GTPase
The headers of contaminants for immunopeptidomic from Karl is not changed. While the headers of GPMDB_cRAp, MaxQuant, and combined contaminant proteins were format as: 
>Cont|header_from_contaminant_database
P01966 from MaxQuant contaminants and P00761 from GPMDB_cRAp are shown here as examples:
>Cont|P01966 SWISS-PROT:P01966 (Bos taurus) Hemoglobin subunit alpha
>Cont|sp|P00761|TRYP_PIG Trypsin OS=Sus scrofa OX=9823 PE=1 SV=1


#### Proteins from IG/TR/NMD/LOF transcripts

In GENCODE V42 Basic (CHR) annotation, there are 705 proteins from transcripts labeled as IG_C/D/J/V/_gene (IG), TR_C/J/V/_gene, nonsense_mediated_decay (NMD), and protein_coding_LoF (LOF). There are 674 proteins retained after removing redundant sequences and sequences the same regular proteins. The filtered proteins can be appended to the regular protein database as needed.

