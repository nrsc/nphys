#' Collect PP data
#'
#' @param x
#'
#' @return x
#' @export
IOexp <- function(x){
IO <- list()

    x <- x[which(grepl("IO", names(x)) == TRUE)]
    IO$Pre <- x[which(grepl("PreC", names(x)) == TRUE)]
    IO$Post <- x[which(grepl("PostC", names(x)) == TRUE)]


    return(IO)

}
