#' Function intended to separate the comments into a reliable output
#'
#' @param x
#'
#' @return
#'
#' @examples
#'
#'
#'
#'
#' @export
commentsNWB = function(x, sep = "/n") {

  comment = data.frame(comment = do.call('cbind', strsplit(
    as.character(x), split = sep, fixed = TRUE

  )))

  return(comment)

}
