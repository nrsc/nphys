#' Print baseline averaged trace
#'
#' @param x
#' @param x2
#' @param Fq
#'
#' @return gg
#' @export
#' @examples x = field$traces
plot_BlvsDe <- function(x){

Bl <- x$Bl_Avg
De <- x$Decay_Avg
Time <- x$Time

df <- cbind.data.frame(Time, Bl, De)

    gg <- ggplot(df) +
        geom_line(aes(Time, Bl), size = 1) +
        geom_line(aes(Time, De), colour = "grey", size = 1) +
        #ylim(yMin, yMax) +
        #xlim(NA, ) +
        #ggtitle(sA) +
        theme_void() +
        theme(plot.title = element_text(hjust = 0.1))


    return(gg)
}

#if(length(Bl) != length(Test)) stop("Baseline and test data are unequal lengths")
