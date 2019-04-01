#' Find stim artifact for traces with single
#'
#' @param x numerical vector to be examined
#'
#' @return fp
#' @export stim.Artifact
#'
stim.Artifact <- function(x){

    #x$Slope <- na.fill(x$Slope, 0)
    xMax <- which.max(x$Slope)
    xMin <- which.min(x$Slope[1:xMax])
    fp <- c(xMax, xMin)
    return(fp)
}

