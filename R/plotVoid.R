#' Plot void trace
#'
#' @param x numerical: a vector
#' @param plot logical: show plot if TRUE
#' @param return logical: returns object if TRUE
#'
#' @examples
#'
#'
#'
#' @export
plotVoid = function(x, plot = TRUE, return = TRUE){


    df = data.frame(x, zoo::index(x))
    names(df) = c("y","x")

    gg = ggplot(df, aes(x, y)) +
      geom_line() +
      theme_void()

    if (plot) {
      base::plot(gg)
    }

    if (return) {
      return(gg)
    }

}
