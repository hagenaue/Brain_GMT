StressGeneSets_Mouse_Temp<-list()
StressGeneSets_Rat_Temp<-list()
StressGeneSets_Human_Temp<-list()

names(table(StressGeneSets_RatOrthologs_Symbols_NoNA$Dataset))

for(i in c(1:length(names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))))){
  
  StressGeneSets_Mouse_Temp[[i]]<-StressGeneSets_MouseOrthologs_Symbols_NoNA$Symbol_Mouse[StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset==names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))[i]]
  
  StressGeneSets_Rat_Temp[[i]]<-StressGeneSets_RatOrthologs_Symbols_NoNA$Symbol_Rat[StressGeneSets_RatOrthologs_Symbols_NoNA$Dataset==names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))[i]]
  
  StressGeneSets_Human_Temp[[i]]<-StressGeneSets_HumanOrthologs_Symbols_NoNA$Symbol_Human[StressGeneSets_HumanOrthologs_Symbols_NoNA$Dataset==names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))[i]]
  
}

names(StressGeneSets_Mouse_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))
names(StressGeneSets_Rat_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))
names(StressGeneSets_Human_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))

str(StressGeneSets_Mouse_Temp)

library(stringi)

StressGeneSets_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(StressGeneSets_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(StressGeneSets_Mouse_GMT_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))
str(StressGeneSets_Mouse_GMT_Temp)

str(t(StressGeneSets_Mouse_GMT_Temp))
head(t(StressGeneSets_Mouse_GMT_Temp))
StressGeneSets_Mouse_GMT<-t(StressGeneSets_Mouse_GMT_Temp)
write.table(StressGeneSets_Mouse_GMT, "StressGeneSets_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

StressGeneSets_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(StressGeneSets_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(StressGeneSets_Rat_GMT_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))
str(StressGeneSets_Rat_GMT_Temp)

str(t(StressGeneSets_Rat_GMT_Temp))
head(t(StressGeneSets_Rat_GMT_Temp))
StressGeneSets_Rat_GMT<-t(StressGeneSets_Rat_GMT_Temp)
write.table(StressGeneSets_Rat_GMT, "StressGeneSets_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

StressGeneSets_Human_GMT_Temp <- as.data.frame(stri_list2matrix(StressGeneSets_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(StressGeneSets_Human_GMT_Temp)<-names(table(StressGeneSets_MouseOrthologs_Symbols_NoNA$Dataset))
str(StressGeneSets_Human_GMT_Temp)

str(t(StressGeneSets_Human_GMT_Temp))
head(t(StressGeneSets_Human_GMT_Temp))
StressGeneSets_Human_GMT<-t(StressGeneSets_Human_GMT_Temp)
write.table(StressGeneSets_Human_GMT, "StressGeneSets_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

