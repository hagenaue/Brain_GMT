#Gemma: Downloading NACC Differential Expression Results

#####################################

#I had trouble using the api to download differential expression results on mass. Here is the code that should work:
DEResults = 
  datasetInfo('GSE107999',
              request='degs', # we want this endpoint to return data. see documentation
              differential='94808', #from DEComparisons[[1]]$id
              return = TRUE, # TRUE by default, all functions have this. if false there'll be no return
              file = NULL # NULL by default, all functions have this. If specificed, output will be saved.
  )
#Error in loadNamespace(name) : there is no package called ‘chromote’


install_github("rstudio/chromote")
# ERROR: dependencies ‘websocket’, ‘fastmap’ are not available for package ‘chromote’
# * removing ‘/Users/mhh/Library/R/3.4/library/chromote’
# Installation failed: Command failed (1)

#I think I just need to update. Sigh. 

#I tried installing websocket and it failed, I think because of the SSL option that I changed to make the gemma code work. I'll need to come back to this.
#Configuration failed because openssl was not found. 

#############

#A temporary work around:
#I downloaded the results for the datasets of interest (Nucleus accumbens + variables/conditions resembling our own) and unzipped them, then deleted the zip files 


library(plyr)

setwd("~/Documents/SideProjects/BrainGMT/Gemma/NucleusAccumbens")

NACC_DatasetsOfInterest<-list.files()

for(i in c(16:length(NACC_DatasetsOfInterest))){
  
  setwd("~/Documents/SideProjects/BrainGMT/Gemma/NucleusAccumbens")
  
  print(i)
  print(NACC_DatasetsOfInterest[i])
  
  setwd(paste("./", NACC_DatasetsOfInterest[i], sep=""))
  
  TempResultsFiles<-list.files()
  
  TempAnalysisResults<-read.delim("analysis.results.txt", sep="\t", stringsAsFactors = FALSE, comment.char = "#")
  
  TempResultsToJoin<-list(TempAnalysisResults)
  str(TempResultsToJoin)
  
  for(j in c(2:length(TempResultsFiles))){
    print(k)
    TempResultsToJoin[[j]]<-assign(paste("TempResultSet", j, sep=""), read.delim(TempResultsFiles[j], sep="\t", stringsAsFactors = FALSE, comment.char = "#"))
  }
  
  TempResultsJoined<-join_all(TempResultsToJoin, by="Element_Name")
  
  write.csv(TempResultsJoined, "TempResultsJoined.csv")
  
  rm(TempResultsFiles, TempAnalysisResults, TempResultsToJoin)
  
  TempIndicesForQValueColumns<-grep("QValue", colnames(TempResultsJoined),)
  
  for(k in c(TempIndicesForQValueColumns)){
    print(k)
    print(colnames(TempResultsJoined)[k])
    if(sum(TempResultsJoined[,k]<0.10 & TempResultsJoined[,k+1]<0.0001, na.rm=TRUE)>0){
      write.csv(TempResultsJoined[TempResultsJoined[,k]<0.10 & TempResultsJoined[,k+1]<0.0001,], paste(colnames(TempResultsJoined)[k], "_10.csv", sep=""))
    }else{}
    
  }
  
  rm(TempResultsJoined, TempIndicesForQValueColumns)
  
}

# [1] 15
# [1] "693_GSE8870_diffExpAnalysis_29489"
# Error in read.table(file = file, header = header, sep = sep, quote = quote,  : 
#                       more columns than column names

#for some reason this file isn't reading in properly, so I skipped it.
#it was the first dataset that I downloaded, and I think I might have messed around with the files so some of the comments weren't hashtagged. I added some hashtags and it seems to work now.

i<-15

#Other steps I should add to the automated code to be one step closer to actual gene sets.
#1. Remove results without gene symbols
#2. Remove results with multiple mappings
#3. Deal with "date genes"
#4. For results with multiple factor levels, pull out results that are nominally significant for each level.
#4. Count duplicates, and for any genes with duplicates showing the same direction of effect, choose the most extreme value.
#5. Decide whether there are sufficient results to split results into down and upregulated
#6. Split results when relevant.
#7. Output the final gene set sizes.

#Questions for Paul:
#1: Are they taking into account the multi-level nature of the data from multiple organism parts? (says ANOVA)
#2: Why do the contrast p-values for factors with only 2 levels not match the ANOVA output?
#3: How do we interpret the contrast output for models with interaction terms?  (main effect vs. effect within reference group?)

