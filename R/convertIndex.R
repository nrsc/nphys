#' Convert index into timescale by frequency
#'
#' @param x vector of length n
#' @param fq sampling frequency in seconds
#'
#' @return
#' @export
#'
#' @examples
convertIndex = function(x, fq){
  n = length(x)
  v = n/fq
  r = seq(0, v, length.out = n)
}
