#What's in GeneWeaver:

setwd("~/Documents/SideProjects/BrainGMT/GeneWeaver")
GeneWeaver_GeneSets<-read.delim("publications2symbols.dat", sep="\t", header=FALSE, stringsAsFactors = FALSE)
str(GeneWeaver_GeneSets)
head(GeneWeaver_GeneSets)

# 'data.frame':	693 obs. of  4 variables:
#   $ V1: chr  "Differential effects in hippocampus and amygdala of high and low anxiety selected lines" "Hippocampus vs. Amygdala main effect Contextual fear conditioning Selected Lines -Differential Expression" "Ethanol preference related in Amygdala of congenic rat strains" "EtOH Preference related in Hippocampus of Congenic Rat Strains" ...
# $ V2: num  17309658 17309658 17451403 17451403 17451403 ...
# $ V3: int  10090 10090 10116 10116 10116 10116 10116 10090 10116 10116 ...
# $ V4: chr  "Igfals,Polr1b,Noct,Col9a3,Ptprq,Ybx2,Tex261,Nrg3,Ackr1,Klrc2,Pak3,Galnt7,Zw10,Sdhaf3,Myo19,Tmem33,Akirin1,G6pc3"| __truncated__ "Apod,Cd19,Hspa9-ps1,Rab7,Igfals,Polr1b,Noct,Col9a3,Ptprq,Ybx2,Tex261,Nrg3,Ackr1,Klrc2,Pak3,Galnt7,Zw10,Sdhaf3,M"| __truncated__ "" "" ...

#Can I write these out into a file type that is readable in Excel?

write.table(GeneWeaver_GeneSets, "publications2symbols.txt", sep="\t")

#Sanity Check:
GeneWeaver_GeneSets[GeneWeaver_GeneSets$V1=="Differentially expressed genes upregulated in Amygdala after single-prolonged stress treatment",]
#PSMB8,RHBDF1,Rtl8a,LSM3P5,LOC100361572
#On GeneWeaver website: Ace, Htr2c, Kl, Nfx1, Otx2
#Website matches pubication.

GeneWeaver_GeneSets[GeneWeaver_GeneSets$V1=="Downregulation of gene expression in the lateral hypothalamus of mu opioid Knockout (KO) mice following administration of chronic morphine",]
#Frs2,Gpr33,Efcab1,Cibar1
#On GeneWeaver website: Apln, Aqp4, RGS16, RGS4
#Website matches pubication.

GeneWeaver_GeneSets[GeneWeaver_GeneSets$V1=="Upregulated Nicotine-dependent genes in human neuroblastoma (SH-SY5Y) cells",]
#Gm44226,Gm52104,PDYN
#On GeneWeaver website: RFXAP, TFPI2, ZFR


#One of those columns of numbers is PubmedIDs, the other is probably taxon (maybe?)
dim(table(GeneWeaver_GeneSets$V2))
#[1] 298
#Looks like there are 298 pubmed ids associated with the 693 gene sets.

sum(GeneWeaver_GeneSets$V2%in%BrainMicroarrayPubs$Pubmed.Id)
#[1] 250
#Nice...

table(GeneWeaver_GeneSets$V3)
# 4932  6239  7227  7955  9606 10090 10116 
# 4    10     8     4   296   254   117
#These must be taxon

GeneWeaver_GeneSets$V4[1]
# [1] "Igfals,Polr1b,Noct,Col9a3,Ptprq,Ybx2,Tex261,Nrg3,Ackr1,Klrc2,Pak3,Galnt7,Zw10,Sdhaf3,Myo19,Tmem33,Akirin1,G6pc3,Tmem140,Lce1b,Dipk2a,Mtfp1,1700027A15Rik,Tspo2,Sdr9c7,Zfp995,Cyp4f16,Adgra3,Mex3b,Cenpu,Noxo1,4932437C15Rik,Atp13a2,4930597L12Rik,4833422M21Rik,Dcp1a,Rab11fip4os2,Efcab11,Tnfrsf23,AI480526,Arrdc3,Xxylt1,Nsun3,Ash1l,Plch2,Jph4,Rccd1,Dhtkd1,Hspa9-ps1,Rab7,Apod,Cd19"

GeneWeaver_GeneSets$V4[2]
#[1] "Apod,Cd19,Hspa9-ps1,Rab7,Igfals,Polr1b,Noct,Col9a3,Ptprq,Ybx2,Tex261,Nrg3,Ackr1,Klrc2,Pak3,Galnt7,Zw10,Sdhaf3,Myo19,Tmem33,Akirin1,G6pc3,Tmem140,Lce1b,Dipk2a,Mtfp1,1700027A15Rik,Tspo2,Sdr9c7,Zfp995,Cyp4f16,Adgra3,Mex3b,Cenpu,Noxo1,4932437C15Rik,Atp13a2,4930597L12Rik,4833422M21Rik,Dcp1a,Rab11fip4os2,Efcab11,Tnfrsf23,AI480526,Arrdc3,Xxylt1,Nsun3,Ash1l,Plch2,Jph4,Rccd1,Dhtkd1"

#Looks great. :)


table(BrainMicroarrayPubs_wPMID$Pubmed.Id%in%GeneWeaver_GeneSets$V2, (BrainMicroarrayPubs_wPMID$Associated.Data...T.F.| BrainMicroarrayPubs_wPMID$Has.Associated.Data.InPubmed))

#       FALSE TRUE
# FALSE  4164 2682
# TRUE     45   30

#Huh- why does that only add up to 75?

table(BrainMicroarrayPubs_wPMID$Pubmed.Id%in%GeneWeaver_GeneSets$V2)

# FALSE  TRUE 
# 6846    75 

#Oh wait - there must be only a few Pubmed IDs mapping to lots of gene sets in GeneWeaver.

length(GeneWeaver_GeneSets$V2[GeneWeaver_GeneSets$V2%in%BrainMicroarrayPubs_wPMID$Pubmed.Id])
#[1] 245

dim(table(GeneWeaver_GeneSets$V2[GeneWeaver_GeneSets$V2%in%BrainMicroarrayPubs_wPMID$Pubmed.Id]))
#[1] 75
#There we go

#Double-checking against the larger Pubmed database:

sum(GeneWeaver_GeneSets$V2%in%Pubmed_PubsWData$PMID)
#[1] 52

dim(table(GeneWeaver_GeneSets$V2))
#[1] 298

#So roughly 3/4 of the GeneWeaver gene sets are either not explicitly brain related or don't have associated data in Pubmed. 
#Since there are so few, I should probably just glance over the list of gene sets and see which look like they're not brain - I need to do that anyway for my .gmt.
#Eyeballing the list, there are a few related to ulcerative colitis or GWAS candidates, but mostly brain transcriptional profiling. There are also some that are empty (no genes associated with the gene set)
#Ah - I forgot that these publications can also be RNA-Seq - although the main question I was trying to answer was regarding how many of the old microarray studies are covered by GeneWeaver.
#Interesting - most of the gene sets in GeneWeaver aren't directional.

#When I come back:
#Prune the GeneWeaver .gmt file down to brain transcriptional profiling studies
#Try plotting some of the Publications w/ data vs. without for citation counts 1-2 years post publication and 5-6 years post publication
#Finish setting up files for Evelyn to make boxplots (joining QC-ed subject info with drug info, outputting DeltaDeltaCq for GabaGlu and DA5HT)


