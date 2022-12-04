mkdir genome
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/GRCh38.primary_assembly.genome.fa.gz
mv RCh38.primary_assembly.genome.fa.gz genome/

mkdir annotation
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.basic.annotation.gtf.gz
mv gencode.v42.basic.annotation.gtf.gz annotation/
gunzip annotation/*

mkdir protein_database
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.pc_translations.fa.gz
mv gencode.v42.pc_translations.fa.gz protein_database/
gunzip protein_database/*

mkdir Metadata_files
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.EntrezGene.gz
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.HGNC.gz
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.PDB.gz
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.RefSeq.gz
wget https://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_human/release_42/gencode.v42.metadata.SwissProt.gz
mv gencode.v42.metadata.* Metadata_files/
gunzip Metadata_files/*
