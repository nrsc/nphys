#' Closer analysis and slopes of Decay Data
#'
#' @param x Decay data. ncol minimum of 241 including Time
#' @param dfC dfCross from BlAnalysis
#' @param SA Stim artifact
#'
#' @return x
#' @export DeAnalysis_0
#'
DeAnalysis_0 <- function(x, dfC, SA){
#SD = x
#    x = x$LTD$Decay
#dfC <- SD$LTD$Baseline$dfCross
#dfC


if(missing(dfC)){stop()}
if(missing(SA)){SA = 1500}

if(ncol(x) < 241){stop()}

    x = Bl_EPSP(x, r=1:1000)


    DeAvg = data.frame(rowMeans(x$data[1500:3000,221:241]))
    colnames(DeAvg) = "mV"

    x$DeAvg <- DeAvg %>%
        add_column(Time = as.numeric(rownames(.))/100, .before = 1)

    p1 = as.numeric(rownames(dfC)[1])
    p2 = as.numeric(rownames(dfC)[2])
    p3 = as.numeric(rownames(dfC)[3])

    x$stim <- x$data %>%
       slice(SA:p1) %>%
       data.matrix()

    x$FV <- x$data %>%
       slice(p1:p2) %>%
        column_to_rownames("Time") %>%
       data.matrix()

    x$EPSP <- x$data %>%
       slice(p2:(p3+100)) %>%
        column_to_rownames("Time") %>%
       data.matrix()

    x$EPSPdecay <- x$data %>%
       slice(p3:nrow(x$data)) %>%
        column_to_rownames("Time") %>%
       data.matrix()

    x$data <- data.matrix(x$data)

    return(x)
}
