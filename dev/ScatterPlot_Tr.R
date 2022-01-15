#' Scatter plots for treatment effects at AgeGroups
#'
#' @param x melted df with variable and value as x and y components
#' @param j AgeGroup
#' @param s Scatter shape of treatment
#'
#' @return ggplot
#' @export ScatterPlot_Tr
#'
ScatterPlot_Tr <- function(x, j, s) {
    ggplot(subset(x, AgeGroup == j),
           aes(x = variable, y = value, group = Treatment)) +
        stat_summary(
            fun.y = mean,
            geom = "point",
            na.rm = TRUE,
            aes(shape = Treatment),
            fill = "white"
        ) +
        stat_summary(
            fun.data = mean_se,
            geom = "errorbar",
            na.rm = TRUE,
            width = 0.5
        ) +
        scale_x_continuous(limits = c(0, 75),
                           breaks = seq(0, 75, by = 15)) +
        scale_y_continuous(limits = c(-40, 20),
                           breaks = seq(-40, 20, by = 10)) +
        scale_shape_manual(values = c(16, s)) +
        ggtitle(j) +
        theme_bw() +
        theme(
            plot.margin = unit(c(.2, .2, .2, .2), "cm"),
            plot.title = element_text(vjust = 0.2, size = 14),
            axis.text = element_text(size = 8),
            axis.title = element_text(size = 12),
            panel.grid.major = element_blank(),
            panel.grid.minor = element_blank(),
            panel.background = element_blank(),
            panel.border = element_blank(),
            legend.position = 'right')
}
