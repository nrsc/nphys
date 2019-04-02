#' Collect LTD Data
#'
#' @param x
#'
#' @return r0
#' @export
LTDexp <- function(x){
    r0 <- list()

    r0$Baseline <- cbind.data.frame(x[grep("PreC-Bl", names(x))]) %>%
        slice(1:3000) %>%
        baseline_adjust()

    r0$Cond <- as.data.frame(x["Cond"]) %>%
        slice(1:3000) %>%
        baseline_adjust()

    r0$Decay <- as.data.frame(x["Decay"]) %>%
        slice(1:3000) %>%
        baseline_adjust()


    return(r0)

}

#tst <- LTDexp(x$Data)
