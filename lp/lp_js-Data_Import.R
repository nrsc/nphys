# This identifies the CSV file that is saved while doing an experiment. Generating the
# csv file requires UI and is generally the output of newSlice
library(readABF)
library(stringr)
l.csv <- list.files("dir/wc_slices", pattern = ".csv", recursive = TRUE, full.names = TRUE)
#i = l.csv[12]
for(i in l.csv){
print(i)
sA <- list()
sA$wd = wrkD(i)
sA$md <- as.data.frame(t(read.csv(i, row.names = 1)))
sA$files <- list.files(sA$wd, pattern = ".abf", full.names = TRUE)
sA$ABF <- lapply(sA$files, readABF)
colnames(sA$md) <- gsub("file.name", "StimFile", colnames(sA$md))
StimFile <- sA$files[which.min(file.info(sA$files)$size)]
sA$md$StimFile = fileD(StimFile)
names(sA$ABF) = abf_Data.sort(sA)
dfs <- dfs_ABF(sA$ABF)

# dfs <- lapply(sA$ABF, function(d){
#     df <- as.data.frame(d$data)
# })
sA$fthr = abf_feather(dfs)
print(unique(str_split(names(sA$fthr), "-", simplify = TRUE)[,1:2]))

#sA$fctr
print(gsub(".csv",".rda", i))
save(sA, file = gsub(".csv",".rda", i))

}
