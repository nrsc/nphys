#' Remove the flag from the end of a datamark
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
rmFlag <- function(x, sep = "-"){

    s <- stringr::str_split(x, sep, simplify = TRUE)
    s = s[,-ncol(s)]

}
