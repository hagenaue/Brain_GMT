#Determining formal orthologs between the data from different species:

setwd("~/Documents/Microarray Gen/GeneOrthology_HumanRatMouse")

#I downloaded formal ortholog information from: http://www.informatics.jax.org/homology.shtml
#Let's reorganize it to make it easier to work with:
Orthologs<-read.delim("InformaticsJax_OrthologDatabase_20210228.txt", header=TRUE, sep="\t", stringsAsFactors = FALSE)
str(Orthologs)
Orthologs_Mice<-Orthologs[Orthologs$Common.Organism.Name=="mouse, laboratory",]
str(Orthologs_Mice)
#'data.frame':	20891 obs. of  12 variables:

colnames(Orthologs_Mice)[c(2:12)]<-paste(colnames(Orthologs_Mice)[c(2:12)], "_Mouse", sep="")

Orthologs_Rat<-Orthologs[Orthologs$Common.Organism.Name=="rat",]
str(Orthologs_Rat)
#"'data.frame':	20606 obs. of  12 variables:"

colnames(Orthologs_Rat)[c(2:12)]<-paste(colnames(Orthologs_Rat)[c(2:12)], "_Rat", sep="")

Orthologs_Mice_Rats<-join(Orthologs_Mice, Orthologs_Rat, by="HomoloGene.ID", type="left", match="all")
str(Orthologs_Mice_Rats)
#'data.frame':	22814 obs. of  23 variables:


Orthologs_Human<-Orthologs[Orthologs$Common.Organism.Name=="human",]
str(Orthologs_Human)
#"'data.frame':	19124 obs. of  12 variables:"

colnames(Orthologs_Human)[c(2:12)]<-paste(colnames(Orthologs_Human)[c(2:12)], "_Human", sep="")

Orthologs_Mice_Humans<-join(Orthologs_Mice, Orthologs_Human, by="HomoloGene.ID", type="left", match="all")
str(Orthologs_Mice_Humans)
#'data.frame':	21021 obs. of  23 variables:

Orthologs_Rats_Humans<-join(Orthologs_Rat, Orthologs_Human, by="HomoloGene.ID", type="left", match="all")
str(Orthologs_Rats_Humans)
#'data.frame':	20728 obs. of  23 variables:

#Out of curiousity, how much does this actually gain me over just using gene symbol equivalency?
sum(Orthologs_Mice_Rats$Symbol_Mouse==Orthologs_Mice_Rats$Symbol_Rat, na.rm=TRUE)
#[1] 15728
sum(is.na(Orthologs_Mice_Rats$Symbol_Rat)==TRUE|is.na(Orthologs_Mice_Rats$Symbol_Mouse)==TRUE)
#[1] 2176
15728/(22814-2176)
#[1] 0.7620893
#Interesting - symbols are only equivalent for ~3/4 of the genes (according to this database)

Orthologs_Mice_Rats_Symbols<-data.frame(Orthologs_Mice_Rats$Symbol_Mouse, Orthologs_Mice_Rats$Symbol_Rat, stringsAsFactors = FALSE)
colnames(Orthologs_Mice_Rats_Symbols)<-c("Symbol_Mouse", "Symbol_Rat")
sum(is.na(Orthologs_Mice_Rats_Symbols$Symbol_Rat))
#[1] 2176

Orthologs_Mice_Rats_Symbols_NoNA<-Orthologs_Mice_Rats_Symbols[is.na(Orthologs_Mice_Rats_Symbols$Symbol_Rat)==FALSE & is.na(Orthologs_Mice_Rats$Symbol_Mouse)==FALSE,]
str(Orthologs_Mice_Rats_Symbols_NoNA)
# 'data.frame':	20638 obs. of  2 variables:
# $ Symbol_Mouse: chr  "Acadm" "Acadvl" "Acat1" "Acvr1" ...
# $ Symbol_Rat  : chr  "Acadm" "Acadvl" "Acat1" "Acvr1" ...


