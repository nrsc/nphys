#' lm at each sweep
#'
#' @param x
#'
#' @return tst
#' @export
lmSweep <- function(x){

    #x = data.frame(Bl0$EPSP)

    Time <- as.numeric(rownames(x))

    tst <- apply(x, 2, function(t){
        sBl0 <- NULL
        d0 <- min(t)*.1
        p50 <- min(t)/2
        p30 <- p50-d0*3
        p60 <- p50+d0

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
