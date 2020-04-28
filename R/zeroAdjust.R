#' Zero adjust.
#'
#' Used with apply functions accross columns.
#' Calculation done on each sweep as a vector.
#'
#'
#'
#' @param x numeric vector
#' @param r range of samples to calculate mean from
#'
#' @export zeroAdjust
#' @examples
#' \dontrun{
#' Using the example dataset 'field'
#' dfs_ABF(field$ABF)[[1]][[1]] %>% zeroAdjust()
#'
#' }
zeroAdjust <- function(x, r = 1:1000) {

    zA <- mean(x[r])
    x <- x - zA

    return(x)

}
