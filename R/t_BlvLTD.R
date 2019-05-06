#' trace Baseline vs LTD
#'
#' @param x
#'
#' @return p1
#' @export t_BlvLTD
t_BlvLTD <- function(x, ld = FALSE, lmInc = TRUE, ptsInc = TRUE, dDir = "."){

    if(ld == TRUE){
    md <- load_sA(x, dDir)
    }


Bl0 = sA$LTD$Baseline$BlAvg
De0 = sA$LTD$Decay$DeAvg
dfC <- sA$LTD$Baseline$dfCross

mVmax = dfC$mV[3]
t_mVmax = dfC$Time[3]-dfC$Time[1]

t2 = dfC$Time[2]*100-1500
t3 = dfC$Time[3]*100-1500

pt2 = dfC$mV[2]
pt3 = dfC$mV[3]

d <- abs(pt3 - pt2)*-.1
d0 <- abs(pt3)*-.1

p1 <- head(which(Bl0$mV[t2:t3] < (pt2+d))+t2, 1)
p2 <- tail(which(Bl0$mV[t2:t3] > (pt3-5*d))+t2, 1)

yMin = d0 * 12
yMax = pmax(max(Bl0$mV), max(De0$mV))

p1 = ggplot() +
    geom_line(data = De0, aes(Time, mV), colour = "grey", size = 1) +
    geom_line(data = Bl0, aes(Time, mV), size = 1) +
    stat_smooth(data = Bl0[p1:p2, ],
                aes(Time, mV),
                method = "lm",
                colour = "blue") +
    stat_smooth(data = De0[p1:p2, ],
                aes(Time, mV),
                method = "lm",
                colour = "red") +
    geom_point(data = dfC, aes(Time, mV), colour = "blue") +
    geom_segment(aes(x = 25, y = yMin+0.5, xend = 25, yend = yMin)) + #represents 0.5mV
    #annotate("text", label = c("0.5 mV"), x = 24.25, y = yMin-(d0*2), angle = 90) +
    geom_segment(aes(x = 23, y = yMin, xend = 25, yend = yMin)) + #represents 2ms
    #annotate("text", label = c("2 ms"), x = 23, y = yMin-(d0/2)) +
    ylim(yMin, yMax) +
    xlim(NA, 25) +
    ggtitle(x) +
    theme_void() +
    theme(plot.title = element_text(hjust = 0.1))


if(lmInc == FALSE){p1 = delete_layers(p1, "StatSmooth")}
if(ptsInc == FALSE){p1 = delete_layers(p1, "GeomPoint")}
#if(titleInc == FALSE){p1 = delete_layers(p1, "ggtitle")}
#suppressWarnings(print(p1))

return(p1)

}


