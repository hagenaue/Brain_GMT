# Overview of Brain.GMT:

This repository contains the public release of our curated brain-related functional gene set file (Brain.GMT) and associated code to accompany the publication:

"Resource: A Curated Database of Brain-Related Functional Gene Sets (Brain.GMT)"
by Megan H. Hagenauer1*, Yusra Sannah, Elaine K. Hebda-Bauer, Cosette Rhoads, Angela M. O’Connor, Stanley J. Watson, Jr., Huda Akil

## Gene Set database (.GMT) files:
* .GMT files are located in the main directory.
* There are separate versions of the .GMT files that use official gene symbols for Rats, Mice, and Humans.
* For each species, there is a .GMT that strictly contains the brain-related gene sets (Brain.GMT), and a second .GMT that contains both the gene sets from Brain.GMT and from a traditional gene ontology database (MSigDB: C5).

## Example Usage:
* The code file "BrainGMT_exampleUsage.R" provides an example of how to use Brain.GMT within a Gene Set Enrichment Analysis using the fGSEA code package.

## Other Code files:
* All of the R code used to create the gene set database has been released.
* The code files are numbered based on the sequence that they were run.

## Gene Ortholog files:
* These files were used to translate the gene identifiers from the species from which the gene set was generated (mice, rats, or humans) to the orthologous official gene symbols used for each species-specific gene set database file (mice, rats, humans).






 
