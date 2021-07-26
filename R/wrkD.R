#' Return file path without last path element.
#' @param x a path
#' @return wd
#' @examples
#' \dontrun{
#' wrkD("~/proj/yourproj/fi.le")
#' }
#' @export
wrkD <- function(x){

    wd <- data.frame(stringr::str_split(x, "/", simplify = TRUE))
    wd <- wd[,-ncol(wd)]
    wd <- data.frame(wd)
    wd <- apply(format(wd), 1, paste, collapse = "/")

    return(wd)
}
