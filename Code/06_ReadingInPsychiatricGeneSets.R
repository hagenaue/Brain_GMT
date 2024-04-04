
#Genes with strong evidence supporting their differential expression in psychiatric disorder (meta-analysis):

Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis<-read.csv("Gandal_2018_PsychTranscriptomeVsGenetics_Suppl_TableS1_MicroarrayMetaAnalysis.csv", header=TRUE, stringsAsFactors = FALSE)

Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis<-read.csv("Gandal_2018_PsychTranscriptomeVsGenetics_Suppl_TableS1_RNASeqMetaAnalysis.csv", header=TRUE, stringsAsFactors = FALSE)

str(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis)

#these two analyses produced such large gene lists I needed to add a p-value cut-off to make an effective gene set:
length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.beta_log2FC>0)])
#[1] 1096


length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.P.value<0.001)])
#[1] 532

Gandal_2018_AutismSpectrumDisorder_Upregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.P.value<0.001)])
#[1] 616

Gandal_2018_AutismSpectrumDisorder_Downregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$ASD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.P.value<0.001)])
#[1] 461

Gandal_2018_Schizophrenia_Upregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.P.value<0.001)])
#[1] 636

Gandal_2018_Schizophrenia_Downregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$SCZ.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.P.value<0.001)])
#[1] 178

Gandal_2018_BipolarDisorder_Upregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.P.value<0.001)])
#[1] 191

Gandal_2018_BipolarDisorder_Downregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$BD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.P.value<0.001)])
#[1] 183

Gandal_2018_MajorDepressiveDisorder_Upregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.P.value<0.001)])
#[1] 145

Gandal_2018_MajorDepressiveDisorder_Downregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$MDD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.P.value<0.001)])
#[1] 289

Gandal_2018_AlcoholAbuseDisorder_Upregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.beta_log2FC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.P.value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.P.value<0.001)])
#[1] 312

Gandal_2018_AlcoholAbuseDisorder_Downregulated_Cortex<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$hgnc_symbol[which(Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.FDR<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.beta_log2FC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_MicroarrayMetaAnalysis$AAD.P.value<0.001)])

#Hmmm... I forgot that the RNA-Seq data is only given in Ensembl notation. I'll need to decipher that to gene symbols to use it for a gene set:
length(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis$X)

library(org.Hs.eg.db)

x <- org.Hs.egSYMBOL
mapped_genes <- mappedkeys(x)
xx <- as.list(x[mapped_genes])

xx[1]
# $`1`
# [1] "A1BG"
names(xx[1])
#[1] "1"
names(xx[800])
#[1] "100128946"
#Hmm...
#Apparently this package only maps to Entrez, not Ensembl. :(

columns(org.Hs.eg.db)
# [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"    
# [11] "GO"           "GOALL"        "IPI"          "MAP"          "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"         "PMID"        
# [21] "PROSITE"      "REFSEQ"       "SYMBOL"       "UCSCKG"       "UNIGENE"      "UNIPROT" 

#Ah - I think I need to map both Symbol and Ensembl back to Entrez to align them.
#Or maybe not?

keytypes(org.Hs.eg.db)
# [1] "ACCNUM"       "ALIAS"        "ENSEMBL"      "ENSEMBLPROT"  "ENSEMBLTRANS" "ENTREZID"     "ENZYME"       "EVIDENCE"     "EVIDENCEALL"  "GENENAME"    
# [11] "GO"           "GOALL"        "IPI"          "MAP"          "OMIM"         "ONTOLOGY"     "ONTOLOGYALL"  "PATH"         "PFAM"         "PMID"        
# [21] "PROSITE"      "REFSEQ"       "SYMBOL"       "UCSCKG"       "UNIGENE"      "UNIPROT"     

uniKeys <- head(keys(org.Hs.eg.db, keytype="ENSEMBL"))
cols <- c("SYMBOL")
select(org.Hs.eg.db, keys=uniKeys, columns=cols, keytype="ENSEMBL")
# 'select()' returned 1:1 mapping between keys and columns
# ENSEMBL   SYMBOL
# 1 ENSG00000121410     A1BG
# 2 ENSG00000175899      A2M
# 3 ENSG00000256069    A2MP1
# 4 ENSG00000171428     NAT1
# 5 ENSG00000156006     NAT2
# 6 ENSG00000196136 SERPINA3

#Lovely.

colnames(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis)[1]<-"ENSEMBL"
str(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis)
#'data.frame':	15823 obs. of  9 variables:

EnsemblVsGeneSymbol_Human<-select(org.Hs.eg.db, keys=Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis$ENSEMBL, columns=cols, keytype="ENSEMBL")
str(EnsemblVsGeneSymbol_Human)
# 'data.frame':	16187 obs. of  2 variables:
# $ ENSEMBL: chr  "ENSG00000000003" "ENSG00000000419" "ENSG00000000457" "ENSG00000000460" ...
# $ SYMBOL : chr  "TSPAN6" "DPM1" "SCYL3" "C1orf112" ...

Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols<-join(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis, EnsemblVsGeneSymbol_Human, by="ENSEMBL", type="left", match="all")
str(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols)
#'data.frame':	15823 obs. of  10 variables:


