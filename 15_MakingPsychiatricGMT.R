

HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA
HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA
HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA

HumanPsychiatricGeneSets_Mouse_Temp<-list()
HumanPsychiatricGeneSets_Rat_Temp<-list()
HumanPsychiatricGeneSets_Human_Temp<-list()

names(table(HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA$DatasetName))

for(i in c(1:length(names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))))){
  
  HumanPsychiatricGeneSets_Mouse_Temp[[i]]<-HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$Symbol_Mouse[HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName==names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))[i]]
  
  HumanPsychiatricGeneSets_Rat_Temp[[i]]<-HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA$Symbol_Rat[HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA$DatasetName==names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))[i]]
  
  HumanPsychiatricGeneSets_Human_Temp[[i]]<-HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA$Symbol_Human[HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA$DatasetName==names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))[i]]
  
}

names(HumanPsychiatricGeneSets_Mouse_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))
names(HumanPsychiatricGeneSets_Rat_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))
names(HumanPsychiatricGeneSets_Human_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))

str(HumanPsychiatricGeneSets_Mouse_Temp)

library(stringi)

HumanPsychiatricGeneSets_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(HumanPsychiatricGeneSets_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(HumanPsychiatricGeneSets_Mouse_GMT_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))
str(HumanPsychiatricGeneSets_Mouse_GMT_Temp)

str(t(HumanPsychiatricGeneSets_Mouse_GMT_Temp))
head(t(HumanPsychiatricGeneSets_Mouse_GMT_Temp))
HumanPsychiatricGeneSets_Mouse_GMT<-t(HumanPsychiatricGeneSets_Mouse_GMT_Temp)
write.table(HumanPsychiatricGeneSets_Mouse_GMT, "HumanPsychiatricGeneSets_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

HumanPsychiatricGeneSets_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(HumanPsychiatricGeneSets_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(HumanPsychiatricGeneSets_Rat_GMT_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))
str(HumanPsychiatricGeneSets_Rat_GMT_Temp)

str(t(HumanPsychiatricGeneSets_Rat_GMT_Temp))
head(t(HumanPsychiatricGeneSets_Rat_GMT_Temp))
HumanPsychiatricGeneSets_Rat_GMT<-t(HumanPsychiatricGeneSets_Rat_GMT_Temp)
write.table(HumanPsychiatricGeneSets_Rat_GMT, "HumanPsychiatricGeneSets_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

HumanPsychiatricGeneSets_Human_GMT_Temp <- as.data.frame(stri_list2matrix(HumanPsychiatricGeneSets_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(HumanPsychiatricGeneSets_Human_GMT_Temp)<-names(table(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$DatasetName))
str(HumanPsychiatricGeneSets_Human_GMT_Temp)

str(t(HumanPsychiatricGeneSets_Human_GMT_Temp))
head(t(HumanPsychiatricGeneSets_Human_GMT_Temp))
HumanPsychiatricGeneSets_Human_GMT<-t(HumanPsychiatricGeneSets_Human_GMT_Temp)
write.table(HumanPsychiatricGeneSets_Human_GMT, "HumanPsychiatricGeneSets_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

