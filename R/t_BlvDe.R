#' Basic Baseline vs Decay plot.
#' Made from the
#'
#' @param x nested list that nphys functions can run off
#'
#' @return gg
#' @export plot.BlvDecay
#' @examples x = field$ABF
plot.BlvDecay <- function(x, Wsh = FALSE){

Bl <- pullSweeps(x)
Decay <- pullSweeps(x, int = "Decay")


df <- cbind.data.frame(Time, Bl, Decay)

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
