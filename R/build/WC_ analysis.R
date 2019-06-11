lf <-
    list.files(
        "dir/wc_slices",
        pattern = ".rda",
        recursive = TRUE,
        full.names = TRUE
    )

load(lf[1])
wd <- wrkD(lf[1])
pro <- read.csv(list.files(wd, pattern = "Pro.csv", full.names = TRUE))




x[pro[4,"TestPulse"],]

pro <- wcA$Protocol
wcA$Metadata



i = 4
for(i in 1:length(wcA$Data)){
x <- wcA$Data[[i]]
p <- wcA$Protocol[i,]


tst <- as.numeric(str_split(p[7], ":", simplify = TRUE))[1]

TP <- x[tst[1]:tst[2],]





}










