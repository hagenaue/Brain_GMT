###############################################

#Reading in DropViz cell type markers:

#Dropviz.org accessed 03-25-2021
#Query->Parameters->Clusters->CompareClusters
#Ran two queries:
#All Target Clusters within the striatum (STR) vs. as comparison "Rest of Striatum"
#All Target Clusters within the hippocampus (HC) vs. as comparison "Rest of Hippocampus"
#Differential Expression Criteria: 
#Minimum Fold Ratio of 4 (log2 = difference of 2)
#Maximum P-value exponent: -30
#Min mean Log amount in Target: 0.5 (1.4 transcripts per cell)
#Max Mean Log amount in Comparison group: 6 (highest possible choice) - so basically we don't care if the gene is highly expressed, just that it is more highly expressed in the cell type of interest.

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/DropViz_HC")

DropViz_HC_Files<-list.files()

#To get started:
DropViz_HC_CellTypeClusterMarkers<-read.csv(DropViz_HC_Files[1], header=TRUE, stringsAsFactors = FALSE)
str(DropViz_HC_CellTypeClusterMarkers)
DropViz_HC_CellTypeClusterMarkers$CellType<-rep(paste(DropViz_HC_Files[1]), nrow(DropViz_HC_CellTypeClusterMarkers))

DropViz_HC_CellTypeClusterMarkers_Concise<-DropViz_HC_CellTypeClusterMarkers[DropViz_HC_CellTypeClusterMarkers$fc.disp>10,]

for(i in c(2:length(DropViz_HC_Files))){
  Temp<-read.csv(DropViz_HC_Files[i], header=TRUE, stringsAsFactors = FALSE)
  Temp$CellType<-rep(paste(DropViz_HC_Files[i]), nrow(Temp))
  
  print(paste(DropViz_HC_Files[i]))
  print(dim(Temp))
  DropViz_HC_CellTypeClusterMarkers<-rbind(DropViz_HC_CellTypeClusterMarkers, Temp)
  
  if(nrow(Temp)>50){
    print(sum(Temp$fc.disp>10))
    if(sum(Temp$fc.disp>10)>50){
      Temp_Concise<-Temp[Temp$fc.disp>10,]
    }else{Temp_Concise<-Temp[c(1:50),]}
    print(dim(Temp_Concise))
    DropViz_HC_CellTypeClusterMarkers_Concise<-rbind(DropViz_HC_CellTypeClusterMarkers_Concise, Temp_Concise)
    rm(Temp_Concise)
  }
  rm(Temp)
}

str(DropViz_HC_CellTypeClusterMarkers)
#'data.frame':	4780 obs. of  21 variables
str(DropViz_HC_CellTypeClusterMarkers_Concise)
#'data.frame':	1699 obs. of  21 variables

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(DropViz_HC_CellTypeClusterMarkers, "DropViz_HC_CellTypeClusterMarkers.csv")
write.csv(DropViz_HC_CellTypeClusterMarkers_Concise, "DropViz_HC_CellTypeClusterMarkers_Concise.csv")

##############

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325/DropViz_STR")

DropViz_STR_Files<-list.files()

#To get started:
DropViz_STR_CellTypeClusterMarkers<-read.csv(DropViz_STR_Files[1], header=TRUE, stringsAsFactors = FALSE)
str(DropViz_STR_CellTypeClusterMarkers)
DropViz_STR_CellTypeClusterMarkers$CellType<-rep(paste(DropViz_STR_Files[1]), nrow(DropViz_STR_CellTypeClusterMarkers))

DropViz_STR_CellTypeClusterMarkers_Concise<-DropViz_STR_CellTypeClusterMarkers[DropViz_STR_CellTypeClusterMarkers$fc.disp>10,]

for(i in c(2:length(DropViz_STR_Files))){
  Temp<-read.csv(DropViz_STR_Files[i], header=TRUE, stringsAsFactors = FALSE)
  Temp$CellType<-rep(paste(DropViz_STR_Files[i]), nrow(Temp))
  
  print(paste(DropViz_STR_Files[i]))
  print(dim(Temp))
  DropViz_STR_CellTypeClusterMarkers<-rbind(DropViz_STR_CellTypeClusterMarkers, Temp)
  
  if(nrow(Temp)>50){
    print(sum(Temp$fc.disp>10))
    if(sum(Temp$fc.disp>10)>50){
      Temp_Concise<-Temp[Temp$fc.disp>10,]
    }else{Temp_Concise<-Temp[c(1:50),]}
    print(dim(Temp_Concise))
    DropViz_STR_CellTypeClusterMarkers_Concise<-rbind(DropViz_STR_CellTypeClusterMarkers_Concise, Temp_Concise)
    rm(Temp_Concise)
  }
  rm(Temp)
}

str(DropViz_STR_CellTypeClusterMarkers)
#'data.frame':	5021 obs. of  21 variables:
str(DropViz_STR_CellTypeClusterMarkers_Concise)
#'data.frame':	1769 obs. of  21 variables:

setwd("~/Documents/Microarray Gen/Angela_HRLR_EE_Stress/NAcc_Remove2outliers/11_FGSEA/UpdatedGMT_20210325")
write.csv(DropViz_STR_CellTypeClusterMarkers, "DropViz_STR_CellTypeClusterMarkers.csv")
write.csv(DropViz_STR_CellTypeClusterMarkers_Concise, "DropViz_STR_CellTypeClusterMarkers_Concise.csv")

#################