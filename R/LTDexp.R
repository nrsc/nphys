#' Collect LTD Data
#'
#' @param x
#'
#' @return r0
#' @export
LTDexp <- function(x){

    r0 <- list()

    r0$Baseline <- cbind.data.frame(x[grep("PreC.Bl", names(x))])

    r0$Cond <- cbind.data.frame(x[grep("Cond", names(x))])

    r0$Decay <- cbind.data.frame(x[grep("Decay", names(x))])

    return(r0)

}

#tst <- LTDexp(x$Data)
