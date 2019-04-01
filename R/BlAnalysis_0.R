#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#' @param SA postition of the SA
#'
#' @return x
#' @export BlAnalysis_0
BlAnalysis_0 <- function(x, Wsh, SA){

    if(missing(Wsh)){Wsh = 0}
    if(missing(SA)){SA = 1500}
    x <- x %>%
        Bl_EPSP()# %>% # Adjust Basline and get mVdrift

    Sweeps <- x$data %>%
        Isolate(Wsh = Wsh)

    BlSweeps <- tail(Sweeps$BlSweeps, 20)+1

    dt = data.frame(rowMeans(x$data[1500:3000,BlSweeps]))
    colnames(dt) <- "mV"


    BlAvg <- dt %>%
        add_column(Time = as.numeric(rownames(.))/100, .before = 1)


    yMin <- min(BlAvg$mV[150:800])*1.5

    plot(mV ~ Time,data = BlAvg, type = "l", ylim = c(yMin,0.2))
    out <- BlAvg[identify(BlAvg$Time, BlAvg$mV, n = 3),]

    p1 = as.numeric(rownames(out)[1])
    p2 = as.numeric(rownames(out)[2])
    p3 = as.numeric(rownames(out)[3])

    x$Sweeps <- Sweeps

    x$BlAvg <- BlAvg

    x$dfCross <- out

    x$stim <- x$data %>%
        slice(SA:p1) %>%
        column_to_rownames("Time") %>%
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
