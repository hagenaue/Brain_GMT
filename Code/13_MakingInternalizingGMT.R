InternalizingBehavior_Mouse_Temp<-list()
InternalizingBehavior_Rat_Temp<-list()
InternalizingBehavior_Human_Temp<-list()

names(table(InternalizingBehaviorGeneSets_RatOrthologs_NoNA$DatasetName))

for(i in c(1:length(names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))))){
  
  InternalizingBehavior_Mouse_Temp[[i]]<-InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$Symbol_Mouse[InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName==names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))[i]]
  
  InternalizingBehavior_Rat_Temp[[i]]<-InternalizingBehaviorGeneSets_RatOrthologs_NoNA$Symbol_Rat[InternalizingBehaviorGeneSets_RatOrthologs_NoNA$DatasetName==names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))[i]]
  
  InternalizingBehavior_Human_Temp[[i]]<-InternalizingBehaviorGeneSets_HumanOrthologs_NoNA$Symbol_Human[InternalizingBehaviorGeneSets_HumanOrthologs_NoNA$DatasetName==names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))[i]]
  
}

names(InternalizingBehavior_Mouse_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))
names(InternalizingBehavior_Rat_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))
names(InternalizingBehavior_Human_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))

str(InternalizingBehavior_Mouse_Temp)

library(stringi)

InternalizingBehavior_Mouse_GMT_Temp <- as.data.frame(stri_list2matrix(InternalizingBehavior_Mouse_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(InternalizingBehavior_Mouse_GMT_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))
str(InternalizingBehavior_Mouse_GMT_Temp)

str(t(InternalizingBehavior_Mouse_GMT_Temp))
head(t(InternalizingBehavior_Mouse_GMT_Temp))
InternalizingBehavior_Mouse_GMT<-t(InternalizingBehavior_Mouse_GMT_Temp)
write.table(InternalizingBehavior_Mouse_GMT, "InternalizingBehavior_Mouse_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

InternalizingBehavior_Rat_GMT_Temp <- as.data.frame(stri_list2matrix(InternalizingBehavior_Rat_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(InternalizingBehavior_Rat_GMT_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))
str(InternalizingBehavior_Rat_GMT_Temp)

str(t(InternalizingBehavior_Rat_GMT_Temp))
head(t(InternalizingBehavior_Rat_GMT_Temp))
InternalizingBehavior_Rat_GMT<-t(InternalizingBehavior_Rat_GMT_Temp)
write.table(InternalizingBehavior_Rat_GMT, "InternalizingBehavior_Rat_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = TRUE)

InternalizingBehavior_Human_GMT_Temp <- as.data.frame(stri_list2matrix(InternalizingBehavior_Human_Temp, byrow = FALSE), stringsAsFactors=FALSE)
names(InternalizingBehavior_Human_GMT_Temp)<-names(table(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$DatasetName))
str(InternalizingBehavior_Human_GMT_Temp)

str(t(InternalizingBehavior_Human_GMT_Temp))
head(t(InternalizingBehavior_Human_GMT_Temp))
InternalizingBehavior_Human_GMT<-t(InternalizingBehavior_Human_GMT_Temp)
write.table(InternalizingBehavior_Human_GMT, "InternalizingBehavior_Human_GMT.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

