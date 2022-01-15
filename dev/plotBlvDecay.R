#' Basic Baseline vs Decay plot.
#'
#' @param x Basic project nested list that nphys functions can run off
#'
#' @return gg
#'
#' @importFrom magrittr %>%
#' @import ggplot2
#'
#'
#' @examples
#' \dontrun{
#' x = field$ABF
#' plotBlvDecay(x)
#' }
#' @export plotBlvDecay
plotBlvDecay <- function(x, Wsh = FALSE){
# Pull data from ABF
sFq = unique(dfs_ABF(x, int = "samplingIntervalInSec", returnList = FALSE))*1000

Bl = pullSweeps(x, pull = "PreC-Bl") %>%  avgSweeps()

Decay = pullSweeps(x, pull = "Decay") %>% avgSweeps()

Time = seq(0, length.out = length(Bl), by = sFq)

df <- cbind.data.frame(Time, Bl, Decay)


    gg = ggplot2::ggplot(df) +
        geom_line(aes(Time, Bl), size = 1) +
        geom_line(aes(Time, Decay), colour = "grey", size = 1) +
        xlim(1, 10)
        #ylim(yMin, yMax) +
        #ggtitle(sA) +
        #theme_void() +
        #theme(plot.title = element_text(hjust = 0.1))


    return(gg)
}

#if(length(Bl) != length(Test)) stop("Baseline and test data are unequal lengths")