Orthologs_Mice_Humans_Symbols<-data.frame(Orthologs_Mice_Humans$Symbol_Mouse, Orthologs_Mice_Humans$Symbol_Human, stringsAsFactors = FALSE)
colnames(Orthologs_Mice_Humans_Symbols)<-c("Symbol_Mouse", "Symbol_Human")
sum(is.na(Orthologs_Mice_Humans_Symbols$Symbol_Human)==TRUE | is.na(Orthologs_Mice_Humans$Symbol_Mouse)==TRUE)
#[1] 3705

Orthologs_Mice_Humans_Symbols_NoNA<-Orthologs_Mice_Humans_Symbols[is.na(Orthologs_Mice_Humans_Symbols$Symbol_Human)==FALSE & is.na(Orthologs_Mice_Humans$Symbol_Mouse)==FALSE,]
str(Orthologs_Mice_Humans_Symbols_NoNA)
#'data.frame':	17316 obs. of  2 variables:
# $ Symbol_Mouse: chr  "Acadm" "Acadvl" "Acat1" "Acvr1" ...
# $ Symbol_Human: chr  "ACADM" "ACADVL" "ACAT1" "ACVR1" ...

#hmmm... let's double check whether the date genes are problematic in this dataset:
Orthologs_Mice_Humans_Symbols_NoNA$Symbol_Mouse[Orthologs_Mice_Humans_Symbols_NoNA$Symbol_Mouse=="Septin9"]
#[1] "Septin9"
#Nope, looks like they have been updated. *phew*

Orthologs_Rats_Humans_Symbols<-data.frame(Orthologs_Rats_Humans$Symbol_Rat, Orthologs_Rats_Humans$Symbol_Human, stringsAsFactors = FALSE)
colnames(Orthologs_Rats_Humans_Symbols)<-c("Symbol_Rat", "Symbol_Human")
sum(is.na(Orthologs_Rats_Humans_Symbols$Symbol_Human)==TRUE | is.na(Orthologs_Rats_Humans_Symbols$Symbol_Rat)==TRUE)
#[1] 3746

Orthologs_Rats_Humans_Symbols_NoNA<-Orthologs_Rats_Humans_Symbols[is.na(Orthologs_Rats_Humans_Symbols$Symbol_Human)==FALSE & is.na(Orthologs_Rats_Humans_Symbols$Symbol_Rat)==FALSE,]
str(Orthologs_Rats_Humans_Symbols_NoNA)
# 'data.frame':	16982 obs. of  2 variables:
# $ Symbol_Rat  : chr  "Acadm" "Acadvl" "Acat1" "Acvr1" ...
# $ Symbol_Human: chr  "ACADM" "ACADVL" "ACAT1" "ACVR1" ...

write.csv(Orthologs_Mice_Rats,"Orthologs_Mice_Rats_InformaticsJax_OrthologDatabase_20210228.txt")
write.csv(Orthologs_Rats_Humans, "Orthologs_Rats_Humans_InformaticsJax_OrthologDatabase_20210228.txt")
write.csv(Orthologs_Mice_Humans, "Orthologs_Mice_Humans_InformaticsJax_OrthologDatabase_20210228.txt")

write.csv(Orthologs_Mice_Rats_Symbols_NoNA,"Orthologs_Mice_Rats_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt")
write.csv(Orthologs_Rats_Humans_Symbols_NoNA, "Orthologs_Rats_Humans_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt")
write.csv(Orthologs_Mice_Humans_Symbols_NoNA, "Orthologs_Mice_Humans_Symbols_NoNA_InformaticsJax_OrthologDatabase_20210228.txt")

Orthologs_Mice_MiceAllCaps_Symbols<-data.frame(Orthologs_Mice$Symbol_Mouse, toupper(Orthologs_Mice$Symbol_Mouse), stringsAsFactors = FALSE)
colnames(Orthologs_Mice_MiceAllCaps_Symbols)<-c("Symbol_Mouse", "Symbol_Mouse_AsUpperCase")
sum(is.na(Orthologs_Mice_MiceAllCaps_Symbols$Symbol_Mouse))
#[1] 0

