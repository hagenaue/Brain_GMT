#NACC - figuring out what differential expression results are available on Gemma:

setGemmaUser(username="hagenaue", password=[DeletedForPublicRelease]) 

httr::set_config(config(ssl_verifypeer = 0L))
# This code prevents this curl error from occurring with some of Gemma's API functions: 
# Error in curl::curl_fetch_memory(url, handle = handle) : 
# SSL certificate problem: unable to get local issuer certificate

NACC_Annotation<-annotationInfo(annotation='nucleus accumbens', request='datasets')

length(names(NACC_Annotation))
#[1] 103

NACC_Annotation_AsDF<-data.frame(t(sapply(NACC_Annotation,c)))

dim(NACC_Annotation_AsDF)
#[1] 103  36

head(NACC_Annotation_AsDF)

NACC_Annotation_AsDF$accession[sapply(NACC_Annotation_AsDF$accession, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$accession))

length(unlist(NACC_Annotation_AsDF$taxon))
NACC_Annotation_AsDF$taxon[sapply(NACC_Annotation_AsDF$taxon, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$taxon))

length(unlist(NACC_Annotation_AsDF$batchConfound))
NACC_Annotation_AsDF$batchConfound[sapply(NACC_Annotation_AsDF$batchConfound, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$batchConfound))

length(unlist(NACC_Annotation_AsDF$$batchEffect))
NACC_Annotation_AsDF$batchEffect[sapply(NACC_Annotation_AsDF$batchEffect, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$batchEffect))

length(unlist(NACC_Annotation_AsDF$bioMaterialCount))
NACC_Annotation_AsDF$bioMaterialCount[sapply(NACC_Annotation_AsDF$bioMaterialCount, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$bioMaterialCount))

length(unlist(NACC_Annotation_AsDF$processedExpressionVectorCount))
NACC_Annotation_AsDF$processedExpressionVectorCount[sapply(NACC_Annotation_AsDF$processedExpressionVectorCount, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$processedExpressionVectorCount))

length(unlist(NACC_Annotation_AsDF$isPublic))
NACC_Annotation_AsDF$isPublic[sapply(NACC_Annotation_AsDF$isPublic, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$isPublic))

length(unlist(NACC_Annotation_AsDF$name))
NACC_Annotation_AsDF$name[sapply(NACC_Annotation_AsDF$name, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$name))

length(unlist(NACC_Annotation_AsDF$technologyType))
NACC_Annotation_AsDF$technologyType[sapply(NACC_Annotation_AsDF$technologyType, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$technologyType))

length(unlist(NACC_Annotation_AsDF$troubled))
NACC_Annotation_AsDF$troubled[sapply(NACC_Annotation_AsDF$troubled, is.null)] <- NA
length(unlist(NACC_Annotation_AsDF$troubled))

NACC_Annotation_AsDF_Simpler<-cbind.data.frame(unlist(NACC_Annotation_AsDF$shortName), unlist(NACC_Annotation_AsDF$accession), unlist(NACC_Annotation_AsDF$name), unlist(NACC_Annotation_AsDF$isPublic), unlist(NACC_Annotation_AsDF$technologyType),  unlist(NACC_Annotation_AsDF$taxon), unlist(NACC_Annotation_AsDF$batchConfound), unlist(NACC_Annotation_AsDF$batchEffect), unlist(NACC_Annotation_AsDF$bioMaterialCount), unlist(NACC_Annotation_AsDF$processedExpressionVectorCount), unlist(NACC_Annotation_AsDF$troubled), stringsAsFactors=FALSE)

str(NACC_Annotation_AsDF_Simpler)

#let's rename those columns (although I'm sure there is a better way to do this...)
colnames(NACC_Annotation_AsDF_Simpler)<-c("shortName", "accession", "name", "isPublic", "technologyType", "taxon", "batchConfound", "batchEffect", "bioMaterialCount", "processedExpressionVectorCount","troubled")

#Maybe we should trim it down to what we are most likely to use before moving further:
#double checking basic exclusion criteria:

table(NACC_Annotation_AsDF_Simpler$isPublic)
# TRUE 
# 103 

table(NACC_Annotation_AsDF_Simpler$troubled)
# FALSE 
# 103 

table(NACC_Annotation_AsDF_Simpler$taxon)
# human mouse rat 
# 8    67    28

#How about more complicated criteria?
table(NACC_Annotation_AsDF_Simpler$batchConfound)
#It looks like this may need to be navigated on a case-by-case basis - most of the confounds are factor-specific, and especially show up in relationship to organism part, tissue, sex, and time point.  (although some are clearly more relevant to our questions)

table(NACC_Annotation_AsDF_Simpler$technologyType)
# GENELIST ONECOLOR TWOCOLOR 
# 43       59        1
#Gene list means RNA-Seq, so about half of these are RNA-Seq studies.

setwd("~/Documents/SideProjects/BrainGMT/Gemma")
write.csv(NACC_Annotation_AsDF_Simpler, "NACC_Annotation_AsDF_Simpler.csv")

