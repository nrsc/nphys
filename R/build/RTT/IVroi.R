#' IV plot
#'
#' @param x dataframe of current values
#' @param v dataframe of Voltage values
#' @param roi region of interest
#' @param LJP Liquid junction potential adjustments
#'
#' @return
#' @export
#'
#' @examples
IVroi <- function(x, v, roi, LJP = 0, dtRet = FALSE){
  x <- x[-grep("Time", names(x))]
  I <- slice(x, roi[1]:roi[2])
  I <- as.data.frame(sapply(I, function(x) bl_adjust(x)))
  v <- v[-grep("Time", names(v))]
  V <- round(v[roi[1],]*1000, 0) - LJP
  I <- I[which.min(I[,1]),]
  I = sapply(I, function(x)x*1e12)
  IV <- data.frame(V = unlist(V), I = unlist(I))
  p <- ggplot(IV, aes(V, I))+
    geom_point() +
    geom_line()+
    geom_hline(yintercept = 0)+
    geom_vline(xintercept = 0)+
    xlab("mV")+
    ylab("pA")+
    scale_x_continuous(breaks = IV$V)+
    #scale_y_continuous(breaks = seq(-200, 100, by = 25))+
    theme_pubr()+
    theme(
      axis.text.x = element_text(angle = 90)
    )

  if(dtRet == TRUE){
    return(IV)
      }else{
        return(p)
  }

}
