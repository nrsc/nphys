#' Close experimental slice
#'
#' @return NA
#' @export closeSlice
#'
#' @examples
closeSlice <- function(){
  slice <- select.list(list.files("tmp", pattern = "_S"))
  file.rename(file.path("tmp", slice), file.path("data/slices", slice))
}
