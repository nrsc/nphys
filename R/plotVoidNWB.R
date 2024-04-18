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
# plotVoidNWB = function(x, sweeps, plot = TRUE, return = TRUE){
#
#     sweep = nphys::extractNWB(x, sweeps = sweeps)
#     sweep = sweep$sweeps
#     df = data.frame(sweep, zoo::index(sweep))
#     names(df) = c("y","x")
#
#
#     gg = ggplot2::ggplot(df, aes(x, y)) +
#         ggplot2::geom_line() +
#         ggplot2::theme_void()
#
#     if (plot) {
#       base::plot(gg)
#     }
#
#     if (return) {
#       return(gg)
#     }
#
# }
