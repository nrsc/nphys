#' Baseline analysis of EPSP
#'
#' @param x
#' @param Wsh Wash in sweeps
#'
#' @return x
#' @export
sAnalysis_0 <- function(x, Wsh){

x <- Import(x)

x <- Data.Sort(tst0)

x$LTD <- LTDexp(x$Data)

x$PP <- PPexp(x$Data)

x$IO <- IOexp(x$Data)

return(x)

}