str(DropViz_HC_CellTypeClusterMarkers)
colnames(DropViz_HC_CellTypeClusterMarkers)[1]<-"Symbol_Mouse"
colnames(DropViz_HC_CellTypeClusterMarkers_Concise)[1]<-"Symbol_Mouse"
colnames(DropViz_STR_CellTypeClusterMarkers)[1]<-"Symbol_Mouse"
colnames(DropViz_STR_CellTypeClusterMarkers_Concise)[1]<-"Symbol_Mouse"

str(DropViz_HC_CellTypeClusterMarkers)
#'data.frame':	4780 obs. of  21 variables:
#'
DropViz_HC_CellTypeClusterMarkers_RatOrthologs<-join(DropViz_HC_CellTypeClusterMarkers, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_HC_CellTypeClusterMarkers_RatOrthologs)
#'data.frame':	4450 obs. of  43 variables:

write.csv(DropViz_HC_CellTypeClusterMarkers_RatOrthologs, "DropViz_HC_CellTypeClusterMarkers_RatOrthologs.csv")

DropViz_HC_CellTypeClusterMarkers_HumanOrthologs<-join(DropViz_HC_CellTypeClusterMarkers, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_HC_CellTypeClusterMarkers_HumanOrthologs)
#'data.frame':	4271 obs. of  22 variables:

write.csv(DropViz_HC_CellTypeClusterMarkers_HumanOrthologs, "DropViz_HC_CellTypeClusterMarkers_HumanOrthologs.csv")


DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs<-join(DropViz_HC_CellTypeClusterMarkers_Concise, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs)
#'data.frame':	1597 obs. of  22 variables:

write.csv(DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs, "DropViz_HC_CellTypeClusterMarkers_Concise_RatOrthologs.csv")


DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs<-join(DropViz_HC_CellTypeClusterMarkers_Concise, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs)
#'data.frame':	1518 obs. of  22 variables:

write.csv(DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs, "DropViz_HC_CellTypeClusterMarkers_Concise_HumanOrthologs.csv")


DropViz_STR_CellTypeClusterMarkers_RatOrthologs<-join(DropViz_STR_CellTypeClusterMarkers, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_STR_CellTypeClusterMarkers_RatOrthologs)
#'data.frame':	4729 obs. of  22 variables:

write.csv(DropViz_STR_CellTypeClusterMarkers_RatOrthologs, "DropViz_STR_CellTypeClusterMarkers_RatOrthologs.csv")


DropViz_STR_CellTypeClusterMarkers_HumanOrthologs<-join(DropViz_STR_CellTypeClusterMarkers, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_STR_CellTypeClusterMarkers_HumanOrthologs)
#'data.frame':	4476 obs. of  22 variables:

write.csv(DropViz_STR_CellTypeClusterMarkers_HumanOrthologs, "DropViz_STR_CellTypeClusterMarkers_HumanOrthologs.csv")


DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs<-join(DropViz_STR_CellTypeClusterMarkers_Concise, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs)
#'data.frame':	1667 obs. of  22 variables:

write.csv(DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs, "DropViz_STR_CellTypeClusterMarkers_Concise_RatOrthologs.csv")


DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs<-join(DropViz_STR_CellTypeClusterMarkers_Concise, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs)
#'data.frame':	1579 obs. of  22 variables:
#'
write.csv(DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs, "DropViz_STR_CellTypeClusterMarkers_Concise_HumanOrthologs.csv")

str(Zeisel_CA1PyramidalIndex)
#'data.frame':	409 obs. of  1 variable:

colnames(Zeisel_CA1PyramidalIndex)[1]<-"Symbol_Mouse_AsUpperCase"
str(Zeisel_CA1PyramidalIndex)
Zeisel_CA1PyramidalIndex$Dataset<-"Zeisel_CA1PyramidalNeurons_HC"
str(Zeisel_CA1PyramidalIndex)
Orthologs_Mice_Rats_Symbols_NoNA$Symbol_Mouse_AsUpperCase<-toupper(Orthologs_Mice_Rats_Symbols_NoNA$Symbol_Mouse)

