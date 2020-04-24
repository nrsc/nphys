#' Click to identify points along a trace.
#'
#' @param x data.frame
#' @importFrom graphics plot
#' @importFrom graphics identify
#' @return x
#' @export
identify_points <- function(x){

    yMin <- min(x$mV[150:800])*1.5
    plot(mV ~ ms,data = x, type = "l", ylim = c(yMin,0.2))
    print("Pick identifiers")
    dfC <- x[identify(x$ms, x$mV, n = 3),]
    return(dfC)

}


