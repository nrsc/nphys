#' Normalize a vector
#'
#' @param x
#'
#' @return
#' @export normalize
#'
#' @examples
normalize <- function(x)
{
  return((x- min(x)) /(max(x)-min(x)))
}
