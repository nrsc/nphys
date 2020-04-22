#' Pull specific sweeps from imported data
#'
#' @param x
#' @param pull Sweeps from the part of the experiment you want to pull
#' @param select logical
#' If TRUE, will prompt with options to select.
#' @param
#'
#' @return
#' @export
#'
#' @examples x = field$ABF
pullSweeps <- function(x, pull = "PreC-Bl", select = FALSE, zero = TRUE){

    if(select){
        pull = select.list(names(x))
        df <- dfs_ABF(x[grep(pull, names(x))]) %>% as.data.frame()
    }
    if(is.numeric(select)){
        pull = select
        df <- dfs_ABF(x[pull]) %>% as.data.frame()
    }
    # Default to select by pull
    if(!select){
        df <- dfs_ABF(x[grep(pull, names(x))]) %>% as.data.frame()
    }

    if(zero) df <- sapply(df, zeroAdjust) %>% as.data.frame()

    return(df)

}
