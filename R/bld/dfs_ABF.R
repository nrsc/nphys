#' Extract data from ABF as a list of dataframes
#'
#' @param x input is sA$ABF
#'
#' @return
#' @export
#'
#' @examples x = sA$ABF
dfs_ABF <- function(x){
    dfs <- lapply(x, function(d){
        df <- as.data.frame(d$data)
    })
    return(dfs)
}
