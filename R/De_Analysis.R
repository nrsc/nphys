#' Closer analysis and slopes of Decay Data
#'
#' @param x Decay data. ncol minimum of 241 including Time
#' @param dfC dfCross from BlAnalysis
#' @param SA Stim artifact
#'
#' @return x
#' @export
De_Analysis <- function(x, dfC, SA){
if(missing(dfC)){stop()}
if(missing(SA)){SA = 1501}


if(ncol(x$data) < 240){stop()}


    DeAvg = data.frame(rowMeans(x$data[SA:3000,221:240])) %>%
        set_colnames("mV") %>%
        add_column(Time = as.numeric(rownames(.)), .before = 1)

    p1 = as.numeric(dfC[1,1])*100
    p2 = as.numeric(dfC[2,1])*100
    p3 = as.numeric(dfC[3,1])*100

    x$DeAvg <- DeAvg

    x$stim <- x$data[SA:p1,]

    x$FV <- x$data[p1:p2,]

    x$EPSP <- x$data[p2:(p3+100),]

    x$EPSPdecay <- x$data[(p3-100):nrow(x$data),]


    return(x)
}
