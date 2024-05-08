#' Plot void trace from txt trace
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

    gg = ggplot2::ggplot(df, aes(x, y)) +
        ggplot2::geom_line() +
        ggplot2::theme_void()

    if (plot) {
      base::plot(gg)
    }

    if (return) {
      return(gg)
    }

}
