# DGDev loop template
#
library(readABF)
library(stringr)
library(nphys)
lfWC <- list.files("dir/wc_slices/", pattern = ".rda", recursive = TRUE, full.names = TRUE)

l = lfWC[grep("16o19.P4", lfWC)]

for(l in lfDGDev){
    load(l)
    print(DGDev$md)



}


