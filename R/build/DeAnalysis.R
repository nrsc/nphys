#' Closer analysis and slopes of Decay Data
#'
#' @param x Decay data. ncol minimum of 241 including Time
#' @param dfC dfCross from BlAnalysis
#' @param slp Logical. Apply slope.read function to all sweeps if TRUE.
#'
#' @return x
#' @export DeAnalysis
#'
DeAnalysis <- function(x, dfC, slp){
#x = LTD$Decay
#dfC <- sd$dfCross
#slp = FALSE
#BlAvg <- SliceData$LTD$Baseline$BlAvg


if(ncol(x) < 241){stop()}

    x = Bl_EPSP(x, r=1:1000)

    x$DeLTD <- rowMeans(x$data[,221:241]) %>%
        Slope.Read()

    SA <- stim.Artifact(x$DeLTD)
    SA <- round((SA[1]+SA[2])/2, 0)

    x$stim <- x$data[(SA-100):(SA+200),]

    x$ROI <- x$data %>%
        slice((SA+200):(SA+650)) %>%
        column_to_rownames("Time")

    x$DeLTD <- x$DeLTD %>%
        slice((SA+200):(SA+650))


    {

    if (nrow(dfC) == 1) {
        p2 <- row.names(x$ROI)[1]
        print("dfCross = 1")
    }else{
        p2 <- dfC[(nrow(dfC) - 1), 1]
        print("p2 from dfCross")
    }
    p3 <- dfC[nrow(dfC),1]

    P2 <- which(row.names(x$ROI) == p2)
    P3 <- which(row.names(x$ROI) == p3)


    if(length(P2) == 0){P2 = nrow(x$ROI)[1]}
    if(length(P3) == 0){P3 = nrow(x$ROI)}
        } # dfC

    magROI <- x$ROI

    {
        mag <- apply(magROI, 2, function(x) {
            m <- as.numeric(which.min(x))
            t <- rownames(magROI)[m]
            r <- as.numeric(x[which.min(x)])
            dt <- rbind(m,t, r)
            return(dt)
        })
        colnames(mag) <- NULL
        mag <- t(mag)
        mag <- apply(mag, 2, as.numeric)
        colnames(mag) <- c("index", "Time", "Data")
        mag <- as.data.frame(mag)
        x$De_mVmax <- mag



    } # Absolute Magnitude

    if(slp == TRUE){

    slpROI <- x$ROI[P2:P3,]

    x$slpROI <- apply(slpROI, 2, function(x){
        sl <- Slope.Read(x)
        sl <- sl$Slope
        return(sl)
    })

    row.names(x$slpROI) <- row.names(slpROI)

    {
        slp1 <- apply(x$slpROI, 2, function(x) {
            m <- as.numeric(which.min(x))
            n <- row.names(slpROI)[m]
            r <- as.numeric(x[which.min(x)])
            dt <- cbind(m,n,r)
            return(dt)
        })
        colnames(slp1) <- NULL
        slp1 <- t(slp1)
        slp1 <- apply(slp1, 2, as.numeric)
        colnames(slp1) <- c("index","Time", "Data")
        slp1 <- as.data.frame(slp1)

        x$De_mVms <- slp1

}


    #print(qplot(xV, mag[,2]))

    xS <- seq(1, by = 0.25, length.out = nrow(x$De_mVms))
    yM <- min(x$De_mVmax$Data)*2
    print(ggplot() +
              geom_point(data = x$De_mVms, aes(xS, Data)) +
              ylim(yM, 0)+
              theme_bw())

    }else{
        x$slpROI <- NA
        x$De_mVms <- NA
    } # Absolute Slope

    return(x)
}
