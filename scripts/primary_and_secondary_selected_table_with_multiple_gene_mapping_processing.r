library(stringr)
rm(list=ls())

argv <- commandArgs(TRUE)
if (length(argv) != 2) {
  cat("Usage: isoform selection work_dir current_dir \n")
  q(status = 1)
}

work_dir=argv[1]
current_dir=argv[2]

data_table=read.table(paste(work_dir,"/GENCODE.V42.basic.CHR.mapping.table.txt",sep=""),header = TRUE,stringsAsFactors=FALSE, sep = "\t",check.name=FALSE)
data_table[,"Primary_select"]="No"
data_table[,"Secondary_select"]="No"
#data_table[,"CCDS_order"]=9999
#data_table[,"Trasncript_order"]=9999
coding_gene_list=unique(data_table[data_table$Gene_type=="protein_coding",]$Gene_id)
coding_gene_table=data_table[data_table$Gene_id %in% coding_gene_list,]
noncoding_gene_table=data_table[!(data_table$Gene_id %in% coding_gene_list),]


### primary select for noncoding genes
noncoding_gene_max_transcript_length=as.data.frame(aggregate(noncoding_gene_table$Transcript_length,by=list(noncoding_gene_table$Gene_id), FUN=max))
rownames(noncoding_gene_max_transcript_length)=noncoding_gene_max_transcript_length$Group.1
for(i in 1:nrow(noncoding_gene_table))
{
  if(noncoding_gene_table$Transcript_length[i]==noncoding_gene_max_transcript_length[noncoding_gene_table$Gene_id[i],2])
  {
    noncoding_gene_table$Primary_select[i]="Yes"
  }
}

### primary select for coding genes
coding_gene_table$Primary_select[coding_gene_table$MANE_select=="Yes"&(!is.na(coding_gene_table$SwissProt))]="Yes"  ##both MANE and SwissProt
coding_gene_table_match_name_and_swissport=coding_gene_table[coding_gene_table$Gene_id %in% unique(coding_gene_table[coding_gene_table$Primary_select=="Yes",]$Gene_id),]
coding_gene_table_unmatch_name_and_swissport=coding_gene_table[!(coding_gene_table$Gene_id %in% unique(coding_gene_table[coding_gene_table$Primary_select=="Yes",]$Gene_id)),]
coding_gene_table_swissport_only=coding_gene_table_unmatch_name_and_swissport[coding_gene_table_unmatch_name_and_swissport$Gene_id %in% coding_gene_table_unmatch_name_and_swissport[!is.na(coding_gene_table_unmatch_name_and_swissport$SwissProt),]$Gene_id,]
coding_gene_table_no_swissport=coding_gene_table_unmatch_name_and_swissport[!(coding_gene_table_unmatch_name_and_swissport$Gene_id %in% coding_gene_table_unmatch_name_and_swissport[!is.na(coding_gene_table_unmatch_name_and_swissport$SwissProt),]$Gene_id),]
coding_gene_table_mane_only=coding_gene_table_no_swissport[coding_gene_table_no_swissport$Gene_id %in% coding_gene_table_no_swissport[coding_gene_table_no_swissport$MANE_select=="Yes",]$Gene_id,]
coding_gene_table_no_swissport_no_mane=coding_gene_table_no_swissport[!(coding_gene_table_no_swissport$Gene_id %in% coding_gene_table_no_swissport[coding_gene_table_no_swissport$MANE_select=="Yes",]$Gene_id),]

#coding_gene_table_swissport_only=coding_gene_table_swissport_only[!is.na(coding_gene_table_swissport_only$SwissProt),]  ###remove non-SwissProt isoform
  
coding_gene_table_swissport_only_isoform=coding_gene_table_swissport_only[!is.na(coding_gene_table_swissport_only$SwissProt),]
coding_gene_table_swissport_only_isoform=coding_gene_table_swissport_only_isoform[order(coding_gene_table_swissport_only_isoform$Gene_id,coding_gene_table_swissport_only_isoform$CCDS_length,coding_gene_table_swissport_only_isoform$Transcript_length,decreasing = TRUE),]
coding_gene_table_swissport_only_isoform=coding_gene_table_swissport_only_isoform[!duplicated(coding_gene_table_swissport_only_isoform$Gene_id),]
coding_gene_table_swissport_only$Primary_select[coding_gene_table_swissport_only$Transcript_id %in% coding_gene_table_swissport_only_isoform$Transcript_id]="Yes"

