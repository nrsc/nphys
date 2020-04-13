#' lm at each sweep
#'
#' @param x
#'
#' @return tst
#' @export lmSweep0
#'
#' @examples
lmSweep0 <- function(x){

x = sA$Data

dt = x[[1]]

apply(x, 2, function(dt){

    dt0 = baseline_adjust(dt)
    x0 = dt0$data[,ncol(dt0$data)]
    s0 <- slopeRead(x0)



})





    Bl0 <- x$LTD$Baseline
    De0 <- x$LTD$Decay
    dfC <- Bl0$dfCross

    FV = data.frame(Bl0$FV)
    EPSP = data.frame(Bl0$EPSP)


    FVmin = function(x){
    tst = sapply(x, which.min)
    tst1 = sapply(x, min)
    tst0 <- cbind.data.frame(Time = as.numeric(rownames(x)[tst]), mV = tst1)
    return(tst0)
    }

    tst2 = FVmin(FV)

    EPSPmax = function(x){
        tst = sapply(x, which.max)
        tst1 = sapply(x, max)
        tst0 <- cbind.data.frame(Time = as.numeric(rownames(x)[tst]), mV = tst1)
        return(tst0)
    }

    tst3 = EPSPmax(EPSP)

    ggplot() +
        geom_line(data = Bl0$BlAvg, aes(Time, mV), size = 1) +
        geom_point(data = tst2, aes(Time, mV)) +
        geom_point(data = tst3, aes(Time, mV)) +
        geom_segment(aes(x = 30, y = yMin+0.5, xend = 30, yend = yMin)) + #represents 0.5mV
        #annotate("text", label = c("0.5 mV"), x = 24.25, y = yMin-(d0*2), angle = 90) +
        geom_segment(aes(x = 28, y = yMin, xend = 30, yend = yMin)) + #represents 2ms
        #annotate("text", label = c("2 ms"), x = 23, y = yMin-(d0/2)) +
        ylim(yMin, yMax) +
        #xlim(NA, ) +
        #ggtitle(sA) +
        theme_void() +
        theme(plot.title = element_text(hjust = 0.1))


    x0 = rbind.data.frame(Bl0$FV, Bl0$EPSP)
    which(rownames(x0) == as.character(dfC$Time[1]))

    Time <- as.numeric(rownames(x0))


    tst <- apply(x0, 2, function(t){

        sBl0 <- NULL

        p1 = dfC$Time[1]
        p2 = dfC$Time[2]
        p3 = dfC$Time[3]


        d0 <- min(t)*.1
        p50 <- min(t)/2
        p25 <- p50-d0*2.5
        p60 <- p50+d0

        tpt1 <- tail(which(t > p25),1)
        tpt2 <- head(which(t < p60),1)
        if(length(tpt1) == 0){
            tpt1 = tail(which(t > max(t)+d0),1)
        }

        t <- cbind.data.frame(Time = Time, Data = t)
        t2 <- lm(Data~Time, data = t[tpt1:tpt2,])[[1]][2]
        sBl0 <- rbind(sBl0, t2)
        return(sBl0)
    })

    return(tst)
}
