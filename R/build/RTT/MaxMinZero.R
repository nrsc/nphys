#' Find and return the max or min value of each trace.
#'
#' @param x vector of values
#'
#' @return
#' @export
#'
#' @examples
MaxMinZero <- function(x){
  xA = abs(x)
  xN = which.max(xA)
  return(x[xN])
}
