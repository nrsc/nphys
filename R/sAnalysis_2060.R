#' Analysis with cursors at 10% and 50% of the observable EPSP
#'
#' @param x
#'
#' @return dtSw
#' @export
sA_LFS <- function(x, m = 1){

    Bl0 <- x$LTD$Baseline
    De0 <- x$LTD$Decay
    dfC <- Bl0$dfCross


if(m == 1){}
dt1 <- as.numeric(lmSweep(Bl0$EPSP[,tail(Bl0$Sweeps$BlSweeps, 60)]))
dt2 <- as.numeric(lmSweep(De0$EPSP))
if(m == 2){}




dtSw <- c(dt1, head(dt2, 240))
mnSw <- mean(dtSw[41:60])
mLTDSw <- mean(dtSw[281:300])
print(lmSw <- mLTDSw/mnSw*100-100)

    return(dtSw)
}

