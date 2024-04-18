#' Isolate action potential and subsequent interstimulus segment
#' removes NA values at the end that are residual from data frame
#' selects the region after the AHP
#'
#' @param x numeric vector.
#'
#' @return numeric vector with na removed and segmented from p0 to end of trace.
#'
#'
#' @export
# isolateSegment = function(x, p0, pN){
#
#   x = x[!is.na(x)]
#
#   if(missing(pN))
#     pN = length(x)
#
#   x = x[p0:pN]
#
#   if (!schoolmath::is.even(length(x))){
#       x = x[1:(length(x) - 1)]
#   }
#
#   return(x)
#
# }
