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
#'  #sweep = nphys::data$AP
#'  #rate = 50000
#'
#'
#'
#'
dvdt_mV = function(x,
                   rate,
                   plot = TRUE,
                   return = FALSE) {

    if (missing(rate)) {
        stop("Error: rate must be set")
    }

    t = convertIndex(x, fq = rate)
    tstVec = doremi::calculate.glla(time = t, signal = x)


    if (plot) {
        plot(
            tstVec$dsignal,
            type = "l",
            ylab = "dV/dt",
            xlab = "mV"
        )
    }

    if (return) {
        return(tstVec)
    }


}
