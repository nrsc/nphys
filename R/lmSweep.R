#' lm at each sweep
#'
#' @param x
#'
#' @return tst
#' @export lmSweep
#'
#' @examples
lmSweep <- function(x){
    Time <- as.numeric(rownames(x))


    tst <- apply(x, 2, function(t){
        sBl0 <- NULL
        d0 <- min(t)*.1
        p50 <- min(t)/2
        p20 <- p50-d0*3
        p30 <- p50-d0*2
        p60 <- p50+d0
        p80 <- p50+d0*3
        tpt1 <- tail(which(t > p30),1)
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
