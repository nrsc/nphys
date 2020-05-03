#' Show LTD exp results -- to be used with the fctr dataframe
#'
#' @param x sA$fctr
#' @param LFS include the conditioning stimulus
#' @param StimHz = frequency in Hz
#'
#' @return Returns LTD figure
#' @export fctr_LTD
#'
#' @examples x = sA$fctr
fctr_ID <- function(x, ID = "slopeEPSP", LFS = TRUE, StimHz = 1){
    Bl = x[[ID]][grep("PreC.Bl",x$Sweep)]
    if(LFS == TRUE) {
        Cond = x[[ID]][grep("Cond",x$Sweep)]
        dStim = (StimHz/60)*length(Cond)
    }
    Decay = x[[ID]][grep("Decay", x$Sweep)]

    sA$Metadata$V1


    }
