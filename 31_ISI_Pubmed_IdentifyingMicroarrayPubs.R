
#Publication information from ISI:

setwd("~/Documents/SideProjects/BrainGMT/ISI")

BrainMicroarrayPubs<-read.csv("BrainMicroarray_savedrecs_CompiledwCitationReport_forR.csv", header=TRUE, stringsAsFactors = FALSE)  
str

#Adding some filters:
dim(BrainMicroarrayPubs[BrainMicroarrayPubs$Publication.Year<2012 & BrainMicroarrayPubs$Publication.Year>2000,])
#[1] 3435   50

table(BrainMicroarrayPubs$Publication.Year, BrainMicroarrayPubs$Associated.Data...T.F.)
#        0   1
# 1996   1   0
# 1998   2   0
# 1999   8   0
# 2000  27   0
# 2001  77   0
# 2002 120   8
# 2003 162   9
# 2004 249  18
# 2005 300  44
# 2006 302  48
# 2007 295  58
# 2008 340  79
# 2009 337  89
# 2010 333  82
# 2011 378  79
# 2012 353 124
# 2013 307 113
# 2014 344 104
# 2015 365  75
# 2016 384  25
# 2017 378  22
# 2018 326  18
# 2019 308  10
# 2020 272  18
# 2021 125   1

#Unlike Pubmed, it doesn't seem like most publications have associated data after 2011. I suspect they are being massively undercounted.
#I wonder why the numbers drop after 2014
#Join with Pubmed output to get better quality data?

##############

setwd("~/Documents/SideProjects/BrainGMT/Pubmed")

Pubmed_PubsWData<-read.csv("BrainMicroarrayWData_PubsCompiled.csv", header=TRUE, stringsAsFactors = FALSE)
str(Pubmed_PubsWData)

head(BrainMicroarrayPubs$Pubmed.Id)

sum(BrainMicroarrayPubs$Pubmed.Id%in%Pubmed_PubsWData$PMID)
#[1] 2116

BrainMicroarrayPubs$Has.Associated.Data.InPubmed<-BrainMicroarrayPubs$Pubmed.Id%in%Pubmed_PubsWData$PMID

table(BrainMicroarrayPubs$Associated.Data...T.F., BrainMicroarrayPubs$Has.Associated.Data.InPubmed)
#   FALSE TRUE
# 0  4431 1690
# 1   598  426

#Interesting- each dataset has a slightly different set of pubs that are indicated to have associated data.

sum(BrainMicroarrayPubs$Associated.Data...T.F.==TRUE|BrainMicroarrayPubs$Has.Associated.Data.InPubmed==1)
#[1] 2714

dim(BrainMicroarrayPubs)
#[1] 7145   51

#I wonder how much the discrepancy is explained by Publications lacking PubmedIDs

BrainMicroarrayPubs_wPMID<-BrainMicroarrayPubs[is.na(BrainMicroarrayPubs$Pubmed.Id)==FALSE,]

dim(BrainMicroarrayPubs_wPMID)
#[1] 6921   51

table(BrainMicroarrayPubs_wPMID$Associated.Data...T.F., BrainMicroarrayPubs_wPMID$Has.Associated.Data.InPubmed)
#   FALSE TRUE
# 0  4209 1690
# 1   596  426

#That mostly just eliminated publications from the "no associated data" category.

#I wonder if it would be an even higher percentage if we only looked at particular years (and maybe with some filtering criteria that might generally indicate publication quality)

table((BrainMicroarrayPubs_wPMID$Associated.Data...T.F.| BrainMicroarrayPubs_wPMID$Has.Associated.Data.InPubmed), BrainMicroarrayPubs_wPMID$Publication.Year)

#       1996 1998 1999 2000 2001 2002 2003 2004 2005 2006 2007 2008 2009 2010 2011 2012 2013 2014 2015 2016 2017 2018 2019 2020 2021
# FALSE    1    2    8   26   69  114  157  245  286  283  280  323  320  317  358  127   70   71  194  111   70  105  276  253  117
# TRUE     0    0    0    1    6   11   10   19   48   56   60   82   91   84   85  333  340  369  232  281  311  228   33   24    7

#I wonder how many of these also have PMC IDs (i.e., NIH funding)
#I'll have to crossreference it with the Pubmed database to gather that information


