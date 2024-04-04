setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_toMakeRat")
GMTfiles_ToMakeRat<-list.files()


#Original read-in code - it turned out that this was actually problematic (see notes below):
# c2.all.v7.3.symbols<-read.delim("c2.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c3.all.v7.3.symbols<-read.delim("c3.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c5.all.v7.3.symbols<-read.delim("c5.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c5.go.v7.3.symbols<-read.delim("c5.go.v7.3.symbols.gmt.txt" , sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c7.all.v7.3.symbols<-read.delim("c7.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c7.immunesigdb.v7.3.symbols<-read.delim("c7.immunesigdb.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c8.all.v7.3.symbols<-read.delim("c8.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# c8.JustBrainBloodwOurs.v7.3.symbols<-read.delim("c8.JustBrainBloodwOurs.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# h.all.v7.3.symbols<-read.delim("h.all.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# msigdb.v7.3.symbols<-read.delim("msigdb.v7.3.symbols.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
# CombinedHCspecific<-read.delim("TableS1_CombinedHCspecific.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)

#Alright, it turns out that the original read-in process wasn't working properly - it appeared to occassionally be misinterpreting parts of the GMT file for new line symbols (I think - I never did quite get to the heart of it - but my guess is that there are \n's mixed into the file text somewhere), which was causing there to artificially be more "pathways" (rows) than expected in the file, with the added pathways just being gene names (because they were actually part of the listed genes for the previous pathway).
#This function seemed to work to fix the issue:

gmtPathways_WithLink<-function (gmt.file) 
{
  pathwayLines <- strsplit(readLines(gmt.file), "\\t")
  pathways<-t(as.data.frame(stri_list2matrix(pathwayLines, byrow = FALSE), stringsAsFactors=FALSE))
}

c8.all.v7.3.symbol_Temp<-gmtPathways_WithLink("c8.all.v7.3.symbols.gmt.txt")
str(c8.all.v7.3.symbol_Temp)
#List of 673
# chr [1:673, 1:1772] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:673] "V1" "V2" "V3" "V4" ...
# ..$ : NULL
head(c8.all.v7.3.symbol_Temp)
c8.all.v7.3.symbol_Temp[c(1:10), c(1:10)]
#Got it.
rm(c8.all.v7.3.symbol_Temp)


c2.all.v7.3.symbols<-gmtPathways_WithLink("c2.all.v7.3.symbols.gmt.txt")
str(c2.all.v7.3.symbols)
# chr [1:6255, 1:1943] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:6255] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c3.all.v7.3.symbols<-gmtPathways_WithLink("c3.all.v7.3.symbols.gmt.txt")
str(c3.all.v7.3.symbols)
# chr [1:3731, 1:2002] "MIR153_5P" "MIR8485" "MIR3662" "MIR607" "MIR616_5P" "MIR371B_5P" "MIR373_5P" "MIR6867_5P" "MIR12136" "MIR548AJ_3P_MIR548X_3P" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:3731] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c5.all.v7.3.symbols<-gmtPathways_WithLink("c5.all.v7.3.symbols.gmt.txt")
str(c5.all.v7.3.symbols)
# chr [1:14996, 1:1984] "GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE" "GOBP_REPRODUCTION" "GOBP_SINGLE_STRAND_BREAK_REPAIR" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:14996] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c5.go.v7.3.symbols<-gmtPathways_WithLink("c5.go.v7.3.symbols.gmt.txt")
str(c5.go.v7.3.symbols)
# chr [1:10183, 1:1984] "GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE" "GOBP_REPRODUCTION" "GOBP_SINGLE_STRAND_BREAK_REPAIR" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:10183] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c7.all.v7.3.symbols<-gmtPathways_WithLink("c7.all.v7.3.symbols.gmt.txt")
str(c7.all.v7.3.symbols)
# chr [1:5219, 1:1994] "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_DN" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_UP" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:5219] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c7.immunesigdb.v7.3.symbols<-gmtPathways_WithLink("c7.immunesigdb.v7.3.symbols.gmt.txt")
str(c7.immunesigdb.v7.3.symbols)
# chr [1:4872, 1:202] "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_UP" "KAECH_NAIVE_VS_DAY8_EFF_CD8_TCELL_DN" "KAECH_NAIVE_VS_DAY15_EFF_CD8_TCELL_UP" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:4872] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c8.all.v7.3.symbols<-gmtPathways_WithLink("c8.all.v7.3.symbols.gmt.txt")
str(c8.all.v7.3.symbols)
# chr [1:673, 1:1772] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:673] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

c8.JustBrainBloodwOurs.v7.3.symbols<-gmtPathways_WithLink("c8.JustBrainBloodwOurs.v7.3.symbols.gmt.txt")
str(c8.JustBrainBloodwOurs.v7.3.symbols)
# chr [1:242, 1:2822] "FAN_EMBRYONIC_CTX_BIG_GROUPS_CAJAL_RETZIUS" "FAN_EMBRYONIC_CTX_BIG_GROUPS_BRAIN_ENDOTHELIAL" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:242] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

h.all.v7.3.symbols<-gmtPathways_WithLink("h.all.v7.3.symbols.gmt.txt")
str(h.all.v7.3.symbols)
# chr [1:50, 1:202] "HALLMARK_TNFA_SIGNALING_VIA_NFKB" "HALLMARK_HYPOXIA" "HALLMARK_CHOLESTEROL_HOMEOSTASIS" "HALLMARK_MITOTIC_SPINDLE" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:50] "V1" "V2" "V3" "V4" ...
# ..$ : NULL

#I didn't end up re-doing the read-in process for this file because it didn't turn out to have the same problem (artificial line breaks) that the other MsigDb generated files had:
# CombinedHCspecific<-gmtPathways_WithLink("TableS1_CombinedHCspecific.gmt.txt")
# str(CombinedHCspecific)
#Original read in:
CombinedHCspecific<-read.delim("TableS1_CombinedHCspecific.gmt.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)


