#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return ndt_2
#' @export sAnalysis_maxSlope
#'
#' @examples
sAnalysis_maxSlope <- function(x){

    print("Maximum Slope")

    Bl0 <- sA$LTD$Baseline
    De0 <- sA$LTD$Decay
    dfC <- Bl0$dfCross

    p1 = dfC$Time[2]*100-1500
    p2 = dfC$Time[3]*100-1500
    pt1 = dfC$mV[2]
    pt2 = dfC$mV[3]
    d <- abs(pt2 - pt1)*-.1
    pt1 <- pt1 + d
    pt2 <- pt2 - 5*d

    pt1 <- head(which(Bl0$BlAvg$mV[p1:p2] < pt1)+p1, 1)
    pt2 <- tail(which(Bl0$BlAvg$mV[p1:p2] > pt2)+p1, 1)

    tp1 <- which(rownames(Bl0$blSlope) == Bl0$BlAvg[pt1,1])
    if(length(tp1) == 0){tp1 = 1}
    tp2 <- which(rownames(Bl0$blSlope) == Bl0$BlAvg[pt2,1])

    dtp_1 <- sapply(data.frame(Bl0$blSlope[,tail(1:(ncol(Bl0$blSlope)), 60)]), min)
    dtp_2 <- sapply(data.frame(De0$deSlope), min)
    ndt_2 <- c(dtp_1, head(dtp_2, 240))
    mn_2 <- mean(ndt_2[41:60])
    mLTD_2 <- mean(ndt_2[281:300])
    print(LTD_max <- mLTD_2/mn_2*100-100)

    return(ndt_2)

}

