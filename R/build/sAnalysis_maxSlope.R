#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return ndt_2
#' @export sAnalysis_maxSlope
sAnalysis_maxSlope <- function(x){

    print("Maximum Slope")

    Bl0 <- sA$LTD$Baseline
    De0 <- sA$LTD$Decay
    dfC <- Bl0$dfCross

    dtp_1 <- sapply(data.frame(Bl0$blSlope[,tail(1:(ncol(Bl0$blSlope)), 60)]), min)
    dtp_2 <- sapply(data.frame(De0$deSlope), min)
    ndt_2 <- c(dtp_1, head(dtp_2, 240))
    mn_2 <- mean(ndt_2[41:60])
    mLTD_2 <- mean(ndt_2[281:300])
    print(LTD_max <- mLTD_2/mn_2*100-100)

    return(ndt_2)

}

