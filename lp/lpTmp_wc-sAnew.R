# DGDev loop template
#
library(readABF)
library(stringr)
library(nphys)
lf <- list.files("dir/wc_slices/", pattern = ".rda", recursive = TRUE, full.names = TRUE)

for(l in lf){
    load(l)
    print(sA$md)



}


