#While I'm at it, let's add in the gene sets for the top genes associated with chronic stress, internalizing behavior, and psychiatric illness:

#I already compiled some of these in another analysis:

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/08_ComparisonWNestler")

HC_NACC_StressVsCtrl_Mice<-read.csv("HC_NACC_StressVsCtrl_Mice_Joined.csv", header=TRUE, stringsAsFactors = FALSE)
str(HC_NACC_StressVsCtrl_Mice)
#This document containts the genes identified as affected by chronic stress in Bagot et al. 2016 (NACC and HC), Bagot et al. 2017 (NACC and HC), and Pena et al. 2019 (just NACC)

#Hmmm... honestly, it may be easier to build a .gmt using the original suppl tables. Let me try that instead.
#Also might be useful to divide up the genes into upregulated and down-regulated effects.
#And maybe make the p-value cut-offs more stringent. P<0.05 nominal is pretty loosey goosey - probably contains a lot of noise.

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/StressStudies")

list.files()

Bagot_2016_SuscVsCTRL_NACC<-read.csv("Bagot_2016_SuscVsCTRL_NACC.csv", header=TRUE, stringsAsFactors = FALSE)
Bagot_2017_SuscVsCTRL_NACC<-read.csv("Bagot_2017_SuscVsCTRL_NACC.csv", header=TRUE, stringsAsFactors = FALSE)
Bagot_2016_SuscVsCTRL_HC<-read.csv("Bagot_2016_SuscVsCTRL_vHC.csv", header=TRUE, stringsAsFactors = FALSE)
Bagot_2017_SuscVsCTRL_HC<-read.csv("Bagot_2017_SuscVsCTRL_HC.csv", header=TRUE, stringsAsFactors = FALSE)
Pena_2019_SuscVsCTRL_NACC<-read.csv("Pena_2019_ELSSDvsCTRL_NACC.csv", header=TRUE, stringsAsFactors = FALSE)
Gray_2014_S2_CRS_HC<-read.csv("Gray_2014_S2_CRS_HC.csv", header=TRUE, stringsAsFactors = FALSE)
Gray_2014_S3_CRSwFST_HC<-read.csv("Gray_2014_S3_CRSwFST_HC.csv", header=TRUE, stringsAsFactors = FALSE)
Gray_2014_Suppl_FSTvsCtrl_HC<-read.csv("Gray_2014_Suppl_FSTvsCtrl_HC.csv", header=TRUE, stringsAsFactors = FALSE)
Gray_2014_S7_CortVsVeh_HC<-read.csv("Gray_2014_S7_CortVsVeh_HC.csv", header=TRUE, stringsAsFactors = FALSE)
Gray_2014_Suppl6_StressCortANOVA_HC<-read.csv("Gray_2014_Suppl6_StressCortANOVA_HC.csv", header=TRUE, stringsAsFactors = FALSE)

StressGeneSets<-data.frame(GeneSymbol_Mouse=character(), DatasetName=character(), stringsAsFactors = FALSE)
str(StressGeneSets)

str(Bagot_2016_SuscVsCTRL_NACC)
#'data.frame':	54 obs. of  12 variables:
sum(Bagot_2016_SuscVsCTRL_NACC$p_value<0.005)
#[1] 18
#Ouch.
sum(Bagot_2016_SuscVsCTRL_NACC$q_value<0.10)
#[1] 6
str(Bagot_2016_SuscVsCTRL_HC)
#'data.frame':	100 obs. of  12 variables:
sum(Bagot_2016_SuscVsCTRL_HC$p_value<0.005)
#[1] 34
sum(Bagot_2016_SuscVsCTRL_HC$q_value<0.10)
#[1] 14
#Ouch. So should I split it into up vs. down regulation or make the p-value more strict?  I don't think I can do both.

#Oh - also, to make proper gene sents, we need to remove duplicate symbols:

Bagot_2016_SuscVsCTRL_NACC_Genes<-Bagot_2016_SuscVsCTRL_NACC$gene[Bagot_2016_SuscVsCTRL_NACC$p_value<0.005]
sum(duplicated(Bagot_2016_SuscVsCTRL_NACC_Genes))
#[1] 0

Bagot_2016_SuscVsCTRL_HC_Genes<-Bagot_2016_SuscVsCTRL_HC$gene[Bagot_2016_SuscVsCTRL_HC$p_value<0.005]
sum(duplicated(Bagot_2016_SuscVsCTRL_HC_Genes))
#[1] 0

