
#Fixing lurking issues with genes with date names (since that problem in the gene symbol annotation was only changed mid-2020):

DateGeneDecoder<-read.delim("DateGeneDecoder.txt", sep=",", header=TRUE, stringsAsFactors = FALSE)
str(DateGeneDecoder)
# 'data.frame':	28 obs. of  3 variables:
# $ OldSymbol: chr  "Sept1" "Sept2" "Sept3" "Sept4" ...
# $ NewSymbol: chr  "Septin1" "Septin2" "Septin3" "Septin4" ...
# $ ExcelDate: chr  "1-Sep" "2-Sep" "3-Sep" "4-Sep" ...

DateGeneDecoder_Human<-DateGeneDecoder
DateGeneDecoder_Human$OldSymbol<-toupper(DateGeneDecoder$OldSymbol)
DateGeneDecoder_Human$NewSymbol<-toupper(DateGeneDecoder$NewSymbol)


StressGeneSets[StressGeneSets$GeneSymbol_Mouse%in%DateGeneDecoder$OldSymbol|StressGeneSets$GeneSymbol_Mouse%in%DateGeneDecoder$ExcelDate,]
# GeneSymbol_Mouse                                 DatasetName
# 1492            5-Sep Gray_2014_ForcedSwimStress_Downregulated_HC

StressGeneSets$GeneSymbol_Mouse[StressGeneSets$GeneSymbol_Mouse=="5-Sep"]<-"Septin5"

#Well that one was easy...

write.csv(StressGeneSets, "StressGeneSets_DateGenesFixed.csv")

HumanPsychiatricGeneSets[HumanPsychiatricGeneSets$GeneSymbol_Human%in%DateGeneDecoder_Human$OldSymbol|HumanPsychiatricGeneSets$GeneSymbol_Human%in%DateGeneDecoder_Human$ExcelDate,]
#     GeneSymbol_Human                                           DatasetName
# 67             MARCH2           Gandal_2018_Schizophrenia_Downregulated_PFC
# 240            SEPT11           Gandal_2018_Schizophrenia_Downregulated_PFC
# 775            MARCH3             Gandal_2018_Schizophrenia_Upregulated_PFC
# 2275            2-Mar        Gandal_2018_BipolarDisorder_Upregulated_Cortex
# 2359            3-Mar        Gandal_2018_BipolarDisorder_Upregulated_Cortex
# 3235            5-Sep   Gandal_2018_AlcoholAbuseDisorder_Upregulated_Cortex
# 4315            3-Mar Gandal_2018_AutismSpectrumDisorder_Upregulated_Cortex

HumanPsychiatricGeneSets$GeneSymbol_Human[HumanPsychiatricGeneSets$GeneSymbol_Human=="MARCH2"]<-"MARCHF2"
HumanPsychiatricGeneSets$GeneSymbol_Human[HumanPsychiatricGeneSets$GeneSymbol_Human=="SEPT11"]<-"SEPTIN11"
HumanPsychiatricGeneSets$GeneSymbol_Human[HumanPsychiatricGeneSets$GeneSymbol_Human=="2-Mar"]<-"MARCHF2"
HumanPsychiatricGeneSets$GeneSymbol_Human[HumanPsychiatricGeneSets$GeneSymbol_Human=="3-Mar"]<-"MARCHF3"
HumanPsychiatricGeneSets$GeneSymbol_Human[HumanPsychiatricGeneSets$GeneSymbol_Human=="5-Sep"]<-"SEPTIN5"

#That was also easy.

write.csv(HumanPsychiatricGeneSets, "HumanPsychiatricGeneSets_DateGenesFixed.csv")

#I should probably double-check that there aren't any more lurking in the DropViz or Zeisel data:

DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene%in%DateGeneDecoder$OldSymbol|DropViz_HC_CellTypeClusterMarkers$gene%in%DateGeneDecoder$ExcelDate]
#character(0)
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene%in%DateGeneDecoder$OldSymbol|DropViz_STR_CellTypeClusterMarkers$gene%in%DateGeneDecoder$ExcelDate]
#character(0)

#We got them all. :)

BrainInABlenderDatabase_Human$Gene.Symbol..Human.[BrainInABlenderDatabase_Human$Gene.Symbol..Human.%in%DateGeneDecoder_Human$OldSymbol|BrainInABlenderDatabase_Human$Gene.Symbol..Human.%in%DateGeneDecoder_Human$ExcelDate]
#character(0)
BrainInABlenderDatabase_Human$Gene.Symbol..Mouse.[BrainInABlenderDatabase_Human$Gene.Symbol..Mouse.%in%DateGeneDecoder$OldSymbol|BrainInABlenderDatabase_Human$Gene.Symbol..Mouse.%in%DateGeneDecoder$ExcelDate]
#character(0)

