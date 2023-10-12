#Gemma: Downloading HC Differential Expression Results

#Adapting the code from the Nucleus Accumbens analysis to make even more steps automated...


setwd("~/Documents/SideProjects/BrainGMT/Gemma")

DateGeneDecoder<-read.csv("DateGeneDecoder.txt", header=TRUE, stringsAsFactors = FALSE)

DateGeneDecoder_Human<-DateGeneDecoder
DateGeneDecoder_Human$OldSymbol<-toupper(DateGeneDecoder$OldSymbol)
DateGeneDecoder_Human$NewSymbol<-toupper(DateGeneDecoder$NewSymbol)


write(paste(DateGeneDecoder[,1],"='", DateGeneDecoder[,2], "',", sep=""), "DateGeneDecoder_Mouse_String.txt")
write(paste(DateGeneDecoder_Human[,1],"='", DateGeneDecoder_Human[,2], "',", sep=""), "DateGeneDecoder_Human_String.txt")
#This is a situation where I could have used the "collapse" function from the fstrings package to remove the unwanted "", but I couldn't install it because my entire system is out of date. I really need to fix that. But for, now, I'm just going to quickly take care of things by outputting to .txt and then come back and take care of the bigger problem later.

#ooh - here's another way to do it:
toString(paste(DateGeneDecoder[,1],"='", DateGeneDecoder[,2], "'", sep=""))
toString(paste(DateGeneDecoder_Human[,1],"='", DateGeneDecoder_Human[,2], "'", sep=""))


library(plyr)

setwd("~/Documents/SideProjects/BrainGMT/Gemma/Hippocampus")

HC_DatasetsOfInterest<-list.files()
#86

HC_GeneSets_Temp<-data.frame(Dataset_Name=character(), Factor_Contrast=character(), Direction=character(), Taxon=character(), GeneSetSize=numeric(), GeneSet=character())

#Loops over all folders (publications) of down-loaded results:

#These folders are problematic because they completely lack gene symbols:
c(28,65,69)

