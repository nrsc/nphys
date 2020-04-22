#' Get voltage drift from 0 for sweeps
#'
#'
#' @param x numeric vector
#' @param r range of samples to calculate mean from
#'
#' @export
zeroDrift <- function(x, r = 1:1000) {

    zD <- mean(x[r])

    return(zD)

}