Zeisel_CA1PyramidalIndex_RatOrthologs<-join(Zeisel_CA1PyramidalIndex, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse_AsUpperCase", type="inner", match="all")
str(Zeisel_CA1PyramidalIndex_RatOrthologs)
#'data.frame':	335 obs. of  4 variables:

write.csv(Zeisel_CA1PyramidalIndex_RatOrthologs, "Zeisel_CA1PyramidalIndex_RatOrthologs.csv")

Orthologs_Mice_Humans_Symbols_NoNA$Symbol_Mouse_AsUpperCase<-toupper(Orthologs_Mice_Humans_Symbols_NoNA$Symbol_Mouse)

Zeisel_CA1PyramidalIndex_HumanOrthologs<-join(Zeisel_CA1PyramidalIndex, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse_AsUpperCase", type="inner", match="all")
str(Zeisel_CA1PyramidalIndex_HumanOrthologs)
#'data.frame':	333 obs. of  4 variables:
write.csv(Zeisel_CA1PyramidalIndex_HumanOrthologs, "Zeisel_CA1PyramidalIndex_HumanOrthologs.csv")

#Note: in this code document I don't have code translating the upper case Mouse symbols into standard Mouse symbols
#When I realized that was missing later, I just quickly fixed the formatting in Excel
#However, I wrote code for fixing this issue later on for the HCSpecific .GMT using the object that I created to translate: "Orthologs_Mice_MiceAllCaps_Symbols" 

str(StressGeneSets)
"'data.frame':	2469 obs. of  2 variables:"

colnames(StressGeneSets)<-"Symbol_Mouse"


StressGeneSets_RatOrthologs<-join(StressGeneSets, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(StressGeneSets_RatOrthologs)
#'data.frame':	1998 obs. of  3 variables:
#That's a bigger hit - many of these symbols must be old.

write.csv(StressGeneSets_RatOrthologs, "StressGeneSets_RatOrthologs.csv")

StressGeneSets_HumanOrthologs<-join(StressGeneSets, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(StressGeneSets_HumanOrthologs)
#'data.frame':	1919 obs. of  3 variables:
#'#Ouch! almost half of the gene symbols from the original datasets don't have human orthologs. Gah.

write.csv(StressGeneSets_HumanOrthologs, "StressGeneSets_HumanOrthologs.csv")

StressGeneSets_MouseOrthologs_Symbols_NoNA<-unique(StressGeneSets[,c(1,2)])
str(StressGeneSets_MouseOrthologs_Symbols_NoNA)
#'data.frame':	2469 obs. of  2 variables:
sum(is.na(StressGeneSets_MouseOrthologs_Symbols_NoNA$Symbol_Mouse))
#[1] 0
write.csv(StressGeneSets_MouseOrthologs_Symbols_NoNA, "StressGeneSets_MouseOrthologs_Symbols_NoNA.csv")

str(StressGeneSets_RatOrthologs)
#'data.frame':	1998 obs. of  4 variables:
StressGeneSets_RatOrthologs_Symbols_NoNA<-unique(StressGeneSets_RatOrthologs[,c(3,2)])
str(StressGeneSets_RatOrthologs_Symbols_NoNA)
#'data.frame':	1996 obs. of  2 variables:
sum(is.na(StressGeneSets_RatOrthologs_Symbols_NoNA$Symbol_Rat))
#[1] 0
write.csv(StressGeneSets_RatOrthologs_Symbols_NoNA, "StressGeneSets_RatOrthologs_Symbols_NoNA.csv")

str(StressGeneSets_HumanOrthologs)
#'data.frame':	1919 obs. of  4 variables:
StressGeneSets_HumanOrthologs_Symbols_NoNA<-unique(StressGeneSets_HumanOrthologs[,c(3,2)])
str(StressGeneSets_HumanOrthologs_Symbols_NoNA)
#'data.frame':	1915 obs. of  2 variables:
sum(is.na(StressGeneSets_HumanOrthologs_Symbols_NoNA$Symbol_Human))
#[1] 0
write.csv(StressGeneSets_HumanOrthologs_Symbols_NoNA, "StressGeneSets_HumanOrthologs_Symbols_NoNA.csv")

str(HumanPsychiatricGeneSets)
#'data.frame':	4416 obs. of  2 variables:
colnames(HumanPsychiatricGeneSets)[1]<-"Symbol_Human"

HumanPsychiatricGeneSets_MouseOrthologs<-join(HumanPsychiatricGeneSets, Orthologs_Mice_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
str(HumanPsychiatricGeneSets_MouseOrthologs)
#'data.frame':	3971 obs. of  3 variables:

write.csv(HumanPsychiatricGeneSets_MouseOrthologs, "HumanPsychiatricGeneSets_MouseOrthologs.csv")

HumanPsychiatricGeneSets_RatOrthologs<-join(HumanPsychiatricGeneSets, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
str(HumanPsychiatricGeneSets_RatOrthologs)
#'data.frame':	3866 obs. of  3 variables:

write.csv(HumanPsychiatricGeneSets_RatOrthologs, "HumanPsychiatricGeneSets_RatOrthologs.csv")

str(HumanPsychiatricGeneSets)
#'data.frame':	4416 obs. of  2 variables:
HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA<-unique(HumanPsychiatricGeneSets[,c(1:2)])
str(HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA)
#'data.frame':	4416 obs. of  2 variables:
sum(is.na(HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA$Symbol_Human))
#[1] 0
write.csv(HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA, "HumanPsychiatricGeneSets_HumanOrthologs_JustSymbols_NoNA.csv")

str(HumanPsychiatricGeneSets_MouseOrthologs)
#'data.frame':	3971 obs. of  3 variables:
HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA<-unique(HumanPsychiatricGeneSets_MouseOrthologs[,c(3:2)])
str(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA)
#'data.frame':	3970 obs. of  2 variables:
sum(is.na(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA$Symbol_Mouse))
#[1] 0
write.csv(HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA, "HumanPsychiatricGeneSets_MouseOrthologs_JustSymbols_NoNA.csv")

str(HumanPsychiatricGeneSets_RatOrthologs)
#'data.frame':	3866 obs. of  3 variables:
HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA<-unique(HumanPsychiatricGeneSets_RatOrthologs[,c(3:2)])
str(HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA)
#'data.frame':	3863 obs. of  2 variables:
sum(is.na(HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA$Symbol_Rat))
#[1] 0
write.csv(HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA, "HumanPsychiatricGeneSets_RatOrthologs_JustSymbols_NoNA.csv")



colnames(BrainInABlenderDatabase_Human)[4]<-"Symbol_Human"
colnames(BrainInABlenderDatabase_Human)[5]<-"Symbol_Mouse"
colnames(BrainInABlenderDatabase_Mouse)[4]<-"Symbol_Human"
colnames(BrainInABlenderDatabase_Mouse)[5]<-"Symbol_Mouse"

BrainInABlenderDatabase_Mouse_RatOrthologs<-join(BrainInABlenderDatabase_Mouse, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Mouse", type="inner", match="all")
str(BrainInABlenderDatabase_Mouse_RatOrthologs)

BrainInABlenderDatabase_Human_RatOrthologs<-join(BrainInABlenderDatabase_Human, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Human", type="inner", match="all")
str(BrainInABlenderDatabase_Human_RatOrthologs)

write.csv(BrainInABlenderDatabase_Human_RatOrthologs, "BrainInABlenderDatabase_Human_RatOrthologs.csv")
write.csv(BrainInABlenderDatabase_Mouse_RatOrthologs, "BrainInABlenderDatabase_Mouse_RatOrthologs.csv")

#hmm... I'm pretty sure that still includes NAs and duplicates though. Let's simplify it down:

BrainInABlenderDatabase_Human_JustSymbols<-BrainInABlenderDatabase_Human[,c(4,5,13)] 
BrainInABlenderDatabase_Mouse_JustSymbols<-BrainInABlenderDatabase_Mouse[,c(4,5,13)] 

BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols<-BrainInABlenderDatabase_Human_RatOrthologs[,c(15,13)] 
BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols<-BrainInABlenderDatabase_Mouse_RatOrthologs[,c(15,13)] 


str(BrainInABlenderDatabase_Mouse_JustSymbols)
#'data.frame':	3240 obs. of  3 variables:
BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA<-unique(BrainInABlenderDatabase_Mouse_JustSymbols[,c(1,3)])
head(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA)
str(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA)
#'data.frame':	2853 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA$Symbol_Human))
#[1] 29
BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA<-BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA[is.na(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA$Symbol_Human)==FALSE,]
str(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA)
#'data.frame':	2824 obs. of  2 variables:

str(BrainInABlenderDatabase_Mouse_JustSymbols)
#'data.frame':	3240 obs. of  3 variables:
BrainInABlenderDatabase_Mouse_JustSymbols_MouseOrthologs_NoNA<-unique(BrainInABlenderDatabase_Mouse_JustSymbols[,c(2,3)])
head(BrainInABlenderDatabase_Mouse_JustSymbols_MouseOrthologs_NoNA)
str(BrainInABlenderDatabase_Mouse_JustSymbols_MouseOrthologs_NoNA)
#'data.frame':	3218 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Mouse_JustSymbols_MouseOrthologs_NoNA$Symbol_Mouse))
#[1] 0

str(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols)
#'data.frame':	2735 obs. of  2 variables:
BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols_RatOrthologs_NoNA<-unique(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols[,c(1,2)])
head(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols_RatOrthologs_NoNA)
str(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols_RatOrthologs_NoNA)
#'data.frame':	2690 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols_RatOrthologs_NoNA$Symbol_Rat))
#[1] 0

str(BrainInABlenderDatabase_Human_JustSymbols)
#'data.frame':	143 obs. of  3 variables:
BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA<-unique(BrainInABlenderDatabase_Human_JustSymbols[,c(1,3)])
head(BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA)
str(BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA)
#'data.frame':	143 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA$Symbol_Human))
#[1] 0

str(BrainInABlenderDatabase_Human_JustSymbols)
#'data.frame':	143 obs. of  3 variables:
BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA<-unique(BrainInABlenderDatabase_Human_JustSymbols[,c(2,3)])
head(BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA)
str(BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA)
#'data.frame':	139 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA$Symbol_Mouse))
#[1] 5
BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA<-BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA[is.na(BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA$Symbol_Mouse)==FALSE,]
str(BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA)
#'data.frame':	134 obs. of  2 variables:

str(BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols)
#'data.frame':	129 obs. of  2 variables:
BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols_RatOrthologs_NoNA<-unique(BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols[,c(1,2)])
head(BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols_RatOrthologs_NoNA)
str(BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols_RatOrthologs_NoNA)
#'data.frame':	128 obs. of  2 variables:
sum(is.na(BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols_RatOrthologs_NoNA$Symbol_Rat))
#[1] 0

#Can I just combine these together now to make life easier?

str(BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA)
str(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA)

BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA<-rbind.data.frame(BrainInABlenderDatabase_Mouse_JustSymbols_HumanOrthologs_NoNA, BrainInABlenderDatabase_Human_JustSymbols_HumanOrthologs_NoNA)

BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA<-rbind.data.frame(BrainInABlenderDatabase_Mouse_JustSymbols_MouseOrthologs_NoNA, BrainInABlenderDatabase_Human_JustSymbols_MouseOrthologs_NoNA)

BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA<-rbind.data.frame(BrainInABlenderDatabase_Mouse_RatOrthologs_JustSymbols_RatOrthologs_NoNA, BrainInABlenderDatabase_Human_RatOrthologs_JustSymbols_RatOrthologs_NoNA)

write.csv(BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA, "BrainInABlenderDatabase_All_JustSymbols_HumanOrthologs_NoNA.csv")
write.csv(BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA, "BrainInABlenderDatabase_All_JustSymbols_MouseOrthologs_NoNA.csv")
write.csv(BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA, "BrainInABlenderDatabase_All_JustSymbols_RatOrthologs_NoNA.csv")



str(InternalizingBehaviorGeneSets)

str(InternalizingBehaviorGeneSets)
# 'data.frame':	3219 obs. of  2 variables:
#   $ GeneSymbol_Rat: chr  "Abhd10" "Acbd4" "Acss2" "Adam19" ...
# $ DatasetName   : chr  "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" ...

colnames(InternalizingBehaviorGeneSets)[1]<-"Symbol_Rat"

InternalizingBehaviorGeneSets_MouseOrthologs<-join(InternalizingBehaviorGeneSets, Orthologs_Mice_Rats_Symbols_NoNA, by="Symbol_Rat", type="inner", match="all")
str(InternalizingBehaviorGeneSets_MouseOrthologs)
# 'data.frame':	2815 obs. of  4 variables:
#   $ Symbol_Rat              : chr  "Abhd10" "Acbd4" "Acss2" "Adam19" ...
# $ DatasetName             : chr  "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" ...
# $ Symbol_Mouse            : chr  "Abhd10" "Acbd4" "Acss2" "Adam19" ...
# $ Symbol_Mouse_AsUpperCase: chr  "ABHD10" "ACBD4" "ACSS2" "ADAM19" ...

write.csv(InternalizingBehaviorGeneSets_MouseOrthologs, "InternalizingBehaviorGeneSets_MouseOrthologs.csv")

InternalizingBehaviorGeneSets_HumanOrthologs<-join(InternalizingBehaviorGeneSets, Orthologs_Rats_Humans_Symbols_NoNA, by="Symbol_Rat", type="inner", match="all")
str(InternalizingBehaviorGeneSets_HumanOrthologs)
# 'data.frame':	2690 obs. of  3 variables:
#   $ Symbol_Rat  : chr  "Abhd10" "Acbd4" "Acss2" "Adam19" ...
# $ DatasetName : chr  "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" "Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC" ...
# $ Symbol_Human: chr  "ABHD10" "ACBD4" "ACSS2" "ADAM19" ...

write.csv(InternalizingBehaviorGeneSets_HumanOrthologs, "InternalizingBehaviorGeneSets_HumanOrthologs.csv")

#Let's make a version with duplicates and NAs removed:

str(InternalizingBehaviorGeneSets)
#'data.frame':	3219 obs. of  2 variables:
InternalizingBehaviorGeneSets_RatOrthologs_NoNA<-unique(InternalizingBehaviorGeneSets[,c(1:2)])
str(InternalizingBehaviorGeneSets_RatOrthologs_NoNA)
#'data.frame':	3219 obs. of  2 variables:
InternalizingBehaviorGeneSets_RatOrthologs_NoNA<-InternalizingBehaviorGeneSets_RatOrthologs_NoNA[is.na(InternalizingBehaviorGeneSets_RatOrthologs_NoNA$Symbol_Rat)==FALSE,]
str(InternalizingBehaviorGeneSets_RatOrthologs_NoNA)
#'data.frame':	3219 obs. of  2 variables:

str(InternalizingBehaviorGeneSets_MouseOrthologs)
#'data.frame':	2815 obs. of  4 variables:
InternalizingBehaviorGeneSets_MouseOrthologs_NoNA<-unique(InternalizingBehaviorGeneSets_MouseOrthologs[,c(3,2)])
str(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA)
#'data.frame':	2815 obs. of  2 variables:
InternalizingBehaviorGeneSets_MouseOrthologs_NoNA<-InternalizingBehaviorGeneSets_MouseOrthologs_NoNA[is.na(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA$Symbol_Mouse)==FALSE,]
str(InternalizingBehaviorGeneSets_MouseOrthologs_NoNA)
#'data.frame':	2815 obs. of  2 variables:

str(InternalizingBehaviorGeneSets_HumanOrthologs)
#'data.frame':	2690 obs. of  3 variables:
InternalizingBehaviorGeneSets_HumanOrthologs_NoNA<-unique(InternalizingBehaviorGeneSets_HumanOrthologs[,c(3,2)])
str(InternalizingBehaviorGeneSets_HumanOrthologs_NoNA)
#'data.frame':	2690 obs. of  2 variables:
InternalizingBehaviorGeneSets_HumanOrthologs_NoNA<-InternalizingBehaviorGeneSets_HumanOrthologs_NoNA[is.na(InternalizingBehaviorGeneSets_HumanOrthologs_NoNA$Symbol_Human)==FALSE,]
str(InternalizingBehaviorGeneSets_HumanOrthologs_NoNA)
#'data.frame':	2690 obs. of  2 variables:
