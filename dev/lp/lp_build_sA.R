# Script to add dfeather and dfactor into sA
# in order to ensure working with one file
# Example script uses exa as example dir


l.rda <- list.files("exa", pattern = ".rda", recursive = TRUE, full.names = TRUE)
i = l.rda[1]
for(i in l.rda){
    load(i)
    wd = wrkD(i)
    sA$fthr <- feather::read_feather(list.files(wd, pattern = ".feather", recursive = TRUE, full.names = TRUE))
    sA$fctr <- read.table(list.files(wd, pattern = "dfactors.csv", recursive = TRUE, full.names = TRUE), sep = ",", header = TRUE)
    sA$files <- lapply(sA$files, function(x){
        r = fileD(x)
    })




    sA$wd = as.character(wd)
    #save(sA, file = i)
    }
