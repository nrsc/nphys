#' Average selected sweeps
#'
#' @param x Data imported from raw files
#' requi
#' @param obs utilizes nphys::dfs_ABF
#' select what data you want to draw from
#' @param nAvg
#' The number of sweeps selected for.
#' @param Wsh
#' If wsh is > 0, the function will ignore sweeps starting from the tail
#' @return
#' @export avgSweeps
#' @examples x = field$ABF
avgSweeps <- function(x, nAvg = 20, Wsh = 0){
    # Function IsolateWsh returns list(Sweeps, Wsh) as numeric identifiers.
    Sweeps <- df %>% IsolateWsh(Wsh = Wsh)
    # Row means of the identified columns.
    Avg <- rowMeans(df[,tail(Sweeps$Sweeps, nAvg)])
    return(Avg)
}


