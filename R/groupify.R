#' Group based upon sweep interval.
#'
#' @param x
#' @param threshold
#'
#' @return
#' @export
#'
#' @examples
#'
#' tst0 =
#' starting_times = sapply(1:length(tst0), function(x){
#' tst0[[x]]$starting_time
#' })
#'
#' x = starting_times
#'
groupify <- function(x, threshold = 10) {

  for(i in seq(length(x) - 1)) {
    if(i == 1) {
      group <- 1
      last_grad <- diff(x)[i]
      new_group <- FALSE
      next
    }
    if((abs(diff(x)[i] - last_grad) < threshold) | new_group) {
      group <- c(group, tail(group, 1))
      new_group <- FALSE
    }  else {
      group <- c(group, tail(group, 1) + 1)
      new_group <- TRUE
    }
    last_grad <- diff(x)[i]
    # print(last_grad)
  }

  setNames(data.frame(seq_along(x), x, factor(c(1, group))),
           c("index", deparse(substitute(x)), "group"))
}
