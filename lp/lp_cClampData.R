lf <- list.files("exa/cClamp", pattern = ".rda", recursive = TRUE, full.names = TRUE)
load(lf[1])


for(l in lf){
    load(l)

    dfs <- rda$Data
    grep("CCinj", names(dfs[[1]]))

    #     nrow(dfs$ampB$`b-CCinj-5`$Imon2)
    #     ImonX <- dfs$ampB$`b-CCinj-5`$Imon2
    #
    #     I0 = rda$Data$ampB$`b-CCinj-5`$Imon2[2]
    #     V0 = rda$Data$ampB$`b-CCinj-5`$Vmon2[2]

    if(length(dfs)>1){
    lstd <- list()
    tst <- sapply(dfs, function(x){
    })




    #plot(dfs$ampA$`a-StCC-37`$Vmon1$Trace.1.37.3.Vmon1)


    }

    # lf <- list.files("exa/cClamp", pattern = ".rda", recursive = TRUE, full.names = TRUE)
    # for(l in lf){
    #     load(lf[3])
    #     dfs = rda$Data
    #     lapply(rda$Data, function(x)print(names(x)))
    #
    #
    #
    #
    #     str(V0)
    #
    #
    #
    # }



}
