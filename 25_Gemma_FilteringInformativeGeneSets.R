#Now we need to cut out all of the less informative gene sets (and/or more likely to be confounded comparisons):

grep("organism_part", HC_GeneSets_Temp$Factor_Contrast)
grep("sex", HC_GeneSets_Temp$Factor_Contrast)
grep("developmental_stage", HC_GeneSets_Temp$Factor_Contrast)

HC_GeneSets_Temp_Informative<-HC_GeneSets_Temp[-c(grep("organism_part", HC_GeneSets_Temp$Factor_Contrast), grep("sex", HC_GeneSets_Temp$Factor_Contrast), grep("developmental_stage", HC_GeneSets_Temp$Factor_Contrast)),]

dim(HC_GeneSets_Temp_Informative)
#[1] 469   6

sum(HC_GeneSets_Temp_Informative$GeneSetSize<1)
#[1] 0

sum(HC_GeneSets_Temp_Informative$GeneSetSize<10)
#[1] 128

write.table(HC_GeneSets_Temp_Informative, "HC_GeneSets_Temp_Informative.txt")

#Hmm... I just found another bug: Any time I have a folder with more than one AnalysisResults (e.g., GSE113796) it only parses by the q-values in the first file.
#Doesn't seem like this happened though.


###hmmmm.... I suppose I could compile the gene sets into one document and delete out the ones that we don't want too.
###I think I'll add that one in next time around - for now, I'd like to take a look and see how things went.


#28
#"13263_GSE86392_diffExpAnalysis_105657"
#all gene symbols are NAs (??!!!) - should probably note this on Gemma. Looks like the annotation just didn't output fully.
#Same with 65
#[1] "17271_GSE140598_diffExpAnalysis_167383"
#And 69:
#"17355_GSE140595_diffExpAnalysis_167639"



#Other steps left to do:
#1. If the results for the individual contrasts are much different from the overall ANOVA, consider making gene sets for both.
#3. Deal with "date genes"
#4. Count duplicates, and for any genes with duplicates showing the same direction of effect, choose the most extreme value. - I'll save dealing with this for once we are figuring out GeneWeaver.
#7. Output the final gene set sizes.


#Questions for Paul:
#1: Are they taking into account the multi-level nature of the data from multiple organism parts? (says ANOVA)
#2: Why do the contrast p-values for factors with only 2 levels not match the ANOVA output?
#3: How do we interpret the contrast output for models with interaction terms?  (main effect vs. effect within reference group?)
