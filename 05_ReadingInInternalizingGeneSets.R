
setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")

HippocampalDE_AcrossDatasets<-read.csv("TableS4_HippocampalDE_AcrossDatasets_wAVEDirection.csv", header=TRUE, stringsAsFactors = FALSE)

Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$bLR.vs..bHR==1)])
Birt_Hagenauer_2020_BredHighRespondersToNovelty_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$bLR.vs..bHR==-1)])

#Not enough DE genes in this dataset to split them by direction of effect:

Garafola_Hen_2014_CongenitallyLearnedHelpless_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$Congenitally.Helpless..cLH..and.Helpless.Resistant..cNLH.==1|HippocampalDE_AcrossDatasets$Congenitally.Helpless..cLH..and.Helpless.Resistant..cNLH.==-1)])

Blaveri_2010_FlindersSensitiveLine_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$Flinder.Sensitive.vs..Flinders.Resistant==1)])
Blaveri_2010_FlindersSensitiveLine_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$Flinder.Sensitive.vs..Flinders.Resistant==-1)])

Wilhelm_2013_FlindersSensitiveLine_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$Flinders.Sensitive.vs..Sprague.Dawley==1)])
Wilhelm_2013_FlindersSensitiveLine_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$Flinders.Sensitive.vs..Sprague.Dawley==-1)])

DiazMoran_2013_NIHHighAnxietyRats_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$NIH.HS.High.Anxiety.vs..NIH.HS.Low.Anxiety==1)])
DiazMoran_2013_NIHHighAnxietyRats_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$NIH.HS.High.Anxiety.vs..NIH.HS.Low.Anxiety==-1)])

Sabariego_2013_RomanLowAvoidanceRats_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$RLA.vs..RHA==1)])
#Sabariego_2013_RomanLowAvoidanceRats_Downregulated_HC<-HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$RLA.vs..RHA==-1)]
#character(0)

Zhang_2005_SyracuseLowAvoidanceRats_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$SLA.vs..SHA==1)])
Zhang_2005_SyracuseLowAvoidanceRats_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$SLA.vs..SHA==-1)])

Meckes_2018_WKYvsF344_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WKY.vs..F344==1)])
Meckes_2018_WKYvsF344_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WKY.vs..F344==-1)])

Raghavan_2017_WistarMoreImmobileRats_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WMI.vs..WLI..females.==1)])
Raghavan_2017_WistarMoreImmobileRats_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WMI.vs..WLI..females.==-1)])

Andrus_2012_WistarMoreImmobileRats_Upregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WMI.vs..WLI..males.==1)])
Andrus_2012_WistarMoreImmobileRats_Downregulated_HC<-unique(HippocampalDE_AcrossDatasets$X[which(HippocampalDE_AcrossDatasets$WMI.vs..WLI..males.==-1)])


InternalizingBehaviorGeneSets<-data.frame(GeneSymbol_Rat=character(), DatasetName=character(), stringsAsFactors = FALSE)
str(InternalizingBehaviorGeneSets)