#rownames(coding_gene_table_swissport_only_isoform)=coding_gene_table_swissport_only_isoform$Gene_id
#coding_gene_table_swissport_only_longest=coding_gene_table_swissport_only[coding_gene_table_swissport_only$CCDS_length==coding_gene_table_swissport_only_isoform[coding_gene_table_swissport_only$Gene_id,"CCDS_length"],]
#coding_gene_table_swissport_only_longest=coding_gene_table_swissport_only_longest[!is.na(coding_gene_table_swissport_only_longest$Gene_id),]
#coding_gene_table_swissport_only_longest=coding_gene_table_swissport_only_longest[duplicated(coding_gene_table_swissport_only_longest$Gene_id),]


coding_gene_table_mane_only$Primary_select[coding_gene_table_mane_only$MANE_select=="Yes"]="Yes"

coding_gene_table_no_swissport_no_mane_isoform=coding_gene_table_no_swissport_no_mane[order(coding_gene_table_no_swissport_no_mane$Gene_id,coding_gene_table_no_swissport_no_mane$CCDS_length,coding_gene_table_no_swissport_no_mane$Transcript_length,decreasing = TRUE),]
coding_gene_table_no_swissport_no_mane_isoform=coding_gene_table_no_swissport_no_mane_isoform[!duplicated(coding_gene_table_no_swissport_no_mane_isoform$Gene_id),]
coding_gene_table_no_swissport_no_mane$Primary_select[coding_gene_table_no_swissport_no_mane$Transcript_id %in% coding_gene_table_no_swissport_no_mane_isoform$Transcript_id]="Yes"

rownames(coding_gene_table_no_swissport_no_mane_isoform)=coding_gene_table_no_swissport_no_mane_isoform$Gene_id
coding_gene_table_no_swissport_no_mane_longest=coding_gene_table_no_swissport_no_mane[coding_gene_table_no_swissport_no_mane$CCDS_length==coding_gene_table_no_swissport_no_mane_isoform[coding_gene_table_no_swissport_no_mane$Gene_id,"CCDS_length"],]
coding_gene_table_no_swissport_no_mane_longest=coding_gene_table_no_swissport_no_mane_longest[!is.na(coding_gene_table_no_swissport_no_mane_longest$Gene_id),]
#coding_gene_table_no_swissport_no_mane_longest=coding_gene_table_no_swissport_no_mane_longest[duplicated(coding_gene_table_no_swissport_no_mane_longest$Gene_id),]

combine_table=rbind(coding_gene_table_match_name_and_swissport,coding_gene_table_swissport_only,coding_gene_table_mane_only,coding_gene_table_no_swissport_no_mane,noncoding_gene_table)

### secondary select for coding genes
secondary_selection=combine_table[!is.na(combine_table$SwissProt),]
secondary_selection=secondary_selection[!(secondary_selection$SwissProt %in% secondary_selection[secondary_selection$Primary_select=="Yes",]$SwissProt),]
secondary_selection=secondary_selection[order(secondary_selection$SwissProt,secondary_selection$CCDS_length,secondary_selection$Transcript_length,decreasing = TRUE),]
secondary_selection=secondary_selection[!duplicated(secondary_selection$SwissProt),]
combine_table$Secondary_select[combine_table$Transcript_id %in% secondary_selection$Transcript_id]="Yes"
combine_table$Secondary_select[combine_table$MANE_Plus_Clinical=="Yes"&combine_table$Primary_select=="No"]="Yes"

combine_table_secondary_select=combine_table[combine_table$Secondary_select=="Yes",]
MANE_Plus_Clinical_table=combine_table[combine_table$MANE_Plus_Clinical=="Yes",]


