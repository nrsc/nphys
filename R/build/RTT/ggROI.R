#' Plot region of interest with ggplot
#'
#' @param x
#' @param AD0 stimulus signal - averaged
#' @param roi region of interest - best determined by hd_tl
#' @param drop drop any pesky traces
#'
#' @return
#' @export
#'
#' @examples
ggROI <- function(x, AD0, roi, Bl = 1001, drop = NA, ADadj = 5){
  I <- slice(x, roi[1]:roi[2])
  AD = slice(AD0[-1], roi[1]:roi[2]) %>% rowMeans(.)
  I <- cbind.data.frame(Time = (I[1]-min(I[1]))*1000, AD, sapply(I[-1], function(x) bl_adjust(x, 1:Bl)))
  mm <-
    if(is.numeric(drop)){
      I <- I[,-c(drop+2)]
    }
  Imelt <- melt(I, id.vars = c("Time", "AD"))
  Imelt$value <- Imelt$value*1e12
  Imelt$AD <- Imelt$AD*(abs(MaxMinZero(Imelt$value))/ADadj)
  ggplot(Imelt, aes(x = Time, y = value, group = variable)) +
    geom_line()+
    geom_line(aes(x = Time, y = AD), colour = "blue")+
    ylab("pA")+
    xlab("Time (ms)")+
    theme_pubclean()
}


#I = rda$Data$ampA$`a-5xFq-4`$Imon1