length(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.logFC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.P.Value<0.001)])
#[1] 344

Gandal_2018_Schizophrenia_Upregulated_PFC<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.logFC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.P.Value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.logFC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.P.Value<0.001)])
#[1] 535

Gandal_2018_Schizophrenia_Downregulated_PFC<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.logFC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SCZ.P.Value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.logFC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.P.Value<0.001)])
#[1] 77

Gandal_2018_BipolarDisorder_Upregulated_PFC<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.logFC>0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.P.Value<0.001)])

length(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.logFC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.P.Value<0.001)])  
#[1] 107

Gandal_2018_BipolarDisorder_Downregulated_PFC<-unique(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$SYMBOL[which(Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.adj.P.Val<0.05 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.logFC<0 & Gandal_2018_PsychTranscriptomeVsGenetics_RNASeqMetaAnalysis_wSymbols$BD.P.Value<0.001)]) 


#Can I make the combining gene sets code a little smoother?
Gandal_2018_GeneSets<-list(Gandal_2018_Schizophrenia_Downregulated_PFC,Gandal_2018_Schizophrenia_Upregulated_PFC, Gandal_2018_Schizophrenia_Downregulated_Cortex, Gandal_2018_Schizophrenia_Upregulated_Cortex,Gandal_2018_BipolarDisorder_Downregulated_Cortex,Gandal_2018_BipolarDisorder_Downregulated_PFC, Gandal_2018_BipolarDisorder_Upregulated_Cortex, Gandal_2018_BipolarDisorder_Upregulated_PFC, Gandal_2018_MajorDepressiveDisorder_Downregulated_Cortex, Gandal_2018_MajorDepressiveDisorder_Upregulated_Cortex, Gandal_2018_AlcoholAbuseDisorder_Downregulated_Cortex,Gandal_2018_AlcoholAbuseDisorder_Upregulated_Cortex, Gandal_2018_AutismSpectrumDisorder_Downregulated_Cortex, Gandal_2018_AutismSpectrumDisorder_Upregulated_Cortex)

Gandal_2018_GeneSet_Names<-list("Gandal_2018_Schizophrenia_Downregulated_PFC","Gandal_2018_Schizophrenia_Upregulated_PFC", "Gandal_2018_Schizophrenia_Downregulated_Cortex", "Gandal_2018_Schizophrenia_Upregulated_Cortex","Gandal_2018_BipolarDisorder_Downregulated_Cortex","Gandal_2018_BipolarDisorder_Downregulated_PFC", "Gandal_2018_BipolarDisorder_Upregulated_Cortex", "Gandal_2018_BipolarDisorder_Upregulated_PFC", "Gandal_2018_MajorDepressiveDisorder_Downregulated_Cortex", "Gandal_2018_MajorDepressiveDisorder_Upregulated_Cortex", "Gandal_2018_AlcoholAbuseDisorder_Downregulated_Cortex","Gandal_2018_AlcoholAbuseDisorder_Upregulated_Cortex", "Gandal_2018_AutismSpectrumDisorder_Downregulated_Cortex", "Gandal_2018_AutismSpectrumDisorder_Upregulated_Cortex")

HumanPsychiatricGeneSets<-data.frame(GeneSymbol_Human=character(), DatasetName=character(), stringsAsFactors = FALSE)
str(HumanPsychiatricGeneSets)

Gandal_2018_GeneSets[[1]]

for(i in c(1:length(Gandal_2018_GeneSet_Names))){
  HumanPsychiatricGeneSets<-rbind(HumanPsychiatricGeneSets, 
                                  data.frame(GeneSymbol_Human=as.character(Gandal_2018_GeneSets[[i]]), DatasetName=as.character(rep(Gandal_2018_GeneSet_Names[[i]], length(Gandal_2018_GeneSets[[i]]))), stringsAsFactors=FALSE))
}

str(HumanPsychiatricGeneSets)
# 'data.frame':	4420 obs. of  2 variables:
#   $ GeneSymbol_Human: chr  "BAD" "DBNDD1" "MSL3" "TSPOAP1" ...
# $ DatasetName     : chr  "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" ...

#Note: There are definitely some NAs in here that need to be removed - maybe after adding species-specific annotation.

HumanPsychiatricGeneSets<-HumanPsychiatricGeneSets[is.na(HumanPsychiatricGeneSets$GeneSymbol_Human)==FALSE,]
str(HumanPsychiatricGeneSets)
#'data.frame':	4416 obs. of  2 variables:
# $ GeneSymbol_Human: chr  "BAD" "DBNDD1" "MSL3" "TSPOAP1" ...
# $ DatasetName     : chr  "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" "Gandal_2018_Schizophrenia_Downregulated_PFC" ...

setwd("/Users/mhh/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(HumanPsychiatricGeneSets, "HumanPsychiatricGeneSets.csv")

