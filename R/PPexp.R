#' Collect PP data
#'
#' @param x
#'
#' @return x
#' @export
PPexp <- function(x){

    PrePPdt <- which(grepl("PreC-PP", names(x)) == TRUE)
    PostPPdt <- which(grepl("PostC-PP", names(x)) == TRUE)

    PrePPdt <- x[PrePPdt]
    PostPPdt <- x[PostPPdt]

    PrePPdt <- lapply(PrePPdt, baseline_adjust)
    PostPPdt <- lapply(PostPPdt, baseline_adjust)

    x = list(PrePP = PrePPdt,
             PostPP = PostPPdt)


    return(x)

}
