#' lm at each sweep
#'
#' @param x
#'
#' @return
#' @examples
#' \dontrun{
#' x field$ABF
#' }
#' @export lmSweep
lmSweep <- function(x){

    Time <- as.numeric(rownames(x))

    ret <- apply(x, 2, function(t){
        sBl0 <- NULL
        d0 <- min(t)*.1
        if(d0 == 0){
            sBl0 <- rbind(sBl0, NA)
        }else{
        p50 <- min(t)/2
        p25 <- p50-d0*2.5
        p60 <- p50+d0
        tpt1 <- tail(which(t > p25),1)
        tpt2 <- head(which(t < p60),1)
        if(length(tpt1) == 0)
            tpt1 = tail(which(t > max(t)+d0),1)
        if(length(tpt2) == 0)
            tpt2 = head(which(t > min(t)-d0),1)

        t2 <- data.frame(Time = Time, Data = t)
        t3 <- lm(Data~Time, data = t2[tpt1:tpt2,])[[1]][2]
        sBl0 <- rbind(sBl0, t3)
        }
        return(sBl0)
    })

    return(ret)
}
