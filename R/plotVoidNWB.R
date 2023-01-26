#' Plot void trace pulled
#'
#' @param x
#' @param trace
#' @param plot
#' @param return
#'
#' @return
#' @export
#'
#' @examples
plotVoidNWB = function(x, trace, plot = TRUE, return = TRUE){

    sweep = nphys::extractNWB(x, trace)
    sweep = sweep$sweeps
    df = data.frame(sweep, zoo::index(sweep))
    names(df) = c("y","x")


    gg = ggplot(df, aes(x, y)) +
      geom_line() +
      theme_void()

    if (plot) {
      base::plot(gg)
    }

    if (return) {
      return(gg2)
    }

}
