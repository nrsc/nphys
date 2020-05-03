lf <- list.files("exa/cClamp", pattern = ".rda", recursive = TRUE, full.names = TRUE)
for(l in lf){
    load(lf[3])
    dfs = rda$Data
    lapply(rda$Data, function(x)print(names(x)))


    nrow(dfs$ampB$`b-CCinj-5`$Imon2)
    ImonX <- dfs$ampB$`b-CCinj-5`$Imon2

    I0 = rda$Data$ampB$`b-CCinj-5`$Imon2[2]
    V0 = rda$Data$ampB$`b-CCinj-5`$Vmon2[2]


str(V0)



}
