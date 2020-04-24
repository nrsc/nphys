#' Return directory that file is in
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
