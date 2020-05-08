#' Isolate relevant columns from wash in sweeps if relevant
#'
#' @param x data in the form of
#' @param BlR Baseline range - defaults to 80
#' @param Wsh Wash region - defaults to 0
#' @return List of sweeps that represent the numeric representations of either the baseline or wash in
#' @importFrom utils tail
#' @examples
#' \dontrun{
#' x = IsolateWsh()
#' }
#'@export IsolateWsh
IsolateWsh <- function(x, Wsh = 0){

    BlR = ncol(x)

    WshR <- tail(1:ncol(x), Wsh)
    BlnR <- tail(1:ncol(x), (BlR+Wsh))

diff0 <- setdiff(BlnR, WshR)

Sweeps <- list("Sweeps" = diff0, "WshSweeps" = WshR)

return(Sweeps)

}


