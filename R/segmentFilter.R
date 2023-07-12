#' Apply a filter to a segment length.
#'
#' @param x segment to be filtered
#' @param rate rate of acquisition
#' @param lower lower bound
#' @param upper uppper bound
#' @param plot Do you want to plot the figure.
#'
#' @return plot or vector
#'
#' @examples
#'
#'\dontrun{
#' x = seg01
#'}
#'
#' @export
segmentFilter = function(x,
                         rate,
                         lower = 1,
                         upper = 2000,
                         plot = FALSE,
                         return = FALSE) {
  if (x[1] != 0) {
    x = x - x[1]
  }

  f = eegfilter(x, Fs = rate, lower, upper, method = "butter", order = 1)


  if (plot) {
    x0 = convertIndex(f, fq = rate)
    df = data.frame(y = f, x = x0)

    gg0 = ggplot(df, aes(x, y)) +
      geom_line() +
      xlab("time (sec)") +
      ylab("mV deflection")

    gg1 = segmentFFT(f) %>% hctPlot_fft(., return = TRUE)

    aG = gridExtra::arrangeGrob(gg0, gg1, ncol = 2)

    if (return) {
      return(aG)
    }

  }

  if (return) {
    return(f)
  }

}
