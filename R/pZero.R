#' pZero
#'
#' @param x numeric vector along which you can select a number of point
#' @param n how many points do you want to choose?
#' @param sel
#'
#' @return
#' @export
#'
#' @examples
#' x =
#'
pZero <- function(x, n = 1){
    plot(x)
    ret = graphics::identify(zoo::index(x), x, n = n)

    return(ret)
}
