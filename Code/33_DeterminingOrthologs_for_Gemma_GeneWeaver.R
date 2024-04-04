#Finding orthologs for the new GeneWeaver and Gemma .gmt files:

#Set working directory to load files:

#setwd("~/Documents/SideProjects/BrainGMT/GeneWeaver")
setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GeneSet_Sources/GeneWeaver")

GeneWeaver_GMT_forAngela_Mouse<-read.delim("GeneWeaver_GMT_forAngela_Mouse.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(GeneWeaver_GMT_forAngela_Mouse)
#'data.frame':	34 obs. of  59 variables:
#'
str(t(GeneWeaver_GMT_forAngela_Mouse))#transposes to a character matrix.

GeneWeaver_GMT_forAngela_Rat<-read.delim("GeneWeaver_GMT_forAngela_Rat.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(GeneWeaver_GMT_forAngela_Rat)
#'data.frame':	4 obs. of  26 variables:

GeneWeaver_GMT_forAngela_Human<-read.delim("GeneWeaver_GMT_forAngela_Human.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(GeneWeaver_GMT_forAngela_Human)
#'data.frame':	1 obs. of  26 variables:

#setwd("~/Documents/SideProjects/BrainGMT/Gemma")
setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GeneSet_Sources/Gemma")

Gemma_GeneSets_Mouse<-read.delim("Gemma_GeneSets_Mouse_ToReAnnotate.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(Gemma_GeneSets_Mouse)
#'data.frame':	276 obs. of  2 variables:
Gemma_GeneSets_Mouse$Gene.Set.Name
#Looks like everything is reading in properly, but we still need to strsplit the gene set and collapse the individual lists into rows again.

library(stringi)
Gemma_GeneSets_Mouse_List<-strsplit(Gemma_GeneSets_Mouse[,2],", ")
Gemma_GeneSets_Mouse_GMT<-data.frame(Gemma_GeneSets_Mouse$Gene.Set.Name, t(as.data.frame(stri_list2matrix(Gemma_GeneSets_Mouse_List, byrow = FALSE), stringsAsFactors=FALSE)),stringsAsFactors = FALSE)
str(Gemma_GeneSets_Mouse_GMT)

Gemma_GeneSets_Rat<-read.delim("Gemma_GeneSets_Rat_ToReAnnotate.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(Gemma_GeneSets_Rat)
#'data.frame':	54 obs. of  2 variables:
#'
Gemma_GeneSets_Rat_List<-strsplit(Gemma_GeneSets_Rat[,2],", ")
Gemma_GeneSets_Rat_GMT<-data.frame(Gemma_GeneSets_Rat$GeneSetName, t(as.data.frame(stri_list2matrix(Gemma_GeneSets_Rat_List, byrow = FALSE), stringsAsFactors=FALSE)),stringsAsFactors = FALSE)
str(Gemma_GeneSets_Rat_GMT)

Gemma_GeneSets_Human<-read.delim("Gemma_GeneSets_Human_ToReAnnotate.txt", sep="\t", header=TRUE, stringsAsFactors = FALSE)
str(Gemma_GeneSets_Human)
#'data.frame':	2 obs. of  2 variables:

Gemma_GeneSets_Human_List<-strsplit(Gemma_GeneSets_Human[,2],", ")
Gemma_GeneSets_Human_GMT<-data.frame(Gemma_GeneSets_Human$GeneSetName, t(as.data.frame(stri_list2matrix(Gemma_GeneSets_Human_List, byrow = FALSE), stringsAsFactors=FALSE)),stringsAsFactors = FALSE)
str(Gemma_GeneSets_Human_GMT)


setwd("~/Documents/Microarray Gen/GeneOrthology_HumanRatMouse")

Orthologs_Mice_Rats_Symbols_NoNA<-read.csv("Orthologs_Mice_Rats_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt", header=TRUE, stringsAsFactors = FALSE)
Orthologs_Rats_Humans_Symbols_NoNA<-read.csv("Orthologs_Rats_Humans_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt", header=TRUE, stringsAsFactors = FALSE)
Orthologs_Mice_Humans_Symbols_NoNA<-read.csv("Orthologs_Mice_Humans_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt", header=TRUE, stringsAsFactors = FALSE)

str(Orthologs_Mice_Rats_Symbols_NoNA)
#looks good.

#Finding orthologs: I had to change the previous code a little bit to fit the idiosyncracies of this file (regular mouse symbols, only 1 metadata column)

TempMatrix<-t(GeneWeaver_GMT_forAngela_Mouse)

TempMatrix_HumanOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
#I had to add some rows because not all of the orthologs are a 1:1 match.

for(i in c(1:ncol(TempMatrix))){
  
  TempMatrixColumn<-data.frame("Symbol_Mouse"=TempMatrix[,i])
  
  TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
  if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
    TempMatrix_RatOrtholog[c(2:(length(unique(TempColumnOrthologRats$Symbol_Rat))+1)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
  else{}
  
  TempColumnOrthologHuman<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
  if(length(unique(TempColumnOrthologHuman$Symbol_Human))>1){
    TempMatrix_HumanOrtholog[c(2:(length(unique(TempColumnOrthologHuman$Symbol_Human))+1)),i]<-unique(TempColumnOrthologHuman$Symbol_Human)}
  else{}
  
  rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologHuman)
  
}

TempMatrix_HumanOrtholog[1,]<-TempMatrix[1,]
TempMatrix_RatOrtholog[1,]<-TempMatrix[1,]

GeneWeaver_GMT_forAngela_Mouse_HumanOrtholog<-t(TempMatrix_HumanOrtholog)
GeneWeaver_GMT_forAngela_Mouse_RatOrtholog<-t(TempMatrix_RatOrtholog)

setwd("~/Documents/SideProjects/BrainGMT/GeneWeaver")

write.table(GeneWeaver_GMT_forAngela_Mouse_HumanOrtholog, "GeneWeaver_GMT_forAngela_Mouse_HumanOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(GeneWeaver_GMT_forAngela_Mouse_RatOrtholog, "GeneWeaver_GMT_forAngela_Mouse_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(GeneWeaver_GMT_forAngela_Mouse, "GeneWeaver_GMT_forAngela_Mouse.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


TempMatrix<-t(GeneWeaver_GMT_forAngela_Human)
#This should with the old code above:
TempMatrix_MouseOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
TempMatrix_RatOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
# #I had to add some rows because not all of the orthologs are a 1:1 match.
# 
for(i in c(1:ncol(TempMatrix))){
  
  TempMatrixColumn<-data.frame("Symbol_Human"=TempMatrix[,i])
  
  TempColumnOrthologRats<-join(TempMatrixColumn, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
  if(length(unique(TempColumnOrthologRats$Symbol_Rat))>1){
    TempMatrix_RatOrtholog[c(2:(length(unique(TempColumnOrthologRats$Symbol_Rat))+1)),i]<-unique(TempColumnOrthologRats$Symbol_Rat)}
  else{}
  
  TempColumnOrthologMice<-join(TempMatrixColumn, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
  if(length(unique(TempColumnOrthologMice$Symbol_Mouse))>1){
    TempMatrix_MouseOrtholog[c(2:(length(unique(TempColumnOrthologMice$Symbol_Mouse))+1)),i]<-unique(TempColumnOrthologMice$Symbol_Mouse)}
  else{}
  
  rm(TempMatrixColumn, TempColumnOrthologRats,TempColumnOrthologMice)
  
}

TempMatrix_MouseOrtholog[1,]<-TempMatrix[1,]
TempMatrix_RatOrtholog[1,]<-TempMatrix[1,]

GeneWeaver_GMT_forAngela_Human_MouseOrtholog<-t(TempMatrix_MouseOrtholog)
GeneWeaver_GMT_forAngela_Human_RatOrtholog<-t(TempMatrix_RatOrtholog)

write.table(GeneWeaver_GMT_forAngela_Human_MouseOrtholog, "GeneWeaver_GMT_forAngela_Human_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(GeneWeaver_GMT_forAngela_Human_RatOrtholog, "GeneWeaver_GMT_forAngela_Human_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(GeneWeaver_GMT_forAngela_Human, "GeneWeaver_GMT_forAngela_Human.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

#write.table(GeneWeaver_GMT_forAngela_Rat, "GeneWeaver_GMT_forAngela_Rat.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


str(GeneWeaver_GMT_forAngela_Rat)

TempMatrix<-t(GeneWeaver_GMT_forAngela_Rat)

TempMatrix_HumanOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
TempMatrix_MouseOrtholog<-matrix(data=as.character(), ncol=ncol(TempMatrix), nrow=(nrow(TempMatrix)+100))
#I had to add some rows because not all of the orthologs are a 1:1 match.

for(i in c(1:ncol(TempMatrix))){
  
  TempMatrixColumn<-data.frame("Symbol_Rat"=TempMatrix[,i])
  
  TempColumnOrthologMice<-join(TempMatrixColumn, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Rat", type="inner", match="all")
  if(length(unique(TempColumnOrthologMice$Symbol_Mouse))>1){
    TempMatrix_MouseOrtholog[c(2:(length(unique(TempColumnOrthologMice$Symbol_Mouse))+1)),i]<-unique(TempColumnOrthologMice$Symbol_Mouse)}
  else{}
  
  TempColumnOrthologHuman<-join(TempMatrixColumn, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Rat", type="inner", match="all")
  if(length(unique(TempColumnOrthologHuman$Symbol_Human))>1){
    TempMatrix_HumanOrtholog[c(2:(length(unique(TempColumnOrthologHuman$Symbol_Human))+1)),i]<-unique(TempColumnOrthologHuman$Symbol_Human)}
  else{}
  
  rm(TempMatrixColumn, TempColumnOrthologMice,TempColumnOrthologHuman)
  
}

TempMatrix_HumanOrtholog[1,]<-TempMatrix[1,]
TempMatrix_MouseOrtholog[1,]<-TempMatrix[1,]

GeneWeaver_GMT_forAngela_Rat_HumanOrtholog<-t(TempMatrix_HumanOrtholog)
GeneWeaver_GMT_forAngela_Rat_MouseOrtholog<-t(TempMatrix_MouseOrtholog)

#setwd("~/Documents/SideProjects/BrainGMT/GeneWeaver")

setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GMT_Versions/GMTs_Human")

write.table(GeneWeaver_GMT_forAngela_Rat_HumanOrtholog, "GeneWeaver_GMT_forAngela_Rat_HumanOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GMT_Versions/GMTs_Mouse")

write.table(GeneWeaver_GMT_forAngela_Rat_MouseOrtholog, "GeneWeaver_GMT_forAngela_Rat_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)



###############

#Gemma orthologs


#Just re-ran both sets of code using this to start:
TempMatrix<-t(Gemma_GeneSets_Mouse_GMT)

#.....Reran previous code to find orthologs for Mouse GMT here#

Gemma_GeneSets_Mouse_GMT_HumanOrtholog<-t(TempMatrix_HumanOrtholog)
Gemma_GeneSets_Mouse_GMT_RatOrtholog<-t(TempMatrix_RatOrtholog)


write.table(Gemma_GeneSets_Mouse_GMT_HumanOrtholog, "Gemma_GeneSets_Mouse_GMT_HumanOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(Gemma_GeneSets_Mouse_GMT_RatOrtholog, "Gemma_GeneSets_Mouse_GMT_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(Gemma_GeneSets_Mouse_GMT, "Gemma_GeneSets_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


TempMatrix<-t(Gemma_GeneSets_Human_GMT)

#.....Reran previous code to find orthologs for Human GMT here#

Gemma_GeneSets_Human_GMT_MouseOrtholog<-t(TempMatrix_MouseOrtholog)
Gemma_GeneSets_Human_GMT_RatOrtholog<-t(TempMatrix_RatOrtholog)

write.table(Gemma_GeneSets_Human_GMT_MouseOrtholog, "Gemma_GeneSets_Human_GMT_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
write.table(Gemma_GeneSets_Human_GMT_RatOrtholog, "Gemma_GeneSets_Human_GMT_RatOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(Gemma_GeneSets_Human_GMT, "Gemma_GeneSets_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(Gemma_GeneSets_Rat_GMT, "Gemma_GeneSets_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


str(Gemma_GeneSets_Rat_GMT)

TempMatrix<-t(Gemma_GeneSets_Rat_GMT)

#.....Reran previous code to find orthologs for Rat GMT here#

Gemma_GeneSets_Rat_GMT_MouseOrtholog<-t(TempMatrix_MouseOrtholog)
Gemma_GeneSets_Rat_GMT_HumanOrtholog<-t(TempMatrix_HumanOrtholog)

setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GMT_Versions/GMTs_Mouse")

write.table(Gemma_GeneSets_Rat_GMT_MouseOrtholog, "Gemma_GeneSets_Rat_GMT_MouseOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GMT_Versions/GMTs_Human")

write.table(Gemma_GeneSets_Rat_GMT_HumanOrtholog, "Gemma_GeneSets_Rat_GMT_HumanOrtholog.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

setwd("/Users/hagenaue/Dropbox (University of Michigan)/LaptopBackup_20221123/SideProjects/BrainGMT/GMT_Versions/GMTs_Rat")

write.table(Gemma_GeneSets_Rat_GMT, "Gemma_GeneSets_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


