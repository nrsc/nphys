#' Collect PP data
#'
#' @param x
#'
#' @return x
#' @export
PPexp <- function(x){

    PP <- list()
    x <- x[which(grepl("PP", names(x)) == TRUE)]
    PP$Pre <- x[which(grepl("Pre", names(x)) == TRUE)]
    PP$Post <- x[which(grepl("Post", names(x)) == TRUE)]

    #PrePPdt <- lapply(PrePPdt, baseline_adjust)
    #PostPPdt <- lapply(PostPPdt, baseline_adjust)

    return(PP)

}
