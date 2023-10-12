
#Test run before going any further with things (just to make sure I didn't break anything essential while messing around with the .gmt files):

library(fgsea)


#First, for comparison, the old gmt:
setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_toMakeRat")

OldGMT_ForRats<-gmtPathways("c5.all.v7.3.symbols.gmt.txt")
str(OldGMT_ForRats)
# List of 14996
# $ GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE                                                                                                                                                       : chr [1:21] "AKT3" "PPARGC1A" "POLG2" "PARP1" ...
# $ GOBP_REPRODUCTION                                                                                                                                                                           : chr [1:1442] "ADA" "GNPDA1" "ZGLP1" "SYCE1L" ...

names(OldGMT_ForRats)
# [2] "GOBP_REPRODUCTION"                                                                                                                                   
# [3] "GOBP_SINGLE_STRAND_BREAK_REPAIR"    
OldGMT_ForRats[[1]]
# [1] "AKT3"     "PPARGC1A" "POLG2"    "PARP1"    "DNA2"     "TYMP"     "PRIMPOL"  "STOX1"    "SLC25A4"  "LIG3"     "MEF2A"    "MPV17"    "OPA1"     "SLC25A36" "TOP3A"   
# [16] "TP53"     "PIF1"     "SESN2"    "SLC25A33" "MGME1"    "LONP1"  

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
GMT_ForRats<-gmtPathways("c5.all.v7.3.symbols_RatOrtholog.gmt.txt")
str(GMT_ForRats)
# List of 14996
# $ GOBP_MITOCHONDRIAL_GENOME_MAINTENANCE                                                                                                                                                       : chr [1:2081] "Akt3" "Ppargc1a" "Polg2" "Parp1" ...
# $ GOBP_REPRODUCTION                                                                                                                                                                           : chr [1:2081] "Ada" "Gnpda1" "Zglp1" "Syce1l" ...
# $ GOBP_SINGLE_STRAND_BREAK_REPAIR                                                                                                                                                             : chr [1:2081] "Ercc8" "Parp1" "Aplf" "Ercc6" ...
# $ GOBP_REGULATION_OF_DNA_RECOMBINATION                                                                                                                                                        : chr [1:2081] "Parp3" "Actr2" "Rad50" "Alyref" ...
names(GMT_ForRats)
GMT_ForRats[[1]]
#That definitely is not reading in properly. I tried opening it up in textedit and it doesn't look right either. The delimiter must be incorrect.
#Although my code should have outputted it as tab-delimited text (which is the correct format).
#Ah - I needed quote=FALSE in the output code.  Now it looks right.
#before going back and re-outputting everything though, let's see if the version with quote=FALSE now works.

#Extracting out the results for each comparison:

NACC_EESD_Combined<-read.csv("NACC_EESD_Combined_DateGenesFixed.csv", header=TRUE, stringsAsFactors = FALSE)

colnames(NACC_EESD_Combined)

NAcc_EE_Betas_forGSEA<-NACC_EESD_Combined$Coef.EnrichmentEE_MainEffectsModel
str(NAcc_EE_Betas_forGSEA)
#names(NAcc_EE_Betas_forGSEA)<-toupper(NACC_EESD_Combined$gene_symbol)
names(NAcc_EE_Betas_forGSEA)<-NACC_EESD_Combined$gene_symbol
sum(duplicated(names(NAcc_EE_Betas_forGSEA)))
#[1] 908
sum(is.na(names(NAcc_EE_Betas_forGSEA)))
#[1] 766
length(NAcc_EE_Betas_forGSEA)
#[1] 17765

NAcc_EE_Betas_forGSEA<-NAcc_EE_Betas_forGSEA[is.na(names(NAcc_EE_Betas_forGSEA))==F]
length(NAcc_EE_Betas_forGSEA)
#[1] 16999
sum(is.na(names(NAcc_EE_Betas_forGSEA)))
#[1] 0

NAcc_EE_Betas_forGSEARanked<-NAcc_EE_Betas_forGSEA[order(NAcc_EE_Betas_forGSEA)]
head(NAcc_EE_Betas_forGSEARanked)
# Scn11a AABR07028009.1            Ak7     AC128059.4   LOC103693430        Tmem212 
# -2.236         -2.169         -2.026         -1.862         -1.845         -1.836 

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_BasicC5gmt.csv")
#It's working! Yessss...
#Now I just need to make our brain .gmt, because most of these pathways are completely irrelevant...