BrainInABlenderDatabase_Mouse$Gene.Symbol..Mouse.[BrainInABlenderDatabase_Mouse$Gene.Symbol..Mouse.%in%DateGeneDecoder$OldSymbol|BrainInABlenderDatabase_Mouse$Gene.Symbol..Mouse.%in%DateGeneDecoder$ExcelDate]
#[1] "Nov" "Nov" "Nov"
BrainInABlenderDatabase_Mouse$Gene.Symbol..Mouse.[BrainInABlenderDatabase_Mouse$Gene.Symbol..Mouse.=="Nov"]<-"Ccn3"

BrainInABlenderDatabase_Mouse$Gene.Symbol..Human.[BrainInABlenderDatabase_Mouse$Gene.Symbol..Human.%in%DateGeneDecoder_Human$OldSymbol|BrainInABlenderDatabase_Mouse$Gene.Symbol..Human.%in%DateGeneDecoder_Human$ExcelDate]
[1] "NOV" "NOV" "NOV"
BrainInABlenderDatabase_Mouse$Gene.Symbol..Human.[BrainInABlenderDatabase_Mouse$Gene.Symbol..Human.=="NOV"]<-"CCN3"

#It is... a little shocking to me that there aren't more. Skeptic that I am, it makes me nervous that the date gene symbols actually converted to dates and then were forced into character format so they turned into numbers. Because that's the stupid sort of shit that Excel does.
#So I went back to Excel and took a peek and that is exactly what happened. 
#So I converted the numbers back to dates (hoping that this version of excel is using the same numeric date references as whichever version created the database...). The dates all line up with March and Sept genes, so I fixed them by hand hoping for the best and reloaded the data.


str(InternalizingBehaviorGeneSets)
InternalizingBehaviorGeneSets[InternalizingBehaviorGeneSets$GeneSymbol_Rat%in%DateGeneDecoder$OldSymbol|InternalizingBehaviorGeneSets$GeneSymbol_Rat%in%DateGeneDecoder$ExcelDate,]
# GeneSymbol_Rat                                         DatasetName
# 365             Nov   Blaveri_2010_FlindersSensitiveLine_Upregulated_HC
# 431           Sept6   Blaveri_2010_FlindersSensitiveLine_Upregulated_HC
# 836          March8 Blaveri_2010_FlindersSensitiveLine_Downregulated_HC
# 999           Sept2 Blaveri_2010_FlindersSensitiveLine_Downregulated_HC
# 1000          Sept5 Blaveri_2010_FlindersSensitiveLine_Downregulated_HC
# 1001          Sept8 Blaveri_2010_FlindersSensitiveLine_Downregulated_HC
# 1905         Sept10                Meckes_2018_WKYvsF344_Upregulated_HC

InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Sept6"]<-"Septin6"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Sept2"]<-"Septin2"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Sept5"]<-"Septin5"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Sept8"]<-"Septin8"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Sept10"]<-"Septin10"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="March8"]<-"Marchf8"
InternalizingBehaviorGeneSets$GeneSymbol_Rat[InternalizingBehaviorGeneSets$GeneSymbol_Rat=="Nov"]<-"Ccn3"

write.csv(InternalizingBehaviorGeneSets, "InternalizingBehaviorGeneSets_DateGenesFixed.csv")


#How about MsigDb:

str(msigdb.v7.3.symbols)
#'data.frame':	49589 obs. of  142 variables:
#'That's weird - that data.frame seems to be truncated at 142 genes per category.
#I just opened it up in Excel and there are definitely SEPTIN genes - so hypothetically the gene symbol annotation in these files has the date problem fixed.

#I'm pretty sure my old home-brewed HC specific GMT has date problems. Let's look:
#Looks like I may have already gone in and fixed it in Excel. Excellent.

str(CombinedHCspecific)
sum("CDS1"%in%CombinedHCspecific)#Sanity check - apparently this code doesn't work unless the column is specified, which is awkward.
sum("CDS1"%in%as.matrix(CombinedHCspecific[,c(3:ncol(CombinedHCspecific))]))
#[1] 1
#That code works. :)

TempMatrix<-as.matrix(CombinedHCspecific[,c(3:ncol(CombinedHCspecific))])

TempMatrix[TempMatrix%in%DateGeneDecoder_Human$OldSymbol|TempMatrix%in%DateGeneDecoder_Human$ExcelDate]
#[1] "NOV"   "NOV"   "SEPT9"

TempMatrix[TempMatrix=="NOV"]<-"CCN3"
TempMatrix[TempMatrix=="SEPT9"]<-"SEPTIN9"

CombinedHCspecific[,c(3:ncol(CombinedHCspecific))]<-TempMatrix
str(CombinedHCspecific)

write.table(CombinedHCspecific, "TableS1_CombinedHCspecific_DateGenesFixed.gmt.txt", sep="\t", col.names = FALSE)


#how about some of the other gmts?

c2.all.v7.3.symbols
TempMatrix<-as.matrix(c2.all.v7.3.symbols[,c(3:ncol(c2.all.v7.3.symbols))])
TempMatrix[TempMatrix%in%DateGeneDecoder_Human$OldSymbol|TempMatrix%in%DateGeneDecoder_Human$ExcelDate]
#character(0)

