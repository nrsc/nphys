#' quickplot based upon selection.
#'
#' @param rda
#'
#' @return
#' @export
#'
#' @examples
quickPlot_amp <- function(x, amp = "a"){
  if(amp == "a"){sig = "Imon1"}
  if(amp == "b"){sig = "Imon2"}


  melted <- melt(x[sig], id.vars = "Time")
  melted$value = melted$value*1000

  g = ggplot(melted, aes(x = Time, y = value, group = variable))+
    geom_line()+
    ylab("pA")+
    xlab("Time")+
    theme_void()

  return(g)

}
