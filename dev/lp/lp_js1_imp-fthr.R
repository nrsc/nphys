# This identifies the CSV file that is saved while doing an experiment. Generating the
# csv file requires UI and is generally the output of newSlice
lf <- list.files("dir/js_slices", pattern = ".csv", recursive = TRUE, full.names = TRUE)
l = lf[12]
for(l in l.csv){
print(l)
sA <- list()
sA$wd = wrkD(l)
sA$md <- as.data.frame(t(read.csv(i, row.names = 1)))
sA$files <- list.files(sA$wd, pattern = ".abf", full.names = TRUE)
sA$ABF <- lapply(sA$files, readABF)
colnames(sA$md) <- gsub("file.name", "StimFile", colnames(sA$md))
StimFile <- sA$files[which.min(file.info(sA$files)$size)]
sA$md$StimFile = fileD(StimFile)
names(sA$ABF) = abf_Data.sort(sA)
# This function generates the
dfs <- dfs_ABF(sA$ABF)


sA$fthr = abf_feather(dfs)
print(unique(str_split(names(sA$fthr), "-", simplify = TRUE)[,1:2]))

#sA$fctr
print(gsub(".csv",".rda", l))
#save(sA, file = gsub(".csv",".rda", i))

}
