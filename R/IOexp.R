#' Collect PP data
#'
#' @param x
#'
#' @return x
#' @export
IOexp <- function(x){

    PreIOdt <- which(grepl("PreC-IO", names(x)) == TRUE)
    PostIOdt <- which(grepl("PostC-IO", names(x)) == TRUE)

    PreIOdt <- x[PreIOdt]
    PostIOdt <- x[PostIOdt]

    PreIOdt <- lapply(PreIOdt, baseline_adjust)
    PostIOdt <- lapply(PostIOdt, baseline_adjust)

    x = list(PreIO = PreIOdt,
             PostIO = PostIOdt)


    return(x)

}
