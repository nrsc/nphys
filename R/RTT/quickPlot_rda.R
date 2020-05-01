#' quickplot based upon selection.
#'
#' @param rda
#'
#' @return
#' @export
#'
#' @examples
quickPlot_rda <- function(rda){

  lst <- lapply(rda$Data, function(x) names(x))

  pro <- select.list(names(lst), title = "select which protocol to show")

  sig <- select.list(lst[[pro]], title = "select which signal to show")


  melted <- melt(rda$Data[[pro]][sig], id.vars = "Time")

  gg <- ggplot(melted, aes(x = Time, y = value*1e12, group = variable))+
    geom_line()+
    ylab("pA")+
    xlab("Time")+
    theme_void()

  gg

}
