#' Function for applying a FFT to a dataframe of segments
#'
#' @param x hct$ffts$[trace]$APsweeps or hct$ffts$[trace]$APsweeps[,APn]
#' @param p0 head of trace point to remove from fft analysis
#' @param lower lower bound of fft analysis
#' @param upper upper bound of fft analysis
#' @param melt determines whether melted dataframe or datavector is returned
#'
#' @return returns the fqMelt or datavector depending on melt variable in function
#' @export
#'
#' @examples
#'
#' x = seg01
#'
segmentFFT = function(x,
                      p0,
                      pN,
                      rate,
                      lower = 1,
                      upper = 1000,
                      melt = TRUE) {
  if (missing(p0)) {
    p0 = 1
  }

  if (missing(rate)) {
    rate = 50000
  }


  # Can run analysis if is just a single numeric vector
  if (is.numeric(x)) {
    # Remove NA
    x = x[!is.na(x)]

    if (missing(pN)) {
      pN = length(x)
    }
    # Select from p0 to end of trace
    x = x[p0:pN]

    ## Check that signal is even.
    if (!schoolmath::is.even(length(x)))
      x = x[1:(length(x) - 1)]


    dVec = eegkit::eegfft(x,
                          Fs = rate,
                          lower = lower,
                          upper = upper)

  } else{
    dVec = apply(x, 2, function(d) {
      # Remove NA
      d = d[!is.na(d)]

      # Select from p0 to end of trace
      d = d[p0:length(d)]

      ## Check that signal is even.
      if (!schoolmath::is.even(length(d)))
        d = d[1:(length(d) - 1)]

      d = eegkit::eegfft(d,
                         Fs = rate,
                         lower = lower,
                         upper = upper)
      return(d)
    })

  }

  if (melt) {
    qMelt = reshape2::melt(dVec, id.vars = c("frequency", "strength", "phase.shift"))
    return(qMelt)
  } else{
    return(dVec)
  }




}
