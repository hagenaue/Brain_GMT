#Gemma: What HC Differential Expression Results are Available?

###########

setGemmaUser(username="hagenaue", password=[DeletedForPublicRelease]) 

httr::set_config(config(ssl_verifypeer = 0L))
# This code prevents this curl error from occurring with some of Gemma's API functions: 
# Error in curl::curl_fetch_memory(url, handle = handle) : 
# SSL certificate problem: unable to get local issuer certificate

HC_Annotation<-annotationInfo(annotation='hippocampus', request='datasets')

length(names(HC_Annotation))
#[1] 648

HC_Annotation_AsDF<-data.frame(t(sapply(HC_Annotation,c)))

dim(HC_Annotation_AsDF)
#[1] 648  36

head(HC_Annotation_AsDF)

HC_Annotation_AsDF$accession[sapply(HC_Annotation_AsDF$accession, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$accession))

length(unlist(HC_Annotation_AsDF$taxon))
HC_Annotation_AsDF$taxon[sapply(HC_Annotation_AsDF$taxon, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$taxon))

length(unlist(HC_Annotation_AsDF$batchConfound))
HC_Annotation_AsDF$batchConfound[sapply(HC_Annotation_AsDF$batchConfound, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$batchConfound))

length(unlist(HC_Annotation_AsDF$$batchEffect))
HC_Annotation_AsDF$batchEffect[sapply(HC_Annotation_AsDF$batchEffect, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$batchEffect))

length(unlist(HC_Annotation_AsDF$bioMaterialCount))
HC_Annotation_AsDF$bioMaterialCount[sapply(HC_Annotation_AsDF$bioMaterialCount, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$bioMaterialCount))

length(unlist(HC_Annotation_AsDF$processedExpressionVectorCount))
HC_Annotation_AsDF$processedExpressionVectorCount[sapply(HC_Annotation_AsDF$processedExpressionVectorCount, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$processedExpressionVectorCount))

length(unlist(HC_Annotation_AsDF$isPublic))
HC_Annotation_AsDF$isPublic[sapply(HC_Annotation_AsDF$isPublic, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$isPublic))

length(unlist(HC_Annotation_AsDF$name))
HC_Annotation_AsDF$name[sapply(HC_Annotation_AsDF$name, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$name))

length(unlist(HC_Annotation_AsDF$technologyType))
HC_Annotation_AsDF$technologyType[sapply(HC_Annotation_AsDF$technologyType, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$technologyType))

length(unlist(HC_Annotation_AsDF$troubled))
HC_Annotation_AsDF$troubled[sapply(HC_Annotation_AsDF$troubled, is.null)] <- NA
length(unlist(HC_Annotation_AsDF$troubled))

HC_Annotation_AsDF_Simpler<-cbind.data.frame(unlist(HC_Annotation_AsDF$shortName), unlist(HC_Annotation_AsDF$accession), unlist(HC_Annotation_AsDF$name), unlist(HC_Annotation_AsDF$isPublic), unlist(HC_Annotation_AsDF$technologyType),  unlist(HC_Annotation_AsDF$taxon), unlist(HC_Annotation_AsDF$batchConfound), unlist(HC_Annotation_AsDF$batchEffect), unlist(HC_Annotation_AsDF$bioMaterialCount), unlist(HC_Annotation_AsDF$processedExpressionVectorCount), unlist(HC_Annotation_AsDF$troubled), stringsAsFactors=FALSE)

str(HC_Annotation_AsDF_Simpler)
#'data.frame':	648 obs. of  11 variables:
#'
#let's rename those columns (although I'm sure there is a better way to do this...)
colnames(HC_Annotation_AsDF_Simpler)<-c("shortName", "accession", "name", "isPublic", "technologyType", "taxon", "batchConfound", "batchEffect", "bioMaterialCount", "processedExpressionVectorCount","troubled")

#Maybe we should trim it down to what we are most likely to use before moving further:
#double checking basic exclusion criteria:

table(HC_Annotation_AsDF_Simpler$isPublic)
# TRUE 
#648 

table(HC_Annotation_AsDF_Simpler$troubled)
# FALSE 
#648  

table(HC_Annotation_AsDF_Simpler$taxon)
# human mouse   rat 
# 44   460   143 

#How about more complicated criteria?
table(HC_Annotation_AsDF_Simpler$batchConfound)
#It looks like this may need to be navigated on a case-by-case basis - most of the confounds are factor-specific, and especially show up in relationship to organism part, tissue, sex, and time point.  (although some are clearly more relevant to our questions)

table(HC_Annotation_AsDF_Simpler$technologyType)
# DUALMODE GENELIST ONECOLOR TWOCOLOR 
# 13      254      371       10 
#Gene list means RNA-Seq, so about half of these are RNA-Seq studies.

setwd("~/Documents/SideProjects/BrainGMT/Gemma")
write.csv(HC_Annotation_AsDF_Simpler, "HC_Annotation_AsDF_Simpler.csv")
#Outputted 06-15-2021

