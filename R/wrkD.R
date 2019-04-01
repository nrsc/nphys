#' Directory that file sits in
#'
#' @param x
#'
#' @return wd
#' @export wrkD
#'
#' @examples "~/Projects/yourproj/file.xxx"
wrkD <- function(x, df = FALSE){

    wd <- data.frame(str_split(x, "/", simplify = TRUE))
    wd <- wd[,-ncol(wd)]
    wd <- data.frame(wd)
    wd <- apply(format(wd), 1, paste, collapse = "/")

    return(wd)
}
