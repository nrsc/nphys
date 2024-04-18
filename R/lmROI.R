#' Title
#'
#' @param x region of interest
#' @param p1 first point to investigate
#' @param p2 second point to investigate
#'
#' @return x
#' @export lmROI
#'
#' @examples
# lmROI <- function(x, y, p1, p2){
#
#     #x = t0
#
#     df = data.frame(x,y)[p1:(p2-1),]
#
#     plot(df)
#     abline(lm(y ~ x, data = df), col = "green")
# #
# #     plot(df)
# #     abline(lm(y ~ x))
# #
# #               lm(y ~ x, data = df)
#     return(x)
# }
