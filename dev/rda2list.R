#' rda2list
#' returns an environment of rda files. BRILLIANT!
#' source: https://stackoverflow.com/a/51491261/9692835
#' @param file file to load
#'
#' @return
#' @export
#'
#' @examples
rda2list <- function(file) {
    e <- new.env()
    load(file, envir = e)
    as.list(e)
}
