#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return dtSw
#' @export
sA_LFS <- function(x, m = 1) {

    Bl0 <- x$LTD$Baseline
    De0 <- x$LTD$Decay
    dfC <- Bl0$dfCross


    if (m == 1) {
        dt1 <- as.numeric(lmSweep(Bl0$EPSP[, tail(Bl0$Sweeps$BlSweeps, 60)]))
        dt2 <- as.numeric(lmSweep(De0$EPSP))
    }

    if (m == 2) {
        p1 = dfC$Time[2] * 100 - 1500
        p2 = dfC$Time[3] * 100 - 1500
        pt1 = dfC$mV[2]
        pt2 = dfC$mV[3]
        d <- abs(pt2 - pt1) * -.1
        pt1 <- pt1 + d
        pt2 <- pt2 - 5 * d

        pt1 <- head(which(Bl0$BlAvg$mV[p1:p2] < pt1) + p1, 1)
        pt2 <- tail(which(Bl0$BlAvg$mV[p1:p2] > pt2) + p1, 1)

        dt1 <-
            as.numeric(lmROI(Bl0$EPSP[, tail(Bl0$Sweeps$BlSweeps, 60)], (pt1 - p1), (pt2 -
                                                                                         p1)))
        dt2 <- as.numeric(lmROI(De0$EPSP, (pt1 - p1), (pt2 - p1)))
    }


if(m == 3){
    dt1 <- sapply(data.frame(Bl0$blSlope[,tail(1:(ncol(Bl0$blSlope)), 60)]), min)
    dt2 <- sapply(data.frame(De0$deSlope), min)
}




dtSw <- c(dt1, head(dt2, 240))
mnSw <- mean(dtSw[41:60])
mLTDSw <- mean(dtSw[281:300])
print(lmSw <- mLTDSw/mnSw*100-100)

    return(dtSw)
}

