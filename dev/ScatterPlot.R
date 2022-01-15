#' Create Scatterplot of LTD traces
#'
#' @param x meltedDF
#' @param j Pooled Treatment AgeGroup to investigate
#'
#'
#' @return NA
#' @examples
#' \dontrun{
#' x = field$ABF
#' }
#' @export ScatterPlot
ScatterPlot <- function(x, j){
#if(missing(j)){j = AgeGroup}
#if(missing(t)){t = TRUE}
    ggplot(subset(x, AgeGroup == j), aes(
        x = variable,
        y = value
        #group = Treatment
    )) +
        geom_line(aes(group = Slice), colour = "grey") +
        stat_summary(
            fun.y = mean,
            geom = "point",
            colour = "black",
            na.rm = TRUE
        ) +
        stat_summary(
            fun.data = mean_se,
            geom = "errorbar",
            na.rm = TRUE,
            width = 0.5,
            colour = "black"
        ) +
        #scale_color_grey(start = 0.3, end = 0.8) +
        coord_cartesian(ylim = c(-75:30)) +
        scale_x_continuous(limits = c(0,75), breaks = seq(0, 75, by = 15))+
        ggtitle(j) +
        xlab("Time (minutes)") +
        theme_bw()+
        theme(
            plot.margin = unit(c(.3, .3, .3, .3), "cm"),
            #plot.title = element_text(vjust = 0.2, size = 14),
            #axis.text = element_text(size = 8),
            #axis.title = element_text(size = 12),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            panel.border = element_blank(),
            legend.position = 'right'
        )

}
