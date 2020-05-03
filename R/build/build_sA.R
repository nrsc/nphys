#' Title
#'
#' @param x
#'
#' @return
#' @export
#build_sA <- function(x, Wsh = 0){
    if(missing(x)){
        x = "field"
        }
    x0 = Import(x) %>%
        Data.Sort()
    #x0 <- x
    #x = x0
    dfeather <- sweep_feather(x0$Data)
    write_feather(dfeather, file.path(x0$wd, paste0(x0$Metadata$Slice, "-d.feather")))
    dfeather <- read_feather("./exa/field/field-d.feather")
    dfactors <- read.csv("./exa/field/field-dfactors.csv")

    #dfeather <- as.data.frame(dfeather)
    ms <- x0$Data[[1]][1:length(rownames(dfeather)),1]
    rownames(dfeather) <- ms
    dfeather <- imp$dfeather
    mVd <- data.frame(unlist(lapply(x$Data, mVdrift)),stringsAsFactors = FALSE) %>%
        set_colnames("mVd") %>%
        set_rownames(gsub("-", ".", gsub("Section","Sweep", rownames(.))))

    dfactors <- data.frame(Sweep = names(dfeather), stringsAsFactors = FALSE) %>%
        full_join(., mVd, by = "Sweep")
        #which(is.na(dfactors$mVd)==TRUE)

    LTD <- LTDexp(dfeather)
    Baseline <- Bl_Analysis(LTD$Baseline)
    dfC <- Baseline$dfC
    dfC_rows <- dfC$ms*100

dfactors <- read.csv("./exa/field/field-dfactors.csv")


    #LTD2 <- LTDexp2(dfeather)
    fit <- stats::loess(mV~ms,data = avg)

    num <- LTD$Baseline$PreC.Bl_3.Sweep.0...mV.
    num1 <- approx(num, n = length(num)/10)

    plot(num1$y)

    tst0 <- approdfCx(num, n = 150)

    tst0 <- lmSweep(LTD2$Baseline$EPSP)
    plot(tst0)

    tst1 <- as.data.frame(tst0) %>% rownames_to_column(var = "Sweep")

    dfactors <- full_join(dfactors, tst1, by = "Sweep")

    stimA <- dfeather[1:which(rownames(dfeather) == dfC[1,1]),]
    FV <- dfeather[which(rownames(dfeather) == dfC[1,1]):which(rownames(dfeather) == dfC[2,1]),]
    EPSP <- dfeather[which(rownames(dfeather) == dfC[2,1]):which(rownames(dfeather) == dfC[3,1]),]
    EPSPdecay = dfeather[which(rownames(dfeather) == dfC$ms[3]):length(rownames(dfeather)),]



    dfactors$msFVmin <- sapply(FV, function(x){
     x0 <- which.min(x)
     rownames(FV)[x0]
    })

    tst0 <- round(mean(as.numeric(dfactors$msFVmin[1:10])),2)
    t0max <- which

    tst0 <- sapply(dfactors$msFVmin, function(x) which(rownames(dfeather) == x))

    rownames(dfeather)[304]

    #dfactors$EPSPmax <- sapply(EPSP, min)

    fvEPSP <- union(FV, EPSP)
    num <- fvEPSP[[6]]



    #findpeaks(num)
    plot(num)
    points(x = 52, y = num[52], col = "red")
    lines(fvEPSP[[25]])
    points(x = 350, y = num[350], col = "red")




    BlAvg <- Slope.Read(LTD$BlAvg$mV)

    exPSP_slope <- sapply(exPSP, slopeRead)

    #exPSP_slope <- apply(exPSP, 2, slpRead)

    hist(BlAvg, freq = FALSE)



    hist(x = d$x, y = d$y,)

    x[which(diff(sign(diff(y)))==-10)]




    PP <- PPexp(dfeather)
    IO <- IOexp(dfeather)







    Baseline <- BlAnalysis_0(LTD$Baseline, Wsh = 0)


    x$LTD$Decay <- DeAnalysis_0(x$LTD$Decay, dfC = x$LTD$Baseline$dfCross)

    return(x)

#}
