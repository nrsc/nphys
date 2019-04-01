#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return dtSw
#' @export sAnalysis_2060Sw
#'
#' @examples
sAnalysis_2060Sw <- function(x){

    print("Cursors at 20% and 60% of individual sweeps")

    Bl0 <- sA$LTD$Baseline
    De0 <- sA$LTD$Decay
    dfC <- Bl0$dfCross


dtS <- as.numeric(lmSweep(Bl0$EPSP[,tail(Bl0$Sweeps$BlSweeps, 60)]))
dt2S <- as.numeric(lmSweep(De0$EPSP))
dtSw <- c(dtS, head(dt2S, 240))
mnSw <- mean(dtSw[41:60])
mLTDSw <- mean(dtSw[281:300])
print(lmSw <- mLTDSw/mnSw*100-100)

    return(dtSw)
}

