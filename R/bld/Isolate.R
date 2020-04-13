#' Isolate Bl sweeps from wash in sweeps if relevant
#'
#' @param x data
#' @param BlR Baseline - defaults to 80
#' @param Wsh Wash region - defaults to 0
#'
#' @return Sweeps
#' @export
Isolate <- function(x, Wsh = 0, BlR = 80){

if(ncol(x) < BlR){
    x <- CreateColumns(x, BlR)
}

    WshR <- tail(1:ncol(x), Wsh)
    BlnR <- tail(1:ncol(x), (BlR+Wsh))

diff0 <- setdiff(BlnR, WshR)

Sweeps <- list("BlSweeps" = diff0, "WshSweeps" = WshR)

return(Sweeps)

}