StressGeneSets<-rbind(StressGeneSets, data.frame(GeneSymbol_Mouse=Bagot_2016_SuscVsCTRL_NACC_Genes, DatasetName=rep("Bagot_2016_StressSusceptibleVsCTRL_NACC", length(Bagot_2016_SuscVsCTRL_NACC_Genes)), stringsAsFactors=FALSE), data.frame(GeneSymbol_Mouse=Bagot_2016_SuscVsCTRL_HC_Genes, DatasetName=rep("Bagot_2016_StressSusceptibleVsCTRL_HC",length(Bagot_2016_SuscVsCTRL_HC_Genes)), stringsAsFactors=FALSE))

str(StressGeneSets)


str(Bagot_2017_SuscVsCTRL_NACC)
#'data.frame':	314 obs. of  10 variables:
sum(Bagot_2017_SuscVsCTRL_NACC$P.Value<0.005)
#[1] 20
#Ouch
sum(Bagot_2017_SuscVsCTRL_NACC$adj.P.Val<0.10)
#[1] 0
str(Bagot_2017_SuscVsCTRL_HC)
#'data.frame':	164 obs. of  10 variables:
sum(Bagot_2017_SuscVsCTRL_HC$P.Value<0.005)
#[1] 16
sum(Bagot_2017_SuscVsCTRL_HC$adj.P.Val<0.10)
#[1] 0

Bagot_2017_SuscVsCTRL_NACC_Genes<-Bagot_2017_SuscVsCTRL_NACC$GeneID[Bagot_2017_SuscVsCTRL_NACC$P.Value<0.005]
sum(duplicated(Bagot_2017_SuscVsCTRL_NACC_Genes))
#[1] 0

Bagot_2017_SuscVsCTRL_HC_Genes<-Bagot_2017_SuscVsCTRL_HC$GeneID[Bagot_2017_SuscVsCTRL_HC$P.Value<0.005]
sum(duplicated(Bagot_2017_SuscVsCTRL_HC_Genes))
#[1] 0

StressGeneSets<-rbind(StressGeneSets, data.frame(GeneSymbol_Mouse=Bagot_2017_SuscVsCTRL_NACC_Genes, DatasetName=rep("Bagot_2017_StressSusceptibleVsCTRL_NACC", length(Bagot_2017_SuscVsCTRL_NACC_Genes)), stringsAsFactors=FALSE), data.frame(GeneSymbol_Mouse=Bagot_2017_SuscVsCTRL_HC_Genes, DatasetName=rep("Bagot_2017_StressSusceptibleVsCTRL_HC",length(Bagot_2017_SuscVsCTRL_HC_Genes)), stringsAsFactors=FALSE))

str(StressGeneSets)


str(Pena_2019_SuscVsCTRL_NACC)
#'data.frame':	75 obs. of  23 variables:
#It may be easiest just to grab all of these (they represent three stress conditions and two sexes)
sum(Pena_2019_SuscVsCTRL_NACC$pval_2Stresses_vs_ELS2Ctl<0.005)
#[1] 10
sum(Pena_2019_SuscVsCTRL_NACC$pval_2Stresses_vs_StdCtl<0.005)
#[1] 19
sum(Pena_2019_SuscVsCTRL_NACC$pval_StdAdult_vs_StdCtl<0.005)
#[1] 15

Pena_2019_SuscVsCTRL_NACC_Genes<-Pena_2019_SuscVsCTRL_NACC$gene_name[(Pena_2019_SuscVsCTRL_NACC$pval_2Stresses_vs_ELS2Ctl<0.005)|(Pena_2019_SuscVsCTRL_NACC$pval_2Stresses_vs_StdCtl<0.005)|(Pena_2019_SuscVsCTRL_NACC$pval_StdAdult_vs_StdCtl<0.005)]
sum(duplicated(Pena_2019_SuscVsCTRL_NACC_Genes))
#[1] 5

Pena_2019_SuscVsCTRL_NACC_Genes<-unique(Pena_2019_SuscVsCTRL_NACC_Genes)

StressGeneSets<-rbind(StressGeneSets, data.frame(GeneSymbol_Mouse=Pena_2019_SuscVsCTRL_NACC_Genes, DatasetName=rep("Pena_2019_StressVsCTRL_NACC", length(Pena_2019_SuscVsCTRL_NACC_Genes)), stringsAsFactors=FALSE))


