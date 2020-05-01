#' quickplot based upon selection.
#'
#' @param rda
#'
#' @return
#' @export
#'
#' @examples
quickPlot_V <- function(x, amp = "a", AD = FALSE){
  if(amp == "a"){sig = "Vmon1"}
  if(amp == "b"){sig = "Vmon2"}

  melted <- melt(x[sig], id.vars = "Time")
  melted$value = melted$value*1000

  if(AD == TRUE){
    AD = x$AD0
    ADmelt <- melt(AD0, id.vars = "Time")
    melted$AD0 = ADmelt$value
    ggplot(melted)+
      geom_line(aes(x = Time, y = value, group = variable))+
      geom_line(aes(x = Time, y = AD0, group = variable))+
      ylab("mV")+
      xlab("Time")+
      theme_void()
  }else{

    ggplot(melted)+
    geom_line(aes(x = Time, y = value, group = variable))+
    ylab("mV")+
    xlab("Time")+
    theme_void()
  }
}
