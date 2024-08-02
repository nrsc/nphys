#' Convert index into Seconds by frequency
#'
#' @param x vector of length n
#' @param fq sampling frequency in seconds
#'
#' @return vector
#'
#' @examples
#'
#' \dontrun{
#'
#' }
#'
#'
#' @export
convertIndex = function(x, fq) {

    # Length of vector
    n = length(x)

    # duration
    v = n / fq

    r = seq(0, v, length.out = n)
}
