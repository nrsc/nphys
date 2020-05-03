#' Head and tail of region of interest based upon AD0 input
#'
#' @param x
#' @param pre
#' @param post
#'
#' @return
#' @export
#'
#' @examples
hd_tl <- function(x, pre = 1001, post = 5001){
  x = x[-grep("Time", names(x))]
  x = rowMeans(x)
  hd <- head(which(outliers::scores(x, prob = 0.90)== TRUE),1)-pre
  tl <- tail(which(outliers::scores(x, prob = 0.90)== TRUE),1)+post
  return(c(hd, tl))
}
