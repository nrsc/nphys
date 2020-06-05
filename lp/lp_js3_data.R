library(readABF)

l.abf <- list.files("dir/js_slices", pattern = ".abf", recursive = TRUE, full.names = TRUE)
l.csv <- list.files("dir/js_slices", pattern = ".csv", recursive = TRUE, full.names = TRUE)

l.unq <- unlist(unique(lapply(l.abf, wrkD)))
l.unq2 <- unlist(unique(lapply(l.csv, wrkD)))
setdiff(l.unq, l.unq2)

i = l.csv[5]

for(i in l.csv){
wd = wrkD(i)


abfs <- list.files(wd, pattern = ".abf", full.names = TRUE)
md <- as.data.frame(t(read.csv(i, row.names = 1)))

Data <- lapply(abfs, readABF)

lapply(Data, function(x){
    dt <- x$data
    length(dt)
})


tst1 <- as.data.frame(tst1)


grep(tst1$file.name, l.abf)


}
