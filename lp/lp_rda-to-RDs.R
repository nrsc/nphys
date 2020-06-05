#' ## Converting rda to RDs for serialization into a data base.

#' Two packages we are using. The first is the ```RSQLite``` which will be used to create and manage an in-memory SQLite database. The second is ```igraph``` which I will use to create and visualize a random network. Some of the work I do is on network simulation. I often don't know the metrics I need from a simulated network when it's created, so I want to be able to store the networks that are created so that I can go back later and analyze them.
library(nphys)

#' Create a database in memory.
#dbDGDev <- dbConnect(SQLite(), ":memory:")

lf <- list.files("dir", pattern = "LTD.rda", full.names = TRUE,recursive = TRUE)
#db <- list()

l = lf[8]

for(l in lf[8:10]){
load(l)
DGDev$wd = wrkD(l)
DGDev$Slice = fileD(l, rm = TRUE)
DGDev$md$Slice = fileD(l, rm = TRUE)
DGDev$md$Group = gsub("/", "-", gsub("dir/", "", wrkD(DGDev$wd)))
print(DGDev$md)
write.csv(DGDev$md, file.path(DGDev$wd, paste0(DGDev$Slice, "MD.csv")),row.names = FALSE)
#DGDev = sA
dfs <- dfs_ABF(DGDev$ABF)


DGDev$fthr <- sapply(names(dfs),function(x){
    df = list()
    PP = ifelse(grepl("PP", x), 5000, FALSE)
    sweeps = dfs[[x]]
    df[[x]] = apply(sweeps, 2, function(f){
        f = fthrStim(f, PP = PP)
        })
    return(df)
})
DGDev$msInt = dfs_ABF(DGDev$ABF, int = "samplingIntervalInSec", returnList = FALSE)
DGDev$ABF = NULL

saveRDS(DGDev, file = gsub(".rda", ".RDs", l))

}
#
# df <- data.frame(a=lf[1:5],
#                  g = I(lapply(db, function(x){serialize(x, NULL)})))
#







#source("dev/R/params.R")
#names(db)


