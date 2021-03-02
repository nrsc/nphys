#' Remove the flag from the end of a datamark
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
rmFlag <- function(x){

    s <- stringr::str_split(x, "-", simplify = TRUE)
    s = s[,-ncol(s)]

}