str(Gray_2014_S2_CRS_HC)
#'data.frame':	791 obs. of  12 variables:
sum(Gray_2014_S2_CRS_HC$p_CRS<0.005)
#[1] 84
#big difference, but not terrible.
sum(Gray_2014_S2_CRS_HC$p_CRS<0.005 & Gray_2014_S2_CRS_HC$Regulation_CRS=="up")
#[1] 34
sum(Gray_2014_S2_CRS_HC$p_CRS<0.005 & Gray_2014_S2_CRS_HC$Regulation_CRS=="down")
#[1] 50

Gray_2014_S2_CRS_HC_Genes_Up<-Gray_2014_S2_CRS_HC$Gene.Symbol[which(Gray_2014_S2_CRS_HC$p_CRS<0.005 & Gray_2014_S2_CRS_HC$Regulation_CRS=="up")]
Gray_2014_S2_CRS_HC_Genes_Down<-Gray_2014_S2_CRS_HC$Gene.Symbol[which(Gray_2014_S2_CRS_HC$p_CRS<0.005 & Gray_2014_S2_CRS_HC$Regulation_CRS=="down")]

Gray_2014_S2_CRS_HC_Genes_Up<-unique(Gray_2014_S2_CRS_HC_Genes_Up)
Gray_2014_S2_CRS_HC_Genes_Down<-unique(Gray_2014_S2_CRS_HC_Genes_Down)

str(Gray_2014_S3_CRSwFST_HC)
#'data.frame':	4448 obs. of  13 variables
sum(Gray_2014_S3_CRSwFST_HC$p._CRS_FST<0.005)
#[1] 1223 
#!!!
#Maybe trim it further so that it is more likely to make GSEA cut-offs:
sum(Gray_2014_S3_CRSwFST_HC$p._CRS_FST<0.0005)
#[1] 280

Gray_2014_S3_CRSwFST_HC_Genes_Up<-Gray_2014_S3_CRSwFST_HC$Symbol[which(Gray_2014_S3_CRSwFST_HC$p._CRS_FST<0.005 & Gray_2014_S3_CRSwFST_HC$Regulation_CRS_FST=="up")]
Gray_2014_S3_CRSwFST_HC_Genes_Down<-Gray_2014_S3_CRSwFST_HC$Symbol[which(Gray_2014_S3_CRSwFST_HC$p._CRS_FST<0.005 & Gray_2014_S3_CRSwFST_HC$Regulation_CRS_FST=="down")]

Gray_2014_S3_CRSwFST_HC_Genes_Up<-unique(Gray_2014_S3_CRSwFST_HC_Genes_Up)
Gray_2014_S3_CRSwFST_HC_Genes_Down<-unique(Gray_2014_S3_CRSwFST_HC_Genes_Down)

str(Gray_2014_Suppl_FSTvsCtrl_HC)
#'data.frame':	1369 obs. of  25 variables:
sum(Gray_2014_Suppl_FSTvsCtrl_HC$p<0.005)
#[1] 193
sum(Gray_2014_Suppl_FSTvsCtrl_HC$p<0.005 & Gray_2014_Suppl_FSTvsCtrl_HC$Regulation=="up")
#[1] 94

Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Up<-Gray_2014_Suppl_FSTvsCtrl_HC$Gene.Symbol[which(Gray_2014_Suppl_FSTvsCtrl_HC$p<0.005 & Gray_2014_Suppl_FSTvsCtrl_HC$Regulation=="up")]
Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Down<-Gray_2014_Suppl_FSTvsCtrl_HC$Gene.Symbol[which(Gray_2014_Suppl_FSTvsCtrl_HC$p<0.005 & Gray_2014_Suppl_FSTvsCtrl_HC$Regulation=="down")]  

Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Up<-unique(Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Up)
Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Down<-unique(Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Down)

str(Gray_2014_S7_CortVsVeh_HC)
#'data.frame':	1157 obs. of  13 variables:
sum(Gray_2014_S7_CortVsVeh_HC$p_AcuteCORT<0.005)
#[1] 102
sum(Gray_2014_S7_CortVsVeh_HC$p_AcuteCORT<0.005 & Gray_2014_S7_CortVsVeh_HC$Regulation_AcuteCORT=="up")
#[1] 57

