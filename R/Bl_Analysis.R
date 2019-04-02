#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#' @param SA postition of the SA
#'
#' @return x
#' @export
Bl_Analysis <- function(x, Wsh = FALSE, SA = FALSE){
    if(Wsh == FALSE) {
        Wsh = 0
    } else{
        Wsh = as.numeric(readline(prompt = "enter # of wash in sweeps (ms):"))}
    if (SA == FALSE) {
        SA = 1501
    } else{
        SA = as.numeric(readline(prompt = "enter time (ms):"))
    }



    Sweeps <- x$data %>%
        Isolate(Wsh = Wsh)

    BlSweeps <- tail(Sweeps$BlSweeps, 20)


    BlAvg <- data.frame(rowMeans(x$data[SA:3000,BlSweeps])) %>%
        set_colnames("mV") %>%
        add_column(Time = as.numeric(rownames(.)), .before = 1)

    yMin <- min(BlAvg$mV[150:800])*1.5

    plot(mV ~ Time,data = BlAvg, type = "l", ylim = c(yMin,0.2))
    print("Pick identifiers")
    out <- BlAvg[identify(BlAvg$Time, BlAvg$mV, n = 3),]


    p1 = as.numeric(out[1,1])*100
    p2 = as.numeric(out[2,1])*100
    p3 = as.numeric(out[3,1])*100

    x$Sweeps <- Sweeps

    x$dt0 <- out

    x$BlAvg <- BlAvg

    x$stim <- x$data[SA:p1,]

    x$FV <- x$data[p1:p2,]

    x$EPSP <- x$data[p2:(p3+100),]

    x$EPSPdecay <- x$data[(p3-100):nrow(x$data),]

    return(x)

}


