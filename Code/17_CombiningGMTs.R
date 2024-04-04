#Note:

#To make a brain cell type GMT, for each species (mouse, rat, human) I will need to combine together DropViz_HC, DropViz_STR, BrainInABlender, Zeisel, and any relevant cell types in C8, and regional patterns from CombinedHCspecific_mouse
#Some of these things may be easier to do in Excel (e.g., adding Zeisel and the Cembrowski HC regional gene sets - or maybe just save those for function?).

#Objects of interest for Brain Cell Type GMT:
DropViz_HC_Human_GMT, DropViz_STR_Human_GMT, BrainInABlender_Human_GMT, c8.all.v7.3.symbols_BrainRelevant, Zeisel_CA1PyramidalIndex_HumanOrthologs, CombinedHCspecific_Mouse_HumanOrtholog 

DropViz_HC_Rat_GMT, DropViz_STR_Rat_GMT, BrainInABlender_Rat_GMT, c8.all.v7.3.symbols_RatOrtholog_BrainRelevant, Zeisel_CA1PyramidalIndex_RatOrthologs, CombinedHCspecific_Mouse_RatOrtholog

DropViz_HC_Mouse_GMT,  DropViz_STR_Mouse_GMT, BrainInABlender_Mouse_GMT, c8.all.v7.3.symbols_MouseOrtholog_BrainRelevant, Zeisel_CA1PyramidalIndex, CombinedHCspecific_Mouse

#Notes about structure:
#The Dropviz and BrainInABlender based GMT files have the actual name as the row.names, no link. I wonder if my test-run with these in fgsea skipped the first two columns of data...
#C8 and CombinedHCSpecific: first 2 columns are the name and the link.
#CombinedHCSpecific: First 14 rows are Hipposeq
#Zeisel_CA1PyramidalIndex_HumanOrthologs needs editing - extra columns of crap.

#It seems like this might actually be easier to do in Excel. I just sorted all of the GMTs by species and am going to try messing around there.

#To make a brain function GMT, for each species (mouse, rat, human) I will need to combine together StressGeneSets, InternalizingBehaviorGeneSets, PsychiatricGeneSets, co-expression patterns from CombinedHCspecific_mouse and CombinedHCspecific_human, and any brain relevant datasets from C2.

#I tried combining them in Excel first