Gray_2014_S7_CortVsVeh_HC_Genes_Up<-Gray_2014_S7_CortVsVeh_HC$Gene.Symbol[which(Gray_2014_S7_CortVsVeh_HC$p_AcuteCORT<0.005 & Gray_2014_S7_CortVsVeh_HC$Regulation_AcuteCORT=="up")]
Gray_2014_S7_CortVsVeh_HC_Genes_Down<-Gray_2014_S7_CortVsVeh_HC$Gene.Symbol[which(Gray_2014_S7_CortVsVeh_HC$p_AcuteCORT<0.005 & Gray_2014_S7_CortVsVeh_HC$Regulation_AcuteCORT=="down")]

Gray_2014_S7_CortVsVeh_HC_Genes_Up<-unique(Gray_2014_S7_CortVsVeh_HC_Genes_Up)
Gray_2014_S7_CortVsVeh_HC_Genes_Down<-unique(Gray_2014_S7_CortVsVeh_HC_Genes_Down)

str(Gray_2014_Suppl6_StressCortANOVA_HC)
#'data.frame':	8269 obs. of  10 variables:
sum(Gray_2014_Suppl6_StressCortANOVA_HC$p_fromANOVA<0.005)
#[1] 3841
sum(Gray_2014_Suppl6_StressCortANOVA_HC$p_fromANOVA<0.0005)
#[1] 1799
sum(Gray_2014_Suppl6_StressCortANOVA_HC$p_fromANOVA<0.00005)
#[1] 848
sum(Gray_2014_Suppl6_StressCortANOVA_HC$p_fromANOVA<0.000005)
#[1] 400
#I would need to make the cut off for this quite strict to have it make it into GSEA analyses, especially since it can't be split by directionality.

Gray_2014_Suppl6_StressCortANOVA_HC_Genes<-Gray_2014_Suppl6_StressCortANOVA_HC$Symbol[which(Gray_2014_Suppl6_StressCortANOVA_HC$p_fromANOVA<0.00005)]

Gray_2014_Suppl6_StressCortANOVA_HC_Genes<-unique(Gray_2014_Suppl6_StressCortANOVA_HC_Genes)

StressGeneSets<-rbind(StressGeneSets, 
                      data.frame(GeneSymbol_Mouse=Gray_2014_S2_CRS_HC_Genes_Up, DatasetName=rep("Gray_2014_ChronicRestraintStress_Upregulated_HC", length(Gray_2014_S2_CRS_HC_Genes_Up)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_S2_CRS_HC_Genes_Down, DatasetName=rep("Gray_2014_ChronicRestraintStress_Downregulated_HC", length(Gray_2014_S2_CRS_HC_Genes_Down)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_S3_CRSwFST_HC_Genes_Up, DatasetName=rep("Gray_2014_ChronicRestraintAndForcedSwimStress_Upregulated_HC", length(Gray_2014_S3_CRSwFST_HC_Genes_Up)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_S3_CRSwFST_HC_Genes_Down, DatasetName=rep("Gray_2014_ChronicRestraintAndForcedSwimStress_Downregulated_HC", length(Gray_2014_S3_CRSwFST_HC_Genes_Down)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Up, DatasetName=rep("Gray_2014_ForcedSwimStress_Upregulated_HC", length(Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Up)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Down, DatasetName=rep("Gray_2014_ForcedSwimStress_Downregulated_HC", length(Gray_2014_Suppl_FSTvsCtrl_HC_Genes_Down)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_S7_CortVsVeh_HC_Genes_Up, DatasetName=rep("Gray_2014_AcuteCorticosterone_Upregulated_HC", length(Gray_2014_S7_CortVsVeh_HC_Genes_Up)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_S7_CortVsVeh_HC_Genes_Down, DatasetName=rep("Gray_2014_AcuteCorticosterone_Downregulated_HC", length(Gray_2014_S7_CortVsVeh_HC_Genes_Down)), stringsAsFactors=FALSE),
                      data.frame(GeneSymbol_Mouse=Gray_2014_Suppl6_StressCortANOVA_HC_Genes, DatasetName=rep("Gray_2014_AllStressConditions_HC", length(Gray_2014_Suppl6_StressCortANOVA_HC_Genes)), stringsAsFactors=FALSE)
)

write.csv(StressGeneSets, "StressGeneSets.csv")

#Double-checking whether any NAs snuck in there:
sum(is.na(StressGeneSets$GeneSymbol_Mouse)==TRUE)
#[1] 0
