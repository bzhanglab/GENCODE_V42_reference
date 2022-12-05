
rm(list=ls())

argv <- commandArgs(TRUE)
if (length(argv) != 1) {
  cat("Usage: sort rg file work_dir \n")
  q(status = 1)
}

work_dir=argv[1]


rg_old=read.table(paste(work_dir,"/rg_raw.txt",sep=""),header = TRUE,sep="\t")
rg_old$gene=rg_old$symb

rg_old=rg_old[rg_old$chrn!="M",]  ###remove gene on chr M 
rg_old$chrn[rg_old$chrn=="X"]=23
rg_old$chrn[rg_old$chrn=="Y"]=24
rg_old=rg_old[order(as.numeric(rg_old$chrn),rg_old$start,rg_old$end),]
#rg_old_part_1=rg_old[rg_old$chrn=="X"|rg_old$chrn=="Y"|rg_old$chrn=="M",]
#rg_old_part_2=rg_old[!(rg_old$chrn=="X"|rg_old$chrn=="Y"|rg_old$chrn=="M"),]

#rg_old_part_1=rg_old_part_1[order(rg_old_part_1$chrn,rg_old_part_1$start,rg_old_part_1$end),]
#rg_old_part_2=rg_old_part_2[order(as.numeric(rg_old_part_2$chrn),rg_old_part_2$start,rg_old_part_2$end),]

#rg_old=rbind(rg_old_part_2,rg_old_part_1)

ttt=as.data.frame(table(rg_old$symb))
rownames(ttt)=ttt$Var1
for(i in 1:nrow(ttt))
{
  ttt$Freq[i]=i
}


rg_old$locus_id=ttt[rg_old$symb,2]

write.table(rg_old,file=paste(work_dir,"/rg.txt",sep=""),row.names = FALSE,col.names = TRUE,sep="\t",quote = FALSE)






