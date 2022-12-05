rm(list=ls())

argv <- commandArgs(TRUE)
if (length(argv) != 2) {
  cat("Usage: filter protein work_dir current_dir \n")
  q(status = 1)
}

work_dir=argv[1]
current_dir=argv[2]

mapping_table=read.table(paste(current_dir,"/annotation/GENCODE.V42.basic.CHR.isoform.selection.mapping.txt",sep=""),header = TRUE,sep="\t",quote = "")
protein_group_mapping=read.table(paste(work_dir,"/protein_group_to_id_mapping.txt",sep=""),header = TRUE,sep="\t")
#protein_group_mapping=protein_group_mapping[,-6]
rownames(mapping_table)=mapping_table$Transcript_id
rownames(protein_group_mapping)=protein_group_mapping$Transcript_id
mapping_table=mapping_table[rownames(protein_group_mapping),]

combined_mapping_table=cbind(mapping_table,protein_group_mapping)
combined_mapping_table_multiple=combined_mapping_table[combined_mapping_table$Number_of_proteins>1,]
combined_mapping_table_single=combined_mapping_table[combined_mapping_table$Number_of_proteins==1,]

combined_mapping_table_multiple_with_primary=combined_mapping_table_multiple[combined_mapping_table_multiple$Primary_select=="Yes",]    #### primary_isoforms
combined_mapping_table_multiple_with_primary=combined_mapping_table_multiple[combined_mapping_table_multiple$Protein_group_id %in% combined_mapping_table_multiple_with_primary$Protein_group_id,] #### primary selected protein group

combined_mapping_table_multiple_with_primary_for_select=combined_mapping_table_multiple_with_primary[combined_mapping_table_multiple_with_primary$Primary_select=="Yes",]
combined_mapping_table_multiple_with_primary_for_select=combined_mapping_table_multiple_with_primary_for_select[order(combined_mapping_table_multiple_with_primary_for_select$Protein_group_id,-1*combined_mapping_table_multiple_with_primary_for_select$Transcript_length,combined_mapping_table_multiple_with_primary_for_select$Transcript_id,decreasing = FALSE),]
combined_mapping_table_multiple_with_primary_for_select=combined_mapping_table_multiple_with_primary_for_select[!duplicated(combined_mapping_table_multiple_with_primary_for_select$Protein_group_id),]

##############################################################

combined_mapping_table_multiple_without_primary=combined_mapping_table_multiple[!(combined_mapping_table_multiple$Protein_group_id %in% combined_mapping_table_multiple_with_primary$Protein_group_id),]

combined_mapping_table_multiple_with_secondary=combined_mapping_table_multiple_without_primary[combined_mapping_table_multiple_without_primary$Secondary_select=="Yes",] #### secondary_isoforms
combined_mapping_table_multiple_with_secondary=combined_mapping_table_multiple_without_primary[combined_mapping_table_multiple_without_primary$Protein_group_id %in% combined_mapping_table_multiple_with_secondary$Protein_group_id,]  #### secondary selected protein group

combined_mapping_table_multiple_with_secondary_for_select=combined_mapping_table_multiple_with_secondary[combined_mapping_table_multiple_with_secondary$Secondary_select=="Yes",]
combined_mapping_table_multiple_with_secondary_for_select=combined_mapping_table_multiple_with_secondary_for_select[order(combined_mapping_table_multiple_with_secondary_for_select$Protein_group_id,-1*combined_mapping_table_multiple_with_secondary_for_select$Transcript_length,combined_mapping_table_multiple_with_secondary_for_select$Transcript_id,decreasing = FALSE),]
combined_mapping_table_multiple_with_secondary_for_select=combined_mapping_table_multiple_with_secondary_for_select[!duplicated(combined_mapping_table_multiple_with_secondary_for_select$Protein_group_id),]

##############################################################


combined_mapping_table_multiple_without_pri_sen_selectioin=combined_mapping_table_multiple_without_primary[!(combined_mapping_table_multiple_without_primary$Protein_group_id %in% combined_mapping_table_multiple_with_secondary$Protein_group_id),]

combined_mapping_table_multiple_swissprot=combined_mapping_table_multiple_without_pri_sen_selectioin[!is.na(combined_mapping_table_multiple_without_pri_sen_selectioin$SwissProt),]
combined_mapping_table_multiple_swissprot=combined_mapping_table_multiple_without_pri_sen_selectioin[combined_mapping_table_multiple_without_pri_sen_selectioin$Protein_group_id %in% combined_mapping_table_multiple_swissprot$Protein_group_id,]


