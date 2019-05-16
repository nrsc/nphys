#' Adjust Baseline
#'
#'
#' @param x Dataframe to be adjusted
#' @param r range of samples to calculate Bl mean from
#'
#' @export
bl_adjust <- function(x, r) {
    if (missing(r)) {
        r = 1:1000
    }

    df = x
    mV <- mean(df[r])
    df0 <- df - mV

    return(df0)

}
