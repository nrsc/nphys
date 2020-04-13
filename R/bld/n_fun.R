#' n values in graph
#'
#' @param x data
#' @param nY y axis position
#'
#' @return dataframe
#' @export n_fun
#'
#' @examples
n_fun <- function(x, nY){
    if(missing(nY)){nY = -60}
    return(data.frame(y = nY, label = paste0("n= ",length(x))))
}
