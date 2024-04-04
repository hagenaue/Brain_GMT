#Trying to get GeneWeaver API to work:




#my API key is in this code - for public release I've replaced it with [MyAPIKey]

https://geneweaver.org/api/get/publication/byid/[MyAPIKey]/26/
  
  https://geneweaver.org/api/get/geneset/bygenesetid/8/
  #Not found
  #adding geneset->genesets doesn't help
  
  https://geneweaver.org/api/get/geneset/bygenesetid/719/
  
  
  #More documentation:
  https://geneweaver.org/api/swagger.json

https://geneweaver.org/api/genesets/get/
  
  https://geneweaver.org/api/genesets/bygenesetid/8/
  #Nope
  
  https://geneweaver.org/api/genesets/get/bygenesetid/8/
  
  https://geneweaver.org/api/genesets/8
#This brings me to the results management page (??) - changing out the number for other numbers does the same...


#Trying things out now that the api is supposedly fixed...



#This one seems to work (it pulls up metadata for the gene set,  not the gene set itself):  

#Get Gene Set by Gene Set ID: This call returns all information about a specified gene set given that gene set ID.
#/api/get/geneset/byid/<GeneSetID>/
#Sample Call: https://geneweaver.org/api/get/geneset/byid/220592/
#my attempt - using Gene set id for EtOH Preference Nucleus accumbens:
https://geneweaver.org/api/get/geneset/byid/719/
  #seems to work in chrome - but doesn't include pubmed id :(
  
  #It says the associated publication is pub_id: 26, so let's try feeding that into:
  
  #Get Publication by Publication ID: Returns all the publication data for given publication ID.
  
  #/api/get/publication/byid/<apikey>/<PublicationID>/
  #Sample Call: https://geneweaver.org/api/get/publication/byid/Fw7J4GeAXE8CMVvLTKyrtBDk/26/
  
  https://geneweaver.org/api/get/publication/byid/[MyAPIKey]/26/
  
  #Includes full publication citation information including:
  "pub_year": "2007"
"pub_pubmed": "17451403"

#Crazy thought: since these pub_ids seem internally generated, can I just loop up through them until they stop?

https://geneweaver.org/api/get/publication/byid/[MyAPIKey]/1/ #empty
  https://geneweaver.org/api/get/publication/byid/[MyAPIKey]/2/ #for gene set without publication?
  https://geneweaver.org/api/get/publication/byid/[MyAPIKey]/3/
  #It seems like everything above 8470 (up until around 100,000) is scrap or GO Ontology
  
  #Can I adapt the API to get the geneset id from the publications? (are all publications paired with a geneset?)
  
  
  
  
  #Get Geneset by Geneset ID: This call returns all the information about a given geneset given its geneset ID
  #/api/get/geneset/bygenesetid/<GeneSetID>/
  Sample Call: https://geneweaver.org/api/get/geneset/bygenesetid/8/
  #This sample call doesn't work 
  
  #Get Genes by Gene Set ID: This call returns all genes belonging to a given gene set.
  /api/get/genes/bygenesetid/<GeneSetID>/
  /api/get/genes/bygenesetid/<GeneSetID>/
  https://geneweaver.org/api/get/genes/bygenesetid/220592/
  
  https://geneweaver.org/api/get/genes/bygenesetid/719/
  #The gene symbols seem to be in "ode_ref_id":
  #It looks like the genes displayed as part of the geneset are "ode_pref": true
  
  https://geneweaver.org/api/get/genes/bygenesetid/166586/
  #Same pattern
  
  #Get Projects by User: Returns all the projects that are owned by a given user.
  #/api/get/project/byuser/<apikey>/
  
  https://geneweaver.org/api/get/project/byuser/[MyAPIKey]/
  #Works... yess
  
  #So let's try pulling up the gene sets for those projects:
  
  #Nucleus Accumbens project:
  https://geneweaver.org/api/get/geneset/byprojectid/[MyAPIKey]/32017/
  #This brings me to the results management page (??) - changing out the number for other numbers does the same...
  
  https://geneweaver.org/api/get/geneset/fromproject/[MyAPIKey]/32017/
  
  
