lf <-
    mixedsort(list.files("exa",
                         pattern = "sA.rda",
                         recursive = TRUE,
                         full.names = TRUE
    ))

# lf2 <-
    # mixedsort(list.files("dir/f_Slices",
    #                      pattern = "dfactors.csv",
    #                      recursive = TRUE,
    #                      full.names = TRUE
    # ))

i = lf[2]
#for (i in lf[39:length(lf)])
    {
    print(which(lf == i))
    load(i)
    wd <- wrkD(i)

    {
        sAnalysis <-
            read.table(
                list.files(
                    wd,
                    pattern = "SliceMD.csv",
                    recursive = TRUE,
                    full.names = TRUE
                ),
                #row.names = 1,
                header = FALSE,
                sep = ",",
                stringsAsFactors = FALSE
            )
    }


    print(Slice <- sAnalysis[which(sAnalysis[1] == "Slice"), 2])
    Group <- sAnalysis[which(sAnalysis[1] == "Group"), 2]
    print(Comment <- sAnalysis[which(sAnalysis[1] == "Comment"), 2])
#
    # Data <- nphys::Import(Slice) %>% Data.Sort(.)
    # # #names(Data$Data) <- nphys::proRename(names(Data$Data))
    # sA$Data <- Data$Data
    # save(sA, file = i)

    dfeather <- sweep_feather(sA$Data)

    write_feather(dfeather, file.path(wd, paste0(Slice, "-d.feather")))
    dfC <- sA$LTD$Baseline$dfCross
    dfC$index <- dfC$Time*100-1500
    mVmax = dfC$mV[3]
    t_mVmax = dfC$Time[3]-dfC$Time[1]

    mVd <- data.frame(unlist(sapply(sA$Data, mVdrift)),stringsAsFactors = FALSE) %>%
        set_colnames("mVd") %>%
        set_rownames(gsub("-", ".", gsub("Section","Sweep", rownames(.)))) %>%
        rownames_to_column(var = "Sweep")

    dfactors <- data.frame(Sweep = names(dfeather), stringsAsFactors = FALSE) %>%
        full_join(., mVd, by = "Sweep")

    dfactors$stimAmin <- sapply(dfeather[1:dfC$index[1],], min)
    dfactors$FVmin <- sapply(dfeather[dfC$index[1]:dfC$index[2],], min)
    dfactors$indexFVmin <- sapply(dfeather[dfC$index[1]:dfC$index[2],], function(x){
        x0 <- which.min(x)
        x0 <- x0+dfC$index[1]
    })
    dfactors$EPSPmin <- sapply(dfeather[dfC$index[2]:(dfC$index[3]+150),], min)
    dfactors$indexEPSPmin <- sapply(dfeather[dfC$index[2]:(dfC$index[3]+150),], function(x){
        x0 <- which.min(x)
        x0 <- x0+dfC$index[2]
    })

    dfactors$slopeEPSP <- apply(dfeather[dfC$index[2]:(dfC$index[3]+150),], 2, function(x){
        x <- as.data.frame(x)
        dt <- lmSweep(x)
        return(dt)
        })


    Blsweeps <- which(grepl("PreC.Bl", dfactors$Sweep))
    dt1 <- as.numeric(dfactors$slopeEPSP[Blsweeps])
    dt2 <- dfactors$slopeEPSP[grep("Decay", dfactors$Sweep)]
    dtSw <- c(tail(dt1,60), head(dt2, 240))

    dtI <- LTDpchange(dtSw)
    print(dtI$LTD)
    LFS <- dtI$Sct %>% set_colnames(c("V1", "V2"))

    De_Sl <- tail(LFS, 10)
    De_Sl <- lm(V2~V1, data = De_Sl)[[1]][2]
    print(dtI$blCof[2])
    print(De_Sl)

    Bl_var <- var(head(LFS$V2, 15))
    #readline(prompt = "press enter for next")

    csvName <- gsub("-sA.rda", "-dfactors.csv", i)
    write.table(dfactors, file = csvName, sep = ",", row.names = FALSE, col.names = TRUE)

    sAnalysis <- rbind(sAnalysis, c("mVmax", mVmax))
    sAnalysis <- rbind(sAnalysis, c("t_mVmax", t_mVmax))
    sAnalysis <- rbind(sAnalysis, c("LTD", dtI$LTD))
    sAnalysis <- rbind(sAnalysis, c("Bl_slope", dtI$blCof[2]))
    sAnalysis <- rbind(sAnalysis, c("Bl_var", Bl_var))
    sAnalysis <- rbind(sAnalysis, c("De_Sl", De_Sl))
    sAnalysis <- rbind(sAnalysis, LFS)

    csvName <- gsub("-sA.rda", "-sAnalysisLFS.csv", i)
    write.table(sAnalysis, file = csvName, sep = ",", row.names = FALSE, col.names = FALSE)

}

#save(sA, file = i)

#
#
#     tst <- sAnalysis_LFS(sA)
#     dtI <- LTDpchange(tst)
#
#     LFS <- dtI$Sct %>% set_colnames(c("V1", "V2"))
#
#     BlVar <- var(LFS[1:15,2])
#
#     print(dtI$blCof[2])
#     #print(dtI$blCof[1])
#
#     KO <- select.list(c("Keep", "Omit"), title = "Keep or Omit?")
#
#

}

