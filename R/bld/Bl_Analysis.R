#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#' @param SA postition of the SA
#'
#' @return x
#' @export
Bl_Analysis <- function(x, Wsh = 0, out){

    data = x

    Bl <- list()

    BlAvg = Avg_Sweeps(data, Wsh = Wsh)
    dfC = identify_points(BlAvg)
    fvEPSP = data[which(rownames(data) == dfC$ms[1]):(which(rownames(data) == dfC$ms[3])+100),]
    EPSPdecay = data[which(rownames(data) == dfC$ms[3]):length(rownames(data)),]

    Bl$dfC <- dfC

    Bl$BlAvg <- BlAvg

    Bl$fvEPSP <- fvEPSP

    #Bl$EPSP <- data.matrix(EPSP)

    Bl$EPSPdecay <- data.matrix(EPSPdecay)

    return(Bl)

}


