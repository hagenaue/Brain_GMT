#Notes for when I come back to this:

#Reformat Dropviz (+Zeisel), StressGenes,  and Psychiatric genes into .gmt format and combine them.

DropViz_HC_Mouse_Temp<-list()
DropViz_HC_Rat_Temp<-list()
DropViz_HC_Human_Temp<-list()

names(table(DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs$CellType))

for(i in c(1:length(names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))))){
  
  DropViz_HC_Mouse_Temp[[i]]<-DropViz_HC_CellTypeClusterMarkers_Concise$Symbol_Mouse[DropViz_HC_CellTypeClusterMarkers_Concise$CellType==names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))[i]]
  
  DropViz_HC_Rat_Temp[[i]]<-DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs$Symbol_Rat[DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs$CellType==names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))[i]]
  
  DropViz_HC_Human_Temp[[i]]<-DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs$Symbol_Human[DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs$CellType==names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))[i]]
  
}

names(DropViz_HC_Mouse_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))
names(DropViz_HC_Rat_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))
names(DropViz_HC_Human_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))

str(DropViz_HC_Mouse_Temp)

library(stringi)

DropViz_HC_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_HC_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_HC_Mouse_GMT_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_HC_Mouse_GMT_Temp)

str(t(DropViz_HC_Mouse_GMT_Temp))
head(t(DropViz_HC_Mouse_GMT_Temp))
DropViz_HC_Mouse_GMT<-t(DropViz_HC_Mouse_GMT_Temp)
write.table(DropViz_HC_Mouse_GMT, "DropViz_HC_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

DropViz_HC_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_HC_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_HC_Rat_GMT_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_HC_Rat_GMT_Temp)

str(t(DropViz_HC_Rat_GMT_Temp))
head(t(DropViz_HC_Rat_GMT_Temp))
DropViz_HC_Rat_GMT<-t(DropViz_HC_Rat_GMT_Temp)
write.table(DropViz_HC_Rat_GMT, "DropViz_HC_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

DropViz_HC_Human_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_HC_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_HC_Human_GMT_Temp)<-names(table(DropViz_HC_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_HC_Human_GMT_Temp)

str(t(DropViz_HC_Human_GMT_Temp))
head(t(DropViz_HC_Human_GMT_Temp))
DropViz_HC_Human_GMT<-t(DropViz_HC_Human_GMT_Temp)
write.table(DropViz_HC_Human_GMT, "DropViz_HC_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


#Let's test it:
GMT_ForRats<-gmtPathways("DropViz_HC_Rat_GMT.gmt.txt")
str(GMT_ForRats)

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_DropViz_HC_CellTypes.csv")
#It's working! Yessssss


DropViz_STR_Mouse_Temp<-list()
DropViz_STR_Rat_Temp<-list()
DropViz_STR_Human_Temp<-list()

names(table(DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs$CellType))

for(i in c(1:length(names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))))){
  
  DropViz_STR_Mouse_Temp[[i]]<-DropViz_STR_CellTypeClusterMarkers_Concise$Symbol_Mouse[DropViz_STR_CellTypeClusterMarkers_Concise$CellType==names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))[i]]
  
  DropViz_STR_Rat_Temp[[i]]<-DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs$Symbol_Rat[DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs$CellType==names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))[i]]
  
  DropViz_STR_Human_Temp[[i]]<-DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs$Symbol_Human[DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs$CellType==names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))[i]]
  
}

names(DropViz_STR_Mouse_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))
names(DropViz_STR_Rat_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))
names(DropViz_STR_Human_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))

str(DropViz_STR_Mouse_Temp)

library(stringi)

DropViz_STR_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_STR_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_STR_Mouse_GMT_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_STR_Mouse_GMT_Temp)

str(t(DropViz_STR_Mouse_GMT_Temp))
head(t(DropViz_STR_Mouse_GMT_Temp))
DropViz_STR_Mouse_GMT<-t(DropViz_STR_Mouse_GMT_Temp)
write.table(DropViz_STR_Mouse_GMT, "DropViz_STR_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

DropViz_STR_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_STR_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_STR_Rat_GMT_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_STR_Rat_GMT_Temp)

str(t(DropViz_STR_Rat_GMT_Temp))
head(t(DropViz_STR_Rat_GMT_Temp))
DropViz_STR_Rat_GMT<-t(DropViz_STR_Rat_GMT_Temp)
write.table(DropViz_STR_Rat_GMT, "DropViz_STR_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

DropViz_STR_Human_GMT_Temp <- as.data.frame(stri_list2matrix(DropViz_STR_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(DropViz_STR_Human_GMT_Temp)<-names(table(DropViz_STR_CellTypeClusterMarkers_Concise$CellType))
str(DropViz_STR_Human_GMT_Temp)

str(t(DropViz_STR_Human_GMT_Temp))
head(t(DropViz_STR_Human_GMT_Temp))
DropViz_STR_Human_GMT<-t(DropViz_STR_Human_GMT_Temp)
write.table(DropViz_STR_Human_GMT, "DropViz_STR_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

#Another Test:
GMT_ForRats<-gmtPathways("DropViz_STR_Rat_GMT.gmt.txt")
str(GMT_ForRats)

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_DropViz_STR_CellTypes.csv")
#Very pretty. :)