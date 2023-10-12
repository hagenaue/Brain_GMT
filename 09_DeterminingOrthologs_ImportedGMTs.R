#Ok, now tackling the GMTs.
#This is going to be substantially more of a pain in the butt.
#Probably easiest to transpose the data.frames, run a for loop to replace gene symbols with orthologs and trim out missing values for each column, and transpose back.

#Old Code:

# str(c2.all.v7.3.symbols)
# str(t(c2.all.v7.3.symbols))
# #seems to transpose into a character matrix? I guess I could have used that shortcut earlier, LOL.
# 
# #Making some matrices to hold my results:
# 
# TempMatrix<-t(c2.all.v7.3.symbols)
# TempMatrix_MouseOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
# TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
# #I had to add some rows because not all of the orthologs are a 1:1 match.
# 
# for(i in c(3:ncol(TempMatrix))){
#   
#   TempMatrixColumn<-data.frame("Symbol_Human"=TempMatrix[,i])
#   
#   TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
#   if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
#   TempMatrix_RatOrtholog[c(3:(length(unique(TempColumnOrthologRats$Symbol_Rat))+2)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
#   else{}
#   
#   TempColumnOrthologMice<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
#   if(length(unique(TempColumnOrthologMice$Symbol_Mouse))>1){
#   TempMatrix_MouseOrtholog[c(3:(length(unique(TempColumnOrthologMice$Symbol_Mouse))+2)),i]<-unique(TempColumnOrthologMice$Symbol_Mouse)}
#   else{}
#   
#   rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologMice)
#   
# }

# 
# TempMatrix_MouseOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
# TempMatrix_RatOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
# 
#   c2.all.v7.3.symbols_MouseOrtholog<-t(TempMatrix_MouseOrtholog)
#   c2.all.v7.3.symbols_RatOrtholog<-t(TempMatrix_RatOrtholog)
#   
#   write.table(c2.all.v7.3.symbols_MouseOrtholog, "c2.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
#   write.table(c2.all.v7.3.symbols_RatOrtholog, "c2.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
#   
#   #I'm having trouble opening those files.
#   
#   write.csv(c2.all.v7.3.symbols_MouseOrtholog, "c2.all.v7.3.symbols_MouseOrtholog.csv", na="")
#   #That didn't work either - still can't open the file.
#   #let's test whether it is just a problem with writing out:
#   write.csv(TempMatrix, "TempMatrix.csv")
#   #That didn't work either.
#   #Let's try something that wrote out fine earlier.
#   write.csv(HumanPsychiatricGeneSets_RatOrthologs, "TestingWritingOut.csv")
#   #That also isn't working. I think it may be time to save the workspace and code and restart the computer. :(
#   #restarted the computer and now everything is opening up fine. :)


#New Code:


setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")

