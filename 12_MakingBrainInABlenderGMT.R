BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA
BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA
BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA

BrainInABlender_Mouse_Temp<-list()
BrainInABlender_Rat_Temp<-list()
BrainInABlender_Human_Temp<-list()

names(table(BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA$Tag))

for(i in c(1:length(names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))))){
  
  BrainInABlender_Mouse_Temp[[i]]<-BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Symbol_Mouse[BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag==names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))[i]]
  
  BrainInABlender_Rat_Temp[[i]]<-BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA$Symbol_Rat[BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA$Tag==names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))[i]]
  
  BrainInABlender_Human_Temp[[i]]<-BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA$Symbol_Human[BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA$Tag==names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))[i]]
  
}

names(BrainInABlender_Mouse_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))
names(BrainInABlender_Rat_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))
names(BrainInABlender_Human_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))

str(BrainInABlender_Mouse_Temp)

library(stringi)

BrainInABlender_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(BrainInABlender_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(BrainInABlender_Mouse_GMT_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))
str(BrainInABlender_Mouse_GMT_Temp)

str(t(BrainInABlender_Mouse_GMT_Temp))
head(t(BrainInABlender_Mouse_GMT_Temp))
BrainInABlender_Mouse_GMT<-t(BrainInABlender_Mouse_GMT_Temp)
write.table(BrainInABlender_Mouse_GMT, "BrainInABlender_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

BrainInABlender_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(BrainInABlender_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(BrainInABlender_Rat_GMT_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))
str(BrainInABlender_Rat_GMT_Temp)

str(t(BrainInABlender_Rat_GMT_Temp))
head(t(BrainInABlender_Rat_GMT_Temp))
BrainInABlender_Rat_GMT<-t(BrainInABlender_Rat_GMT_Temp)
write.table(BrainInABlender_Rat_GMT, "BrainInABlender_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

BrainInABlender_Human_GMT_Temp <- as.data.frame(stri_list2matrix(BrainInABlender_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(BrainInABlender_Human_GMT_Temp)<-names(table(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA$Tag))
str(BrainInABlender_Human_GMT_Temp)

str(t(BrainInABlender_Human_GMT_Temp))
head(t(BrainInABlender_Human_GMT_Temp))
BrainInABlender_Human_GMT<-t(BrainInABlender_Human_GMT_Temp)
write.table(BrainInABlender_Human_GMT, "BrainInABlender_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

