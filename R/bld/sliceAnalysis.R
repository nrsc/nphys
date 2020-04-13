lf <-
    mixedsort(list.files(
        "dir",
        pattern = "sA.rda",
        recursive = TRUE,
        full.names = TRUE))
i = lf[13]
for (i in lf[1:length(lf)]){
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
                row.names = 1,
                header = FALSE,
                sep = ",",
                stringsAsFactors = FALSE
            )

        sAnalysis <- data.frame(t(sAnalysis))

        Slice <- as.character(sAnalysis$Slice)
        Group <- as.character(sAnalysis$Group)
        Comment <- as.character(sAnalysis$Comment)
        print(Slice)
    }

    # load(list.files(
    #     wd,
    #     pattern = "sData.rda",
    #     recursive = TRUE,
    #     full.names = TRUE
    # ))
    #
    # load(list.files(
    #     wd,
    #     pattern = "sAna.rda",
    #     recursive = TRUE,
    #     full.names = TRUE
    # ))



m1 = sA$sAnalysis$m1
m2 = sA$sAnalysis$m2
m3 = sA$sAnalysis$m3
m4 = sA$sAnalysis$m4



x = sData
    LTD <- LTDexp(x$Data)
    PP <- PPexp(x$Data)
    IO <- IOexp(x$Data)

    Bl0 <- Bl_Analysis(LTD$Baseline, out = dfC)
    Bl0$blSlope <- blSlope

    De0 <- De_Analysis(LTD$Decay, dfC = dfC)
    De0$deSlope <- deSlope

sA$LTD$Baseline <- Bl0
sA$LTD$Decay <- De0

sA$sAnalysis = sAna$sAnalysis

sA$sAnalysis$m4 = sA_LFS(sA, m = 1) %>% LTDpchange()






     readline(prompt = "Press Enter for next")
}

