lf <- mixedsort(list.files("dir", pattern = "-sA.rda", recursive = TRUE,full.names = TRUE))
source("R/proSet.R")
#file.edit("R/proSet.R")
source("R/proRename.R")
x = lf[4]

lapply(lf, function(x){
load(x)
dtDir = wrkD(x)
md <- sA$Metadata
Slice = print(md[1,2])
fNames <- print(names(sA$Data))
atf <- list.files(dtDir, pattern = ".atf", full.names = TRUE, recursive = TRUE)
abf <- list.files(dtDir, pattern = ".abf", full.names = TRUE, recursive = TRUE)


if(fNames[1] != "PreC-IO_1"){

if(select.list(c("Yes", "No"), title = "Names correct") == "No"){
    stimFile = md[13,2]
    sF <- which(grepl(stimFile, abf) == TRUE)
    shell.exec(normalizePath(abf[sF]))
    fNames = proRename(fNames)
}
}

files <- lapply(abf, function(x)return(x)) %>% set_names(fNames)
names(sA$Data) <- fNames
save(sA, file = x)
sData <- list(Metadata = sA$Metadata,
              Data = sA$Data,
              files = files)

save(sData, file = file.path(dtDir, paste0(Slice, "-sData.rda")))


sAna <-
    list(
        Slice = Slice,
        Metadata = sA$Metadata,
        files = files,
        LTD = sA$LTD,
        PP = sA$PP,
        IO = sA$IO,
        sAnalysis = sA$sAnalysis
    )
save(sAna, file = file.path(dtDir, paste0(Slice, "-sAna.rda")))



})
