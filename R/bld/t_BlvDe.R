#' Print baseline averaged trace
#'
#' @param x
#'
#' @return gg
#' @export
t_BlvDe <- function(x){
if(missing(x)){x = sA}


    BlAvg = x$LTD$Baseline$BlAvg
    De0 = x$LTD$Decay$DeAvg
    dfC <- x$LTD$Baseline$dfCross

    yMin = dfC$mV[3]*1.2
    yMax = max(BlAvg$mV)


    gg = ggplot() +
        geom_line(data = BlAvg, aes(Time, mV), size = 1) +
        geom_line(data = De0, aes(Time, mV), colour = "grey", size = 1) +
        geom_point(data = dfC, aes(Time, mV), colour = "blue") +
        geom_segment(aes(x = 30, y = yMin+0.5, xend = 30, yend = yMin)) + #represents 0.5mV
        #annotate("text", label = c("0.5 mV"), x = 24.25, y = yMin-(d0*2), angle = 90) +
        geom_segment(aes(x = 28, y = yMin, xend = 30, yend = yMin)) + #represents 2ms
        #annotate("text", label = c("2 ms"), x = 23, y = yMin-(d0/2)) +
        ylim(yMin, yMax) +
        #xlim(NA, ) +
        #ggtitle(sA) +
        theme_void() +
        theme(plot.title = element_text(hjust = 0.1))


    return(gg)
}
