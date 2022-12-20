#' Returns the last element of a path
#'
#' @param x a file path
#'
#' @return wd
#' @export fileD
fileD <- function(x){

    wd <- stringr::str_split(x, "/", simplify = TRUE)
    wd <- wd[length(wd)]

    return(wd)
}
