#' Returns the directory that file sits in
#'
#' @param x
#'sea2
#' @return wd
#' @export fileD
fileD <- function(x, df = FALSE){

    wd <- data.frame(stringr::str_split(x, "/", simplify = TRUE))
    wd <- wd[,ncol(wd)]
    wd <- data.frame(wd)
    wd <- apply(format(wd), 1, paste, collapse = "/")

    return(wd)
}
