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
isolateSegment = function(x, p0, pN, even = TRUE) {

  # p0 point represents the start of the segment
  if (missing(p0)) {
    p0 = 1
  }

  # Remove any NAs
  x = x[!is.na(x)]

  # Check to ensure that segment length is greater than p0
  if (length(x) < p0) {
    message("Length of segment is less than start point")
    return(NULL)
  }

  # pN point represents the end of the segment
  if (missing(pN)) {
    pN = length(x)
  }

  # Isolate region of interest
  x = x[p0:pN]

  if (even) {
    if (!schoolmath::is.even(length(x))) {
      x = x[1:(length(x) - 1)]
    }
  }

  return(x)

}
