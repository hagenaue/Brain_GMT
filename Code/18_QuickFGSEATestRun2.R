
#Let's see if it worked:

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_Rat")
GMT_ForRats<-gmtPathways("BrainCellTypes_V1_Rat_GMT.gmt.txt")
str(GMT_ForRats)
# List of 289
# $ Astrocyte_All_Cahoy_JNeuro_2008                                           : chr [1:1213] "Gfap" "Aqp4" "Pla2g7" "Slc39a12" ...
# $ Astrocyte_All_Darmanis_PNAS_2015                                          : chr [1:1213] "Fgfr3" "Aqp4" "Gja1" "Agt" ...
# $ Astrocyte_All_Doyle_Cell_2008                                             : chr [1:1213] "Adora2b" "Cyp4f4" "Fzd2" "Nr2e1" ...
#Looks good.

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_BrainCellTypesGMT.csv")
#Works beautifully. :)


#Another test:
#Let's see if it worked:

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_Rat")
GMT_ForRats<-gmtPathways("BrainFunction_CustomGeneSets_V1_Rat_GMT.gmt.txt")
str(GMT_ForRats)
# List of 260
# $ Gandal_2018_AlcoholAbuseDisorder_Downregulated_Cortex         : chr [1:2082] "Cyp51" "Slc25a5" "Pik3c2a" "Matr3" ...
# $ Gandal_2018_AlcoholAbuseDisorder_Upregulated_Cortex           : chr [1:2082] "Upf1" "Gas7" "Camk1g" "Med24" ...
# $ Gandal_2018_AutismSpectrumDisorder_Downregulated_Cortex       : chr [1:2082] "Mad1l1" "Ica1" "Ndufab1" "Pdk2" ...

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_BrainFunctionGMT.csv")
#Works beautifully. :)

#Since these two gene sets are dinky, I also tried combining them:
setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/GMTs_Rat")
GMT_ForRats<-gmtPathways("BrainCellTypesAndFunction_CustomGeneSets_V1_Rat_GMT.gmt.txt")
str(GMT_ForRats)
# List of 549
# $ Astrocyte_All_Cahoy_JNeuro_2008                                           : chr [1:2082] "Gfap" "Aqp4" "Pla2g7" "Slc39a12" ...
# $ Astrocyte_All_Darmanis_PNAS_2015                                          : chr [1:2082] "Fgfr3" "Aqp4" "Gja1" "Agt" ...
# $ Astrocyte_All_Doyle_Cell_2008                                             : chr [1:2082] "Adora2b" "Cyp4f4" "Fzd2" "Nr2e1" ...

temp1<-fgsea(GMT_ForRats, NAcc_EE_Betas_forGSEARanked, nperm=10000, minSize = 10, maxSize = 1000)
str(temp1)

temp1$leadingEdge<-vapply(temp1$leadingEdge, paste, collapse= ",", character(1L))

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(temp1, "TestRun_NAcc_EE_MainEffectsModel_FGSEAResults_BrainCellsAndFunctionGMT.csv")


