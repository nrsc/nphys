LTDexp.Bl <- function(x){
        #x = dfeather

    r0 <- list()

    data = data.matrix(cbind.data.frame(x[grep("PreC.Bl", names(x))]))
    BlAvg = Avg_Sweeps(data)
    dfC = identify_points(BlAvg)
    stimA = data[1:which(rownames(data) == dfC$ms[1]),]
    FV = data[which(rownames(data) == dfC$ms[1]):which(rownames(data) == dfC$ms[2]),]
    EPSP = data[which(rownames(data) == dfC$ms[2]):which(rownames(data) == dfC$ms[3]),]
    EPSPdecay = data[which(rownames(data) == dfC$ms[3]):length(rownames(data)),]

r0$Baseline <- list(

    BlAvg = BlAvg,
    dfC = dfC,
    stimA = stimA,
    FV = FV,
    EPSP = EPSP,
    EPSPdecay = EPSPdecay



)

     r0$Cond <- cbind.data.frame(x[grep("Cond", names(x))])

     r0$Decay <- cbind.data.frame(x[grep("Decay", names(x))])
     #ui2 <- identify_points(r0$Decay)

    return(r0)

}

#tst <- LTDexp.2(dfeather)
