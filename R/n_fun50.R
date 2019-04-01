#' n values in graph
#'
#' @param x data
#'
#' @return dataframe
#' @export n_fun50
#'
#' @examples
n_fun50 <- function(x){
    return(data.frame(y = -50, label = paste0("n= ",length(x))))
}
