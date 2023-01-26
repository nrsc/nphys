#' Display figure of AP dV/dt
#'
#' @param x AP vector
#' @param rate sampling frequency
#'
#' @return
#' @export
#'
#' @examples
#'
#'  #AP = x
#' #sweep = hct$ffts$data_00029_AD0$sweep
#' # fp = hct$ffts$data_00029_AD0$peaks
#' # AP = sweep[fp[4,3],fp[4,4]]
#'
#'
#'
dvdt_mV = function(x, rate, plot = TRUE){


  #
  t = convertIndex(AP, fq = rate)
  tstVec = doremi::calculate.glla(time = t, signal = AP)


  plot(tstVec$dsignal, type = "l")

}
