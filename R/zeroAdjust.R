#' Zero adjust. Useful with apply functions.
#'
#'
#'
#' @param x numeric vector
#' @param r range of samples to calculate mean from
#'
#' @export zeroAdjust
#' @examples
#' x = dfs_ABF(field$ABF)[[1]][[1]]
#' x = zeroAdjust(x)
zeroAdjust <- function(x, r = 1:1000) {

    zA <- mean(x[r])
    x <- x - zA

    return(x)

}
