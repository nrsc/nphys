#' Scatter plots for treatment effects at AgeGroups
#'
#' @param x melted df with variable and value as x and y components
#' @param j AgeGroup
#' @param s Scatter shape of treatment
#' @param lb text
#'
#' @return ggplot
#' @export ScatterPlot_Tr_LFS
#'
ScatterPlot_Tr_LFS <- function(x, j, s, lb) {
if(missing(lb)){lb = NA}
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
        scale_x_continuous(limits = c(-15,75), breaks = seq(-15, 75, by = 15))+
        scale_y_continuous(limits = c(-40, 20),
                           breaks = seq(-40, 20, by = 10)) +
        scale_shape_manual(values = c(16, s)) +
        annotate("rect", xmin = 0, xmax = 15, ymin = 15, ymax = 16, colour = "black", fill = "red") +
        annotate("text", x = 8, y = 20, label = lb, colour = "black", size = 3) +
        xlab("Time (minutes)") +
        ggtitle(j) +
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
