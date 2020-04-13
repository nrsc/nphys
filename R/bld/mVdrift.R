#' Get voltage drift from 0 for sweeps
#'
#'
#' @param x Dataframe of sweeps
#' @param r range of samples to calculate Bl mean from
#'
#' @export
mVdrift <- function(x, r = 1:1000) {

    df = data.frame(x[,-grep("Time", colnames(x))])

    mV <- sapply(df[r,], mean)

    return(mV)

}
