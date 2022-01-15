#' Create Scatterplot of LTD traces
#'
#' @param x meltedDF
#' @param j Pooled Treatment AgeGroup to investigate
#'
#'
#' @return gg
#' @export
ScatterPlot_simple <- function(x, j) {
    x = subset(x, AgeGroup == j)
    Bl <- subset(x, x$variable %in% -15:-1)
    De <- subset(x, x$variable %in% 1:75)

    gg <- ggplot(x, aes(x = variable, y = value)) +
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
        coord_cartesian(ylim = c(-40:10)) +
        scale_x_continuous(limits = c(-15, 75),
                           breaks = seq(-15, 75, by = 15)) +
        #ggtitle(paste0(j)) +
        ylab("% change in EPSP slope") +
        xlab("Time (minutes)")+
        geom_segment(aes(x = 0, xend = 0, y = -10, yend = -5), arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        geom_segment(aes(x = 3, xend = 3, y = -10, yend = -5), arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        geom_segment(aes(x = 6, xend = 6, y = -10, yend = -5),arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        geom_segment(aes(x = 9, xend = 9, y = -10, yend = -5),arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        geom_segment(aes(x = 12, xend = 12, y = -10, yend = -5),arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        geom_segment(aes(x = 15, xend = 15, y = -10, yend = -5),arrow = arrow(length = unit(0.2, "cm")), colour = "purple3")+
        annotate("text", x = 8, y = 0, label = "LFS", colour = "black", size = 4) +
        theme_bw() +
        theme(
            plot.margin = unit(c(.3, .3, .3, .3), "cm"),
            #plot.title = element_text(vjust = 0.2),
            #axis.text = element_text(size = 10),
            axis.title = element_blank(),
            #axis.text.x = element_blank(),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            panel.border = element_blank(),
            legend.position = 'none'
        )
    return(gg)
}

#ScatterPlot_simple(subset(meltedLFS, Treatment == "Control"), "PND28")

