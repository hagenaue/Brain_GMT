setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_toMakeRat")

c8_WhichAreRelevant<-read.delim("c8_WhichAreRelevant.txt", sep="\t", header=FALSE, stringsAsFactors = FALSE)
str(c8_WhichAreRelevant)
#'data.frame':	673 obs. of  2 variables:
table(c8_WhichAreRelevant$V2)
# 0   1 
# 462 211

str(c8.all.v7.3.symbols)
# chr [1:673, 1:1772] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:673] "V1" "V2" "V3" "V4" ...
# ..$ : NULL
str(c8.all.v7.3.symbols_RatOrtholog)
#chr [1:673, 1:1872] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" ...
str(c8.all.v7.3.symbols_MouseOrtholog)
#chr [1:673, 1:1872] "BUSSLINGER_ESOPHAGEAL_QUIESCENT_BASAL_CELLS" "BUSSLINGER_ESOPHAGEAL_PROLIFERATING_BASAL_CELLS" ...

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")

c8.all.v7.3.symbols_BrainRelevant<-c8.all.v7.3.symbols[c8_WhichAreRelevant$V2==1,]
str(c8.all.v7.3.symbols_BrainRelevant)
# chr [1:211, 1:1772] "FAN_EMBRYONIC_CTX_BIG_GROUPS_CAJAL_RETZIUS" "FAN_EMBRYONIC_CTX_BIG_GROUPS_BRAIN_ENDOTHELIAL" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:211] "V39" "V40" "V41" "V42" ...
# ..$ : NULL

c8.all.v7.3.symbols_MouseOrtholog_BrainRelevant<-c8.all.v7.3.symbols_MouseOrtholog[c8_WhichAreRelevant$V2==1,]
str(c8.all.v7.3.symbols_MouseOrtholog_BrainRelevant)

c8.all.v7.3.symbols_RatOrtholog_BrainRelevant<-c8.all.v7.3.symbols_RatOrtholog[c8_WhichAreRelevant$V2==1,]
str(c8.all.v7.3.symbols_RatOrtholog_BrainRelevant)

write.table(c8.all.v7.3.symbols_BrainRelevant, "c8.all.v7.3.symbols_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(c8.all.v7.3.symbols_MouseOrtholog_BrainRelevant, "c8.all.v7.3.symbols_MouseOrtholog_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(c8.all.v7.3.symbols_RatOrtholog_BrainRelevant, "c8.all.v7.3.symbols_RatOrtholog_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)


setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_toMakeRat")

c2_WhichAreRelevant<-read.csv("c2_WhichAreRelevant_NonCuratedBrain.csv", header=FALSE, stringsAsFactors = FALSE)
str(c2_WhichAreRelevant)
# 'data.frame':	6255 obs. of  2 variables:
#   $ V1: chr  "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_DN" "BLANCO_MELO_MERS_COV_INFECTION_MCR5_CELLS_UP" ...
# $ V2: int  0 0 0 0 0 0 0 0 0 0 ...
table(c2_WhichAreRelevant$V2)
# 0    1 
# 6097  158 

str(c2.all.v7.3.symbols)
# chr [1:6255, 1:1943] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" ...
# - attr(*, "dimnames")=List of 2
str(c2.all.v7.3.symbols_MouseOrtholog)
# chr [1:6255, 1:2043] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" ...
str(c2.all.v7.3.symbols_RatOrtholog)
#chr [1:6255, 1:2043] "BENITEZ_GBM_PROTEASOME_INHIBITION_RESPONSE" "BLANCO_MELO_SARS_COV_1_INFECTION_MCR5_CELLS_UP" ...


c2.all.v7.3.symbols_BrainRelevant<-c2.all.v7.3.symbols[c2_WhichAreRelevant$V2==1,]
str(c2.all.v7.3.symbols_BrainRelevant)
# chr [1:158, 1:1943] "RHEIN_ALL_GLUCOCORTICOID_THERAPY_UP" "RHEIN_ALL_GLUCOCORTICOID_THERAPY_DN" "CHEBOTAEV_GR_TARGETS_UP" "CHEBOTAEV_GR_TARGETS_DN" ...
# - attr(*, "dimnames")=List of 2
# ..$ : chr [1:158] "V205" "V206" "V329" "V330" ...
# ..$ : NULL

c2.all.v7.3.symbols_MouseOrtholog_BrainRelevant<-c2.all.v7.3.symbols_MouseOrtholog[c2_WhichAreRelevant$V2==1,]
str(c2.all.v7.3.symbols_MouseOrtholog_BrainRelevant)

c2.all.v7.3.symbols_RatOrtholog_BrainRelevant<-c2.all.v7.3.symbols_RatOrtholog[c2_WhichAreRelevant$V2==1,]
str(c2.all.v7.3.symbols_RatOrtholog_BrainRelevant)

write.table(c2.all.v7.3.symbols_BrainRelevant, "c2.all.v7.3.symbols_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(c2.all.v7.3.symbols_MouseOrtholog_BrainRelevant, "c2.all.v7.3.symbols_MouseOrtholog_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)

write.table(c2.all.v7.3.symbols_RatOrtholog_BrainRelevant, "c2.all.v7.3.symbols_RatOrtholog_BrainRelevant.gmt.txt", na="", quote=FALSE, sep="\t", col.names = FALSE, row.names = FALSE)