InternalizingBehaviorGeneSets<-rbind(InternalizingBehaviorGeneSets, 
                                     data.frame(GeneSymbol_Rat=Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC, DatasetName=rep("Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC", length(Birt_Hagenauer_2020_BredLowRespondersToNovelty_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Birt_Hagenauer_2020_BredHighRespondersToNovelty_Upregulated_HC, DatasetName=rep("Birt_Hagenauer_2020_BredHighRespondersToNovelty_Upregulated_HC", length(Birt_Hagenauer_2020_BredHighRespondersToNovelty_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Garafola_Hen_2014_CongenitallyLearnedHelpless_HC, DatasetName=rep("Garafola_Hen_2014_CongenitallyLearnedHelpless_HC", length(Garafola_Hen_2014_CongenitallyLearnedHelpless_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Blaveri_2010_FlindersSensitiveLine_Upregulated_HC, DatasetName=rep("Blaveri_2010_FlindersSensitiveLine_Upregulated_HC", length(Blaveri_2010_FlindersSensitiveLine_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Blaveri_2010_FlindersSensitiveLine_Downregulated_HC, DatasetName=rep("Blaveri_2010_FlindersSensitiveLine_Downregulated_HC", length(Blaveri_2010_FlindersSensitiveLine_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Wilhelm_2013_FlindersSensitiveLine_Upregulated_HC, DatasetName=rep("Wilhelm_2013_FlindersSensitiveLine_Upregulated_HC", length(Wilhelm_2013_FlindersSensitiveLine_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Wilhelm_2013_FlindersSensitiveLine_Downregulated_HC, DatasetName=rep("Wilhelm_2013_FlindersSensitiveLine_Downregulated_HC", length(Wilhelm_2013_FlindersSensitiveLine_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=DiazMoran_2013_NIHHighAnxietyRats_Upregulated_HC, DatasetName=rep("DiazMoran_2013_NIHHighAnxietyRats_Upregulated_HC", length(DiazMoran_2013_NIHHighAnxietyRats_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=DiazMoran_2013_NIHHighAnxietyRats_Downregulated_HC, DatasetName=rep("DiazMoran_2013_NIHHighAnxietyRats_Downregulated_HC", length(DiazMoran_2013_NIHHighAnxietyRats_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Sabariego_2013_RomanLowAvoidanceRats_Upregulated_HC, DatasetName=rep("Sabariego_2013_RomanLowAvoidanceRats_Upregulated_HC", length(Sabariego_2013_RomanLowAvoidanceRats_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Zhang_2005_SyracuseLowAvoidanceRats_Upregulated_HC, DatasetName=rep("Zhang_2005_SyracuseLowAvoidanceRats_Upregulated_HC", length(Zhang_2005_SyracuseLowAvoidanceRats_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Zhang_2005_SyracuseLowAvoidanceRats_Downregulated_HC, DatasetName=rep("Zhang_2005_SyracuseLowAvoidanceRats_Downregulated_HC", length(Zhang_2005_SyracuseLowAvoidanceRats_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Meckes_2018_WKYvsF344_Upregulated_HC, DatasetName=rep("Meckes_2018_WKYvsF344_Upregulated_HC", length(Meckes_2018_WKYvsF344_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Meckes_2018_WKYvsF344_Downregulated_HC, DatasetName=rep("Meckes_2018_WKYvsF344_Downregulated_HC", length(Meckes_2018_WKYvsF344_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Raghavan_2017_WistarMoreImmobileRats_Upregulated_HC, DatasetName=rep("Raghavan_2017_WistarMoreImmobileRats_Upregulated_HC", length(Raghavan_2017_WistarMoreImmobileRats_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Raghavan_2017_WistarMoreImmobileRats_Downregulated_HC, DatasetName=rep("Raghavan_2017_WistarMoreImmobileRats_Downregulated_HC", length(Raghavan_2017_WistarMoreImmobileRats_Downregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Andrus_2012_WistarMoreImmobileRats_Upregulated_HC, DatasetName=rep("Andrus_2012_WistarMoreImmobileRats_Upregulated_HC", length(Andrus_2012_WistarMoreImmobileRats_Upregulated_HC)), stringsAsFactors=FALSE),
                                     data.frame(GeneSymbol_Rat=Andrus_2012_WistarMoreImmobileRats_Downregulated_HC, DatasetName=rep("Andrus_2012_WistarMoreImmobileRats_Downregulated_HC", length(Andrus_2012_WistarMoreImmobileRats_Downregulated_HC)), stringsAsFactors=FALSE)
)

Replicated_InternalizingBehavior_DifferentiallyExpressed_HC<-unique(InternalizingBehaviorGeneSets$GeneSymbol_Rat[duplicated(InternalizingBehaviorGeneSets$GeneSymbol_Rat)])
# [1] "Chd1l"        "Pcdhga1"      "Ak1"          "Drg1"         "Ghdc"         "Tmem144"      "Trhr"         "Zfp90"        "Trim45"       "Acox3"       
# [11] "Apln"         "Cav1"         "Eif2b1"       "Fcrl2"        "Htra1"        "Mfge8"        "Mknk1"        "Pdlim5"       "Pgm1"         "Rarres2"     
# [21] "Rbm3"         "Rhpn2"        "Robo3"        "Sh3bgr"       "Slc19a3"      "Slc25a18"     "Slc27a1"      "Sparcl1"      "Sun2"         "Tek"         
# [31] "Tmem176a"     "Tmem2"        "Zfp612"       "Slc35d3"      "Larp6"        "Cmc1"         "Abcg2"        "Ccdc107"      "Comt"         "Dcn"         
# [41] "Fam111a"      "Mgst1"        "P2rx4"        "Ppfibp2"      "Rab3b"        "Slc1a3"       "Sst"          "St5"          "Thy1"         "Tradd"       
# [51] "Tufm"         "C1qa"         "Fmo5"         "Fxyd7"        "Prss35"       "Rtn4ip1"      "Tes"          "Birc2"        "Camkk2"       "Ccnd1"       
# [61] "Cd48"         "Clic2"        "Commd6"       "Cyp4f4"       "F2r"          "Fkbp9"        "Fxyd5"        "Hapln1"       "Mfap3"        "Otub1"       
# [71] "Phf20l1"      "Pik3c2a"      "Pxdn"         "RGD1359508"   "Rnase4"       "Tmem100"      "Tubgcp2"      "Vwa5b2"       "Col6a1"       "Tmco5a"      
# [81] "Csad"         "Sncg"         "Frem3"        "Abcc9"        "Cd74"         "Gda"          "Ndufv2"       "Bmp4"         "Ccdc137"      "Ist1"        
# [91] "Naa50"        "Nudt4"        "Prrt2"        "Zfp821"       "Abhd13"       "Arhgap32"     "Arl16"        "Bmp3"         "Ccdc174"      "Ccndbp1"     
# [101] "Csdc2"        "Cyp2j3"       "Cyp4v3"       "Endod1"       "Eva1a"        "Fn1"          "Grm5"         "Hnrnpa1"      "Irgq"         "Jund"        
# [111] "Lcp1"         "Letm2"        "LOC102546433" "LOC103691688" "LOC688778"    "Lrrc61"       "Lsm14b"       "Mfap3l"       "Mfsd10"       "Nat8l"       
# [121] "Nqo1"         "Pfas"         "Pfkfb2"       "Pggt1b"       "Phip"         "Pkia"         "Ppp4c"        "Ptgr1"        "Ripk2"        "S100a10"     
# [131] "Sec23b"       "Sec23ip"      "Spint1"       "Sppl2a"       "Thrsp"        "Uggt2"        "Vps13c"       "Wipi2"        "Adam1a"       "Aqp9"        
# [141] "Arhgap20"     "Blvrb"        "Bmpr2"        "Bphl"         "Ccdc77"       "Cisd2"        "Grem2"        "Hcrt"         "Hspb1"        "Lrrc8b"      
# [151] "Magi1"        "Mis12"        "Mtmr1"        "Mx2"          "Pnpo"         "Ptprj"        "Rdx"          "Retsat"       "Serpinb9"     "Syt12"       
# [161] "Pvrl1"        "Spp1"         "Tgfbi"        "Mdh1"         "Ptpro"        "Slc3a1"       "Acad11"       "Akr1cl"       "C1qc"         "Gal"         
# [171] "Lcat"         "Medag"        "Tdg"          "Tnnt1"        "Trappc6a"     "Ucp2"         "Adpgk"        "Atg12"        "Bhlhe22"      "Cep95"       
# [181] "Chi3l1"       "Creg1"        "Cyp7b1"       "Deptor"       "Dnajc30"      "Dut"          "Ephx2"        "Gaa"          "Gad1"         "Gfra1"       
# [191] "Gldc"         "Golm1"        "Ilf3"         "Kidins220"    "Lancl1"       "LOC100911253" "LOC102552880" "LOC103692950" "Mdm4"         "Mpeg1"       
# [201] "Opa1"         "Pcdh8"        "Prelp"        "Prepl"        "Pwp2"         "Rnf6"         "Rsrp1"        "Stxbp1"       "Syt1"         "Zfp180"      
# [211] "Acat1"        "Akap5"        "Blnk"         "C3"           "Cib2"         "Dpyd"         "Dsp"          "F11r"         "Fbln2"        "Fntb"        
# [221] "Itga7"        "LOC100174910" "Lum"          "Nqo2"         "Perp"         "Plekhh1"      "RGD1309104"   "Pcdh15"       "Pqlc2"        "RT1-Da"      
# [231] "Sostdc1"      "Id3"          "Prlr"         "Vdac1"        "Celsr3"       "Sec63"        "Clec9a"       "Traf6"        "Slc22a7"      "Tspan7"      
# [241] "Mppe1"        "Acbd4"        "Capg"         "Ccdc62"       "Chst2"        "Kdm5b"        "Ltk"          "Numbl"        "Slc24a3"      "Crtac1"      
# [251] "Fxyd3"        "RGD1305680"   "Abcb10"       "Acvr1c"       "Dtnb"         "Kcnab2"       "Ophn1"        "Pik3r1"       "Serinc2"      "Strbp"       
# [261] "Tef"          "Pigh"         "Atp1b2"       "Pdzd2"        "Bcat1"        "Cav2"         "Ehd4"         "Etfa"         "Igfbp5"       "Inpp5f"      
# [271] "P2ry14"       "Slc35f1"      "Tcn2"         "Thoc1"        "Inadl"        "Psme4"        "RGD1308772"   "Agtpbp1"      "Calml4"       "Clic6"       
# [281] "Creb1"        "Dab2"         "F5"           "Gls"          "Kalrn"        "Krt8"         "Mcat"         "Mfrp"         "Nedd4"        "Pak1"        
# [291] "Sez6l2"       "Slc31a1"      "Slc6a20"      "Ttr"          "Yipf3"    

InternalizingBehaviorGeneSets<-rbind(InternalizingBehaviorGeneSets, 
                                     data.frame(GeneSymbol_Rat=Replicated_InternalizingBehavior_DifferentiallyExpressed_HC, DatasetName=rep("Replicated_InternalizingBehavior_DifferentiallyExpressed_HC", length(Replicated_InternalizingBehavior_DifferentiallyExpressed_HC)), stringsAsFactors=FALSE))

write.csv(InternalizingBehaviorGeneSets, "InternalizingBehaviorGeneSets.csv")
