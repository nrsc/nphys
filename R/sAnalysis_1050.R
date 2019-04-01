#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return ndt
#' @export sAnalysis_1050
#'
#' @examples
sAnalysis_1050 <- function(x){

    print("Cursors at 10% and 50% of Pre-Conditioning Baseline")

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


    dt <- as.numeric(lmROI(Bl0$EPSP[,tail(Bl0$Sweeps$BlSweeps, 60)], (pt1-p1), (pt2-p1)))
    dt2 <- as.numeric(lmROI(De0$EPSP, (pt1-p1), (pt2-p1)))
    ndt <- c(dt, head(dt2, 240))
    mn <- mean(ndt[41:60])
    mLTD <- mean(ndt[281:300])
    print(lmROI <- mLTD/mn*100-100)

    return(ndt)

}

