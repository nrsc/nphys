#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#'
#' @return x
#' @export
Avg_Sweeps <- function(x, Sw = 20, Wsh = 0){

    if(Wsh != 0){
    Sweeps <- x %>%
        IsolateWsh(Wsh = Wsh)

    }

    Avg <- rowMeans(x[,tail(Sweeps$BlSweeps, Sw)])


    return(Avg)

}