### process genes with multiple primary select
multiple_primary=combine_table[combine_table$Primary_select=="Yes",]
multiple_primary=multiple_primary[duplicated(multiple_primary$Gene_id),]
combine_table_multiple_primary=combine_table[combine_table$Gene_id %in% multiple_primary$Gene_id,]
combine_table_multiple_primary=combine_table_multiple_primary[combine_table_multiple_primary$Primary_select=="Yes",]
combine_table_multiple_primary=combine_table_multiple_primary[order(combine_table_multiple_primary$Gene_id,combine_table_multiple_primary$Transcript_id,decreasing = TRUE),]   ###sort by transcript 
combine_table_multiple_primary=combine_table_multiple_primary[!duplicated(combine_table_multiple_primary$Gene_id),]  ##remove duplicates
combine_table[combine_table$Transcript_id %in% combine_table_multiple_primary$Transcript_id,"Primary_select"]="No"  ##unselected the duplicated ones


### process genes with multiple secondary select
combine_table[combine_table$Transcript_id=="ENST00000313949","Secondary_select"]="No"
combine_table[combine_table$Transcript_id=="ENST00000292538","Secondary_select"]="No" ###O95467 and Q13948, longest isoform and MANE Plus Clinical are same protein and different length, select MANE Plus Clinical only


### process multiple mapping genes

combine_table_primary_only=combine_table[combine_table$Primary_select=="Yes",]
rownames(combine_table_primary_only)=combine_table_primary_only$Gene_id
combine_table_primary_only=combine_table_primary_only[order(combine_table_primary_only$Gene_name,combine_table_primary_only$SwissProt,combine_table_primary_only$MANE_select,combine_table_primary_only$CCDS_length,combine_table_primary_only$Transcript_length,combine_table_primary_only$Gene_id,decreasing = c(FALSE,TRUE,TRUE,TRUE,TRUE,FALSE),method = "radix"),]

combine_table_primary_only_non_duplicated=combine_table_primary_only[!duplicated(combine_table_primary_only$Gene_name),]
combine_table_primary_only_duplicated=combine_table_primary_only[duplicated(combine_table_primary_only$Gene_name),]
combine_table_primary_only_duplicated$Gene_name=paste(combine_table_primary_only_duplicated$Gene_name,combine_table_primary_only_duplicated$Gene_id,sep="_")

combine_table_primary_only=rbind(combine_table_primary_only_non_duplicated,combine_table_primary_only_duplicated)

combine_table[,"Unique_gene_name_for_display"]=combine_table_primary_only[combine_table$Gene_id,]$Gene_name

combine_table=combine_table[,c(c(1:4),18,c(5:17)),]  ###reorder
#combine_table=combine_table[order(combine_table$Gene_id,combine_table$Transcript_id),]

versioned_id=read.table(paste(work_dir,"/GENCODE.V42.basic.CHR.versioned.ID.mapping.txt",sep=""),header = TRUE,sep="\t")
print(colnames(versioned_id))
rownames(versioned_id)=versioned_id$Transcript_id
versioned_id=versioned_id[combine_table$Transcript_id,]
versioned_id=versioned_id[,c(4:6)]
versioned_id=as.data.frame(versioned_id)
print(colnames(versioned_id))
combine_table=cbind(combine_table,versioned_id)

gene_description=read.table(paste(work_dir,"/HGNC-approved-name.txt",sep=""),header = TRUE,sep="\t",fill = TRUE,quote = "")
gene_description=gene_description[gene_description$Ensembl.ID.supplied.by.Ensembl.!="",]
gene_description=gene_description[!duplicated(gene_description$Ensembl.ID.supplied.by.Ensembl.),]  ####ENSG00000230417', 'ENSG00000276085
rownames(gene_description)=gene_description$Ensembl.ID.supplied.by.Ensembl.

gene_description[setdiff(combine_table$Gene_id,rownames(gene_description)),]=NA

combine_table[,"Gene_description"]=NA
combine_table[,"Gene_description"]=gene_description[combine_table$Gene_id,]$Approved.name


write.table(rbind(idx=colnames(combine_table),combine_table),file=paste(work_dir,"/GENCODE.V42.basic.CHR.isoform.selection.mapping.txt",sep=""),sep="\t",row.names=FALSE,col.names = FALSE,quote=FALSE)