FindOrthologsForGMTs<-function(GMTFileAsCharacterMatrix){
  
  TempMatrix<-t(GMTFileAsCharacterMatrix)
  TempMatrix_MouseOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
  TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
  #I had to add some rows because not all of the orthologs are a 1:1 match.
  
  for(i in c(1:ncol(TempMatrix))){
    
    TempMatrixColumn<-data.frame("Symbol_Human"=TempMatrix[,i])
    
    TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
    if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
      TempMatrix_RatOrtholog[c(3:(length(unique(TempColumnOrthologRats$Symbol_Rat))+2)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
    else{}
    
    TempColumnOrthologMice<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
    if(length(unique(TempColumnOrthologMice$Symbol_Mouse))>1){
      TempMatrix_MouseOrtholog[c(3:(length(unique(TempColumnOrthologMice$Symbol_Mouse))+2)),i]<-unique(TempColumnOrthologMice$Symbol_Mouse)}
    else{}
    
    rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologMice)
    
  }
  TempMatrix_MouseOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
  TempMatrix_RatOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
  return(list(t(TempMatrix_MouseOrtholog), t(TempMatrix_RatOrtholog)))
}


Temp<-FindOrthologsForGMTs(h.all.v7.3.symbols)
str(Temp)
# List of 2
# $ : chr [1:50, 1:302] "HALLMARK_TNFA_SIGNALING_VIA_NFKB" "HALLMARK_HYPOXIA" "HALLMARK_CHOLESTEROL_HOMEOSTASIS" "HALLMARK_MITOTIC_SPINDLE" ...
# $ : chr [1:50, 1:302] "HALLMARK_TNFA_SIGNALING_VIA_NFKB" "HALLMARK_HYPOXIA" "HALLMARK_CHOLESTEROL_HOMEOSTASIS" "HALLMARK_MITOTIC_SPINDLE" ...

h.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
h.all.v7.3.symbols_RatOrtholog<-Temp[[2]]

write.table(h.all.v7.3.symbols_MouseOrtholog, "h.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(h.all.v7.3.symbols_RatOrtholog, "h.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)



Temp<-FindOrthologsForGMTs(c5.all.v7.3.symbols)
str(Temp)

c5.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
c5.all.v7.3.symbols_RatOrtholog<-Temp[[2]]
# List of 2
# $ : chr [1:14996, 1:2084] "GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE" "GOBP_REPRODUCTION" "GOBP_SINGLE_STRAND_BREAK_REPAIR" "GOBP_REGULATION_OF_DNA_RECOMBINATION" ...
# $ : chr [1:14996, 1:2084] "GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE" "GOBP_REPRODUCTION" "GOBP_SINGLE_STRAND_BREAK_REPAIR" "GOBP_REGULATION_OF_DNA_RECOMBINATION" ...

write.table(c5.all.v7.3.symbols_MouseOrtholog, "c5.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(c5.all.v7.3.symbols_RatOrtholog, "c5.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)


Temp<-FindOrthologsForGMTs(c8.all.v7.3.symbols)
str(Temp)
List of 2
# $ : chr [1:673, 1:1872] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_EARLY_SUPRABASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_LATE_SUPRABASAL_CELLS" ...
# $ : chr [1:673, 1:1872] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_EARLY_SUPRABASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_LATE_SUPRABASAL_CELLS" ...

c8.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
c8.all.v7.3.symbols_RatOrtholog<-Temp[[2]]

write.table(c8.all.v7.3.symbols_MouseOrtholog, "c8.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(c8.all.v7.3.symbols_RatOrtholog, "c8.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)


Temp<-FindOrthologsForGMTs(c3.all.v7.3.symbols)
str(Temp)
# List of 2
# $ : chr [1:3731, 1:2102] "MIR153_5P" "MIR8485" "MIR3662" "MIR607" ...
# $ : chr [1:3731, 1:2102] "MIR153_5P" "MIR8485" "MIR3662" "MIR607" ...

c3.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
c3.all.v7.3.symbols_RatOrtholog<-Temp[[2]]

write.table(c3.all.v7.3.symbols_MouseOrtholog, "c3.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(c3.all.v7.3.symbols_RatOrtholog, "c3.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)

Temp<-FindOrthologsForGMTs(c7.all.v7.3.symbols)
str(Temp)
# List of 2
# $ : chr [1:5219, 1:2094] "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_DN" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_DN" ...
# $ : chr [1:5219, 1:2094] "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_DN" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_DN" ...

c7.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
c7.all.v7.3.symbols_RatOrtholog<-Temp[[2]]

write.table(c7.all.v7.3.symbols_MouseOrtholog, "c7.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(c7.all.v7.3.symbols_RatOrtholog, "c7.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)


Temp<-FindOrthologsForGMTs(c2.all.v7.3.symbols)
str(Temp)
# List of 2
# $ : chr [1:6255, 1:2043] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_DN" "BLANCO_MELO_MERS_COV_INFECTION_MCR5_CELLS_UP" ...
# $ : chr [1:6255, 1:2043] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_DN" "BLANCO_MELO_MERS_COV_INFECTION_MCR5_CELLS_UP" ...

c2.all.v7.3.symbols_MouseOrtholog<-Temp[[1]]
c2.all.v7.3.symbols_RatOrtholog<-Temp[[2]]

write.table(c2.all.v7.3.symbols_MouseOrtholog, "c2.all.v7.3.symbols_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(c2.all.v7.3.symbols_RatOrtholog, "c2.all.v7.3.symbols_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

rm(Temp)



CombinedHCspecific
CombinedHCspecific[,1]
#This one was originally based on a mixture of mouse and human data - ouch
#Park=Mouse coexpression data (but in all caps)
#Johnson=Human coexpression data
#Cembrowski=mouse (but in all caps)

CombinedHCspecific_Mouse<-CombinedHCspecific[c(1:14,39:69),]
CombinedHCspecific_Human<-CombinedHCspecific[c(15:38),]

TempMatrix<-t(CombinedHCspecific_Human)
#This should with the old code above:
TempMatrix_MouseOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
# #I had to add some rows because not all of the orthologs are a 1:1 match.
# 
for(i in c(1:ncol(TempMatrix))){
  
  TempMatrixColumn<-data.frame("Symbol_Human"=TempMatrix[,i])
  
  TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
  if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
    TempMatrix_RatOrtholog[c(3:(length(unique(TempColumnOrthologRats$Symbol_Rat))+2)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
  else{}
  
  TempColumnOrthologMice<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
  if(length(unique(TempColumnOrthologMice$Symbol_Mouse))>1){
    TempMatrix_MouseOrtholog[c(3:(length(unique(TempColumnOrthologMice$Symbol_Mouse))+2)),i]<-unique(TempColumnOrthologMice$Symbol_Mouse)}
  else{}
  
  rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologMice)
  
}


TempMatrix_MouseOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
TempMatrix_RatOrtholog[c(1:2),]<-TempMatrix[c(1:2),]

CombinedHCspecific_Human_MouseOrtholog<-t(TempMatrix_MouseOrtholog)
CombinedHCspecific_Human_RatOrtholog<-t(TempMatrix_RatOrtholog)

write.table(CombinedHCspecific_Human_MouseOrtholog, "CombinedHCspecific_Human_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(CombinedHCspecific_Human_RatOrtholog, "CombinedHCspecific_Human_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(CombinedHCspecific_Human, "CombinedHCspecific_Human.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

TempMatrix<-t(CombinedHCspecific_Mouse)

TempMatrix_HumanOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
#I had to add some rows because not all of the orthologs are a 1:1 match.

for(i in c(1:ncol(TempMatrix))){
  
  TempMatrixColumn<-data.frame("Symbol_Mouse_AsUpperCase"=TempMatrix[,i])
  
  TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse_AsUpperCase", type="inner", match="all")
  if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
    TempMatrix_RatOrtholog[c(3:(length(unique(TempColumnOrthologRats$Symbol_Rat))+2)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
  else{}
  
  TempColumnOrthologHuman<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse_AsUpperCase", type="inner", match="all")
  if(length(unique(TempColumnOrthologHuman$Symbol_Human))>1){
    TempMatrix_HumanOrtholog[c(3:(length(unique(TempColumnOrthologHuman$Symbol_Human))+2)),i]<-unique(TempColumnOrthologHuman$Symbol_Human)}
  else{}
  
  rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologHuman)
  
}

TempMatrix_HumanOrtholog[c(1:2),]<-TempMatrix[c(1:2),]
TempMatrix_RatOrtholog[c(1:2),]<-TempMatrix[c(1:2),]

CombinedHCspecific_Mouse_HumanOrtholog<-t(TempMatrix_HumanOrtholog)
CombinedHCspecific_Mouse_RatOrtholog<-t(TempMatrix_RatOrtholog)

write.table(CombinedHCspecific_Mouse_HumanOrtholog, "CombinedHCspecific_Mouse_HumanOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(CombinedHCspecific_Mouse_RatOrtholog, "CombinedHCspecific_Mouse_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(CombinedHCspecific_Mouse, "CombinedHCspecific_Mouse.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
