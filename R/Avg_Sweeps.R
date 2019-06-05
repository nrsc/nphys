#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#'
#' @return x
#' @export
Avg_Sweeps <- function(x, Wsh = 0, Sw = 20){

    Sweeps <- x %>%
        Isolate(Wsh = Wsh)

    BlAvg <- data.frame(rowMeans(x[,tail(Sweeps$BlSweeps, Sw)])) %>%
        set_colnames("mV") %>%
        add_column(ms = as.numeric(rownames(.)), .before = 1)

    return(BlAvg)

}


