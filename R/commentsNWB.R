#' Function intended to separate the comments into a reliable output
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
commentsNWB = function(x, path, sep = "/n"){

  comment = data.frame(comment = do.call('cbind', strsplit(
    as.character(
      rhdf5::h5readAttributes(x, name = path)$comment
    ), split = sep, fixed = TRUE
  )))

  return(comment)

}
