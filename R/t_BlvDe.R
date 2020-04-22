#' Print baseline averaged trace
#'
#' @param x
#'
#' @return gg
#' @export plot.BlvsDecay
#' @examples x = field$ABF
plot.BlvsDecay <- function(x){

Bl <- pullSweeps(x)
Bl <- pullSweeps("Decay")


df <- cbind.data.frame(Time, Bl, De)

    gg <- ggplot2::ggplot(df) +
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
