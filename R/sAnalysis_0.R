#' Baseline analysis of EPSP
#'
#' @param x
#' @param Wsh Wash in sweeps
#'
#' @return x
#' @export
sAnalysis_0 <- function(x){

x <- Import(x)

x <- Data.Sort(x)

return(x)

}
