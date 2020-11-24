#' Create Scatterplot of LTD traces. Includes background traces
#'
#' @param x meltedDF
#' @param j Pooled Treatment AgeGroup to investigate
#'
#'
#' @return NA
#' @export ScatterPlot_LTD
#'
#' @example ScatterPlot_LTD(subset(meltedLFS, Treatment == "Control"), "PND14")
ScatterPlot_LTD <- function(x) {

    Bl <- subset(x, x$variable %in% -15:-1)
    De <- subset(x, x$variable %in% 1:75)

    ggplot(x, aes(x = variable, y = value)) +
        geom_line(data = Bl,
                  aes(x = variable, y = value, group = Slice),
                  colour = "grey") +
        geom_line(data = De,
                  aes(x = variable, y = value, group = Slice),
                  colour = "grey") +
        stat_summary(
            fun.y = "mean",
            geom = "point",
            colour = "black",
            na.rm = TRUE
        ) +
        stat_summary(
            fun.data = "mean_se",
            geom = "errorbar",
            na.rm = TRUE,
            width = 0.5,
            colour = "black"
        ) +
        scale_y_continuous(limits = c(-80,30), breaks = seq(-70,30, by = 20))+
        scale_x_continuous(limits = c(-15, 75), breaks = seq(-15, 75, by = 15)) +
        ylab("") +
        xlab("") +
        #annotate("text", x = 8, y = 0, label = "LFS", colour = "black", size = 4) +
        theme_bw() +
        theme(
            plot.margin = unit(c(.3, .3, .3, .3), "cm"),
            plot.title = element_text(vjust = 0.2, size = 12),
            #axis.text = element_text(size = 8),
            #axis.title = element_text(size = 12),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            panel.border = element_blank(),
            legend.position = 'right')


}