#Out of laziness, I just reran the same code for all of the others and they all look fine - up to date annotation.
TempMatrix<-as.matrix(c3.all.v7.3.symbols[,c(3:ncol(c3.all.v7.3.symbols))])
TempMatrix<-as.matrix(c5.all.v7.3.symbols[,c(3:ncol(c5.all.v7.3.symbols))])
TempMatrix<-as.matrix(c7.all.v7.3.symbols[,c(3:ncol(c7.all.v7.3.symbols))])
TempMatrix<-as.matrix(c8.all.v7.3.symbols[,c(3:ncol(c8.all.v7.3.symbols))])
TempMatrix<-as.matrix(h.all.v7.3.symbols[,c(3:ncol(h.all.v7.3.symbols))])
#character(0) for all after running the code above


#Zeisel Pyramidal neurons:

str(Zeisel_CA1PyramidalIndex)
Zeisel_CA1PyramidalIndex[Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase%in%DateGeneDecoder_Human$OldSymbol|Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase%in%DateGeneDecoder$ExcelDate,]
# Symbol_Mouse_AsUpperCase                       Dataset
# 223                   MARCH3 Zeisel_CA1PyramidalNeurons_HC
# 327                    SEPT9 Zeisel_CA1PyramidalNeurons_HC

Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase[Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase=="MARCH3"]<-"MARCHF3"
Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase[Zeisel_CA1PyramidalIndex$Symbol_Mouse_AsUpperCase=="SEPT9"]<-"SEPTIN9"


str(Zeisel_CA1PyramidalIndex)
setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(Zeisel_CA1PyramidalIndex, "Zeisel_CA1PyramidalIndex_FixedDateGenes.csv")

str(DropViz_HC_CellTypeClusterMarkers)

DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene%in%DateGeneDecoder$OldSymbol|DropViz_HC_CellTypeClusterMarkers$gene%in%DateGeneDecoder$ExcelDate]
#[1] "Sept10"  "Sept10"  "March10" "Sept4"   "Sept11"  "Nov"     "Sept4"   "March8"  "Sept7"  

DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="Sept10"]<-"Septin10"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="Sept4"]<-"Septin4"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="Sept11"]<-"Septin11"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="Sept7"]<-"Septin7"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="March10"]<-"Marchf10"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="March8"]<-"Marchf8"
DropViz_HC_CellTypeClusterMarkers$gene[DropViz_HC_CellTypeClusterMarkers$gene=="Nov"]<-"Ccn3"

DropViz_HC_CellTypeClusterMarkers_Concise$gene[DropViz_HC_CellTypeClusterMarkers_Concise$gene%in%DateGeneDecoder$OldSymbol|DropViz_HC_CellTypeClusterMarkers_Concise$gene%in%DateGeneDecoder$ExcelDate]
#[1] "Sept4"
DropViz_HC_CellTypeClusterMarkers_Concise$gene[DropViz_HC_CellTypeClusterMarkers_Concise$gene=="Sept4"]<-"Septin4"

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")

write.csv(DropViz_HC_CellTypeClusterMarkers, "DropViz_HC_CellTypeClusterMarkers_FixedDateGenes.csv")
write.csv(DropViz_HC_CellTypeClusterMarkers_Concise, "DropViz_HC_CellTypeClusterMarkers_Concise_FixedDateGenes.csv")

str(DropViz_STR_CellTypeClusterMarkers)

DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene%in%DateGeneDecoder$OldSymbol|DropViz_STR_CellTypeClusterMarkers$gene%in%DateGeneDecoder$ExcelDate]
#[1] "Sept10"  "March10" "March1"  "Sept4"   "Sept10"  "Sept4"   "March8"  "Sept8"   "Sept7"   "Sept2"  

DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="Sept10"]<-"Septin10"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="Sept4"]<-"Septin4"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="Sept7"]<-"Septin7"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="Sept8"]<-"Septin8"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="Sept2"]<-"Septin2"

DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="March10"]<-"Marchf10"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="March1"]<-"Marchf1"
DropViz_STR_CellTypeClusterMarkers$gene[DropViz_STR_CellTypeClusterMarkers$gene=="March8"]<-"Marchf8"


DropViz_STR_CellTypeClusterMarkers_Concise$gene[DropViz_STR_CellTypeClusterMarkers_Concise$gene%in%DateGeneDecoder$OldSymbol|DropViz_STR_CellTypeClusterMarkers_Concise$gene%in%DateGeneDecoder$ExcelDate]
#[1] "Sept4"
DropViz_STR_CellTypeClusterMarkers_Concise$gene[DropViz_STR_CellTypeClusterMarkers_Concise$gene=="Sept4"]<-"Septin4"

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")

write.csv(DropViz_STR_CellTypeClusterMarkers, "DropViz_STR_CellTypeClusterMarkers_FixedDateGenes.csv")
write.csv(DropViz_STR_CellTypeClusterMarkers_Concise, "DropViz_STR_CellTypeClusterMarkers_Concise_FixedDateGenes.csv")

