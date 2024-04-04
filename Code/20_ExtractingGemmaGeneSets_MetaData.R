#Code for extracting gene sets from Gemma and GeneWeaver from the Hippocampus and Nucleus Accumbens to create a better .GMT file
#Megan Hagenauer, June 2021

library(plyr)
library(httr)
library(RCurl)
library(jsonlite)

library(devtools)
install_github("PavlidisLab/gemmaAPI.R")
library(gemmaAPI)

?endpointFunctions
?highLevelFunctions