for(i in c(1:length(HC_DatasetsOfInterest))){
  
  setwd("~/Documents/SideProjects/BrainGMT/Gemma/Hippocampus")
  
  print(i)
  print(HC_DatasetsOfInterest[i])
  
  #Pulling out relevant meta-data for the dataset analysis:
  Dataset_ID<-strsplit(HC_DatasetsOfInterest[i], "_")[[1]]
  names(Dataset_ID)<-c("Gemma_ID", "GEO_Accession", "Output", "Result_ID")
  
  #This code bugs out when Gemma has added a .1 etc to denote more than one entry for a dataset, so I had to add a string split.
  
  Dataset_Annotation<-HC_Annotation_AsDF_Simpler[which(HC_Annotation_AsDF_Simpler$accession==strsplit(Dataset_ID[2][[1]], ".", fixed=TRUE)[[1]][1]),]
  
  Dataset_Name<-paste(Dataset_Annotation$accession, "_", gsub( " ", "_", Dataset_Annotation$name, fixed=TRUE), sep="")
  
  setwd(paste("./", HC_DatasetsOfInterest[i], sep=""))
  
  TempResultsFiles<-list.files()
  
  #Pulls out the ANOVA results:
  TempAnalysisResults<-read.delim("analysis.results.txt", sep="\t", stringsAsFactors = FALSE, comment.char = "#")
  
  TempResultsToJoin<-list(TempAnalysisResults)
  str(TempResultsToJoin)
  
  #Joins the ANOVA results to the results from the individual contrasts:
  for(j in c(2:length(TempResultsFiles))){
    print(k)
    TempResultsToJoin[[j]]<-assign(paste("TempResultSet", j, sep=""), read.delim(TempResultsFiles[j], sep="\t", stringsAsFactors = FALSE, comment.char = "#"))
  }
  
  TempResultsJoined<-join_all(TempResultsToJoin, by="Element_Name")
  
  write.csv(TempResultsJoined, "TempResultsJoined.csv")
  
  rm(TempResultsFiles, TempAnalysisResults, TempResultsToJoin)
  
  TempIndicesForQValueColumns<-grep("QValue", colnames(TempResultsJoined))
  TempIndicesForFoldChangeColumns<-grep("FoldChange", colnames(TempResultsJoined))
  
  #Removing rows lacking gene symbol annotation, with multi-mapped annotation, or "date" genes that need fixing:
  
  if(sum(is.na(TempResultsJoined$Gene_Symbol)==FALSE & (TempResultsJoined$Gene_Symbol=="")==FALSE & (TempResultsJoined$Gene_Symbol==" ")==FALSE)>0){
    
    TempResultsJoined_NoNA<-TempResultsJoined[is.na(TempResultsJoined$Gene_Symbol)==FALSE & (TempResultsJoined$Gene_Symbol=="")==FALSE & (TempResultsJoined$Gene_Symbol==" ")==FALSE & (TempResultsJoined$Gene_Symbol=="null")==FALSE & (TempResultsJoined$Gene_Symbol=="N/A")==FALSE,]
    
    rm(TempResultsJoined)
    
    TempResultsJoined_NoNA_NoMultimapped<-TempResultsJoined_NoNA[grep("[|]", TempResultsJoined_NoNA$Gene_Symbol, invert=TRUE),]
    
    rm(TempResultsJoined_NoNA)
    
    #To replace date genes, I need to first determine whether the gene symbols reflect humans or mice/rats, because the Excel perversion of the date genes is all lower case (i.e., the same in both species)
    #On the other hand, since this is all Gemma output, I'm pretty sure there won't be excel versions of the gene names. So maybe just skip that step and flag if there is an issue?
    
    sum(TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol%in%DateGeneDecoder[,1])
    
    TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol<-recode(TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol, Sept1='Septin1',
                                                             Sept2='Septin2',
                                                             Sept3='Septin3',
                                                             Sept4='Septin4',
                                                             Sept5='Septin5',
                                                             Sept6='Septin6',
                                                             Sept7='Septin7',
                                                             Sept8='Septin8',
                                                             Sept9='Septin9',
                                                             Sept10='Septin10',
                                                             Sept11='Septin11',
                                                             Sept12='Septin12',
                                                             Sept13='Septin13',
                                                             Sept14='Septin14',
                                                             Sept7p2='Septin7p2',
                                                             March1='Marchf1',
                                                             March2='Marchf2',
                                                             March3='Marchf3',
                                                             March4='Marchf4',
                                                             March5='Marchf5',
                                                             March6='Marchf6',
                                                             March7='Marchf7',
                                                             March8='Marchf8',
                                                             March9='Marchf9',
                                                             March10='Marchf10',
                                                             March11='Marchf11',
                                                             Dec1='Delec1',
                                                             Nov='Ccn3')
    
    TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol<-recode(TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol, SEPT1='SEPTIN1',
                                                             SEPT2='SEPTIN2',
                                                             SEPT3='SEPTIN3',
                                                             SEPT4='SEPTIN4',
                                                             SEPT5='SEPTIN5',
                                                             SEPT6='SEPTIN6',
                                                             SEPT7='SEPTIN7',
                                                             SEPT8='SEPTIN8',
                                                             SEPT9='SEPTIN9',
                                                             SEPT10='SEPTIN10',
                                                             SEPT11='SEPTIN11',
                                                             SEPT12='SEPTIN12',
                                                             SEPT13='SEPTIN13',
                                                             SEPT14='SEPTIN14',
                                                             SEPT7P2='SEPTIN7P2',
                                                             MARCH1='MARCHF1',
                                                             MARCH2='MARCHF2',
                                                             MARCH3='MARCHF3',
                                                             MARCH4='MARCHF4',
                                                             MARCH5='MARCHF5',
                                                             MARCH6='MARCHF6',
                                                             MARCH7='MARCHF7',
                                                             MARCH8='MARCHF8',
                                                             MARCH9='MARCHF9',
                                                             MARCH10='MARCHF10',
                                                             MARCH11='MARCHF11',
                                                             DEC1='DELEC1',
                                                             NOV='CCN3')
    
    sum(TempResultsJoined_NoNA_NoMultimapped$Gene_Symbol%in%DateGeneDecoder[,1])
    
    write.csv(TempResultsJoined_NoNA_NoMultimapped, "TempResultsJoined_GeneSymbolsClean.csv")
    
    #Overwrite the other version of the df to reuse previously-written code:
    TempResultsJoined<-TempResultsJoined_NoNA_NoMultimapped
    
    rm(TempResultsJoined_NoNA_NoMultimapped)
    
    #Loops over each variable and pulls out the rows of genes with q<0.10 (FDR<0.10) and p<0.0001 (to help cut down on the # of genes in results files with thousands of "sig" results):
    
    for(k in c(TempIndicesForQValueColumns)){
      print(k)
      print(colnames(TempResultsJoined)[k])
      if(sum(TempResultsJoined[,k]<0.10 & TempResultsJoined[,k+1]<0.0001, na.rm=TRUE)>0){
        TempResultsJoined_ResultK<-TempResultsJoined[TempResultsJoined[,k]<0.10 & TempResultsJoined[,k+1]<0.0001,]
        write.csv(TempResultsJoined_ResultK, paste(colnames(TempResultsJoined)[k], "_10.csv", sep=""))
        
        #For the genes that show a significant relationship with a variable (q<0.10 & p<0.0001), this code loops over each level of contrast and pulls out the results that are p<0.05 for that contrast. 
        #Note that only a handful of these combinations are actually meaningful - I couldn't figure out a good way to automatically match variable + relevant contrasts.
        
        for(m in c(TempIndicesForFoldChangeColumns)){
          print(m)
          
          TempContrast<-paste(gsub("QValue_", "", colnames(TempResultsJoined)[k]), gsub("FoldChange_", "", colnames(TempResultsJoined)[m]), sep="_")
          print(TempContrast)
          
          #Pulling out down-regulated genes for each contrast:
          if(sum(TempResultsJoined_ResultK[,m]<0 & TempResultsJoined_ResultK[,m+2]<0.05, na.rm=TRUE)>0){
            TempResultsJoined_ResultK_FoldChangeM_Down<-TempResultsJoined_ResultK[TempResultsJoined_ResultK[,m]<0 & TempResultsJoined_ResultK[,m+2]<0.05,]
            write.csv(TempResultsJoined_ResultK_FoldChangeM_Down, paste(colnames(TempResultsJoined)[k], "_10_w_", colnames(TempResultsJoined)[m], "_Down.csv", sep=""))
            
            if(nrow(TempResultsJoined_ResultK_FoldChangeM_Down)>999){
              TempResultsJoined_ResultK_FoldChangeM_Down_Reordered<-TempResultsJoined_ResultK_FoldChangeM_Down[order(TempResultsJoined_ResultK_FoldChangeM_Down[,m]),]
              TempResultsJoined_ResultK_FoldChangeM_Down<-TempResultsJoined_ResultK_FoldChangeM_Down_Reordered[c(1:999),]
              rm(TempResultsJoined_ResultK_FoldChangeM_Down_Reordered)
            }else{}
            
            TempResultsJoined_ResultK_FoldChangeM_Down_Symbols<-unique(TempResultsJoined_ResultK_FoldChangeM_Down$Gene_Symbol)
            
            write.csv(TempResultsJoined_ResultK_FoldChangeM_Down_Symbols, paste(colnames(TempResultsJoined)[k], "_10_w_", colnames(TempResultsJoined)[m], "_Down_UniqueSymbols.csv", sep=""))
            
            TempResultsJoined_ResultK_FoldChangeM_DownDF<-data.frame(Dataset_Name=Dataset_Name, Factor_Contrast=TempContrast, Direction="Down", Taxon=Dataset_Annotation$taxon, GeneSetSize=length(TempResultsJoined_ResultK_FoldChangeM_Down_Symbols), GeneSet=toString(TempResultsJoined_ResultK_FoldChangeM_Down_Symbols))
            
            HC_GeneSets_Temp<-rbind.data.frame(HC_GeneSets_Temp, TempResultsJoined_ResultK_FoldChangeM_DownDF)
            
            rm(TempResultsJoined_ResultK_FoldChangeM_Down, TempResultsJoined_ResultK_FoldChangeM_Down_Symbols, TempResultsJoined_ResultK_FoldChangeM_DownDF)
            
          }else{}
          
          #Pulling out up-regulated genes for each contrast:
          if(sum(TempResultsJoined_ResultK[,m]>0 & TempResultsJoined_ResultK[,m+2]<0.05, na.rm=TRUE)>0){
            TempResultsJoined_ResultK_FoldChangeM_Up<-TempResultsJoined_ResultK[TempResultsJoined_ResultK[,m]>0,]
            write.csv(TempResultsJoined_ResultK_FoldChangeM_Up, paste(colnames(TempResultsJoined)[k], "_10_w_", colnames(TempResultsJoined)[m], "_Up.csv", sep=""))
            
            if(nrow(TempResultsJoined_ResultK_FoldChangeM_Up)>999){
              TempResultsJoined_ResultK_FoldChangeM_Up_Reordered<-TempResultsJoined_ResultK_FoldChangeM_Up[order(TempResultsJoined_ResultK_FoldChangeM_Up[,m], decreasing=TRUE),]
              TempResultsJoined_ResultK_FoldChangeM_Up<-TempResultsJoined_ResultK_FoldChangeM_Up_Reordered[c(1:999),]}else{}
            
            TempResultsJoined_ResultK_FoldChangeM_Up_Symbols<-unique(TempResultsJoined_ResultK_FoldChangeM_Up$Gene_Symbol)
            
            write.csv(TempResultsJoined_ResultK_FoldChangeM_Up_Symbols, paste(colnames(TempResultsJoined)[k], "_10_w_", colnames(TempResultsJoined)[m], "_Up_UniqueSymbols.csv", sep=""))
            
            
            TempResultsJoined_ResultK_FoldChangeM_UpDF<-data.frame(Dataset_Name=Dataset_Name, Factor_Contrast=TempContrast, Direction="Up", Taxon=Dataset_Annotation$taxon, GeneSetSize=length(TempResultsJoined_ResultK_FoldChangeM_Up_Symbols), GeneSet=toString(TempResultsJoined_ResultK_FoldChangeM_Up_Symbols))
            
            HC_GeneSets_Temp<-rbind.data.frame(HC_GeneSets_Temp, TempResultsJoined_ResultK_FoldChangeM_UpDF)
            
            rm(TempResultsJoined_ResultK_FoldChangeM_Up, TempResultsJoined_ResultK_FoldChangeM_Up_Symbols, TempResultsJoined_ResultK_FoldChangeM_UpDF)
            
          }else{}
        }
      }else{}
      
    }
    
    rm(TempResultsJoined, TempIndicesForQValueColumns)
  }else{}
}

dim(HC_GeneSets_Temp)
#[1] 570   6
head(HC_GeneSets_Temp)
#It worked bwa ha ha ha

setwd("~/Documents/SideProjects/BrainGMT/Gemma")

write.table(HC_GeneSets_Temp, "HC_GeneSets_Temp.txt")