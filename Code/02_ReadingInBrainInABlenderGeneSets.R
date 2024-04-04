#################
#reading in Brain In A Blender Cell Type database:

BrainInABlenderDatabase<-read.csv("BrainInABlenderDatabase_DateGenesFixed.csv", header=TRUE, stringsAsFactors = FALSE)
str(BrainInABlenderDatabase)

BrainInABlenderDatabase_Human<-BrainInABlenderDatabase[BrainInABlenderDatabase$Species=="Human",]
BrainInABlenderDatabase_Mouse<-BrainInABlenderDatabase[BrainInABlenderDatabase$Species=="Mice",]

#It occurs to me that I should probably make a better ortholog version of our original cell type marker database too:

Zeisel_CA1PyramidalIndex<-read.csv("Zeisel CA1 Pyramidal Index.csv", header=TRUE, stringsAsFactors=FALSE)
str(Zeisel_CA1PyramidalIndex)
#'data.frame':	409 obs. of  1 variable:
#$ Zeisel.CA1.Pyramidal.Index: chr  "0610010B08RIK_LOC4" "1500015A07RIK" "2610018G03RIK" "4831440E17RIK" ...
