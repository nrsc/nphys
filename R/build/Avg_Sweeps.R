#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param nAvg The number of sweeps to observe before
#' @param Wsh Wash region to ignore when getting BlAvg
#'
#' @return
#' @export
#' @examples x = field$ABF
avgSweeps <- function(x, obs = "PreC-Bl", nAvg = 20, Wsh = 0){

    df <- dfs_ABF(x[grep(obs, names(x))]) %>% as.data.frame()# %>%
    Sweeps <- df %>% IsolateWsh(Wsh = Wsh)
    Avg <- rowMeans(df[,tail(Sweeps$Sweeps, nAvg)])

    return(Avg)


}