combined_mapping_table_multiple_swissprot_for_select=combined_mapping_table_multiple_swissprot[!is.na(combined_mapping_table_multiple_swissprot$SwissProt),]
combined_mapping_table_multiple_swissprot_for_select=combined_mapping_table_multiple_swissprot_for_select[order(combined_mapping_table_multiple_swissprot_for_select$Protein_group_id,-1*combined_mapping_table_multiple_swissprot_for_select$Transcript_length,combined_mapping_table_multiple_swissprot_for_select$Transcript_id,decreasing = FALSE),]
combined_mapping_table_multiple_swissprot_for_select=combined_mapping_table_multiple_swissprot_for_select[!duplicated(combined_mapping_table_multiple_swissprot_for_select$Protein_group_id),]


##############################################################


combined_mapping_table_multiple_without_swissprot=combined_mapping_table_multiple_without_pri_sen_selectioin[!(combined_mapping_table_multiple_without_pri_sen_selectioin$Protein_group_id %in% combined_mapping_table_multiple_swissprot$Protein_group_id),]

combined_mapping_table_multiple_mane=combined_mapping_table_multiple_without_swissprot[combined_mapping_table_multiple_without_swissprot$MANE_select=="Yes",]
combined_mapping_table_multiple_mane=combined_mapping_table_multiple_without_swissprot[combined_mapping_table_multiple_without_swissprot$Protein_group_id %in% combined_mapping_table_multiple_mane$Protein_group_id,]

combined_mapping_table_multiple_mane_for_select=combined_mapping_table_multiple_mane[combined_mapping_table_multiple_mane$MANE_select=="Yes",]
combined_mapping_table_multiple_mane_for_select=combined_mapping_table_multiple_mane_for_select[order(combined_mapping_table_multiple_mane_for_select$Protein_group_id,-1*combined_mapping_table_multiple_mane_for_select$Transcript_length,combined_mapping_table_multiple_mane_for_select$Transcript_id,decreasing = FALSE),]
combined_mapping_table_multiple_mane_for_select=combined_mapping_table_multiple_mane_for_select[!duplicated(combined_mapping_table_multiple_mane_for_select$Protein_group_id),]

##############################################################



combined_mapping_table_multiple_others=combined_mapping_table_multiple_without_swissprot[!(combined_mapping_table_multiple_without_swissprot$Protein_group_id %in% combined_mapping_table_multiple_mane$Protein_group_id),]

combined_mapping_table_multiple_others_for_select=combined_mapping_table_multiple_others
combined_mapping_table_multiple_others_for_select=combined_mapping_table_multiple_others_for_select[order(combined_mapping_table_multiple_others_for_select$Protein_group_id,-1*combined_mapping_table_multiple_others_for_select$Transcript_length,combined_mapping_table_multiple_others_for_select$Transcript_id,decreasing = FALSE),]
combined_mapping_table_multiple_others_for_select=combined_mapping_table_multiple_others_for_select[!duplicated(combined_mapping_table_multiple_others_for_select$Protein_group_id),]

##############################################################
isoforms_selected_for_proteins=rbind(combined_mapping_table_multiple_with_primary_for_select,combined_mapping_table_multiple_with_secondary_for_select,combined_mapping_table_multiple_swissprot_for_select,combined_mapping_table_multiple_mane_for_select,combined_mapping_table_multiple_others_for_select)


combined_mapping_table[,"Protein_selection"]=NA
combined_mapping_table[rownames(isoforms_selected_for_proteins),"Protein_selection"]="Yes"
combined_mapping_table[rownames(combined_mapping_table_single),"Protein_selection"]="Yes"

combined_mapping_table=combined_mapping_table[order(combined_mapping_table$Protein_group_id,-1*combined_mapping_table$Transcript_length,combined_mapping_table$Transcript_id),]

combined_mapping_table=combined_mapping_table[,c(-25,-26,-27)]

combined_mapping_table=combined_mapping_table[,c(1:21,23,24,26,25,22)]


combined_mapping_table_coding=combined_mapping_table[combined_mapping_table$Transcript_type=="protein_coding",]
write.table(combined_mapping_table_coding,file=paste(work_dir,"/GENCODE.V42.basic.CHR.protein.selection.mapping.txt",sep=""),row.names = FALSE,sep="\t",quote = FALSE)


combined_mapping_table_ig_tr_nmd_lof=combined_mapping_table[combined_mapping_table$Transcript_type!="protein_coding",]
write.table(combined_mapping_table_ig_tr_nmd_lof,file=paste(work_dir,"/GENCODE.V42.basic.CHR.protein.selection.mapping.ig.tr.nmd.lof.txt",sep=""),row.names = FALSE,sep="\t",quote = FALSE)







