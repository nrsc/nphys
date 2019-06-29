TP_analysis <- function(x){
library(DescTools)
    maxmin <- cbind(which.max(x), which.min(x))
    p0 <- RoundTo(maxmin[which.min(maxmin)],100, floor)
    p1 <- RoundTo(maxmin[which.max(maxmin)],100, floor)
    x = bl_adjust(x, 1:p0)

    Ra = x[maxmin[which.min(maxmin)]]
    Rm = mean(x[(p1-(p1/10)):p1])


}

plot(x)
