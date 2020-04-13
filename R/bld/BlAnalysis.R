#' Baseline Analysis for LTD
#'
#' @param x data.frame
#' @param Wsh Wash region to ignore when getting BlAvg
#' @param slp Logical. Apply slope.read function to all sweeps if TRUE.
#'
#' @return x
#' @export BlAnalysis
BlAnalysis <- function(x, Wsh, slp){

    if(missing(Wsh)){Wsh = 0}
    if(missing(slp)){slp = TRUE}

    #x = LTD$Baseline
    #Wsh = 0
    #slp = FALSE

    x <- x %>%
        Bl_EPSP()# %>% # Adjust Basline and get mVdrift

    x$Sweeps <- x$data %>%
        Isolate(Wsh = Wsh)

    x$BlAvg <- rowMeans(x$data[,(tail(x$Sweeps$BlSweeps, 20)+1)]) %>%
        Slope.Read()# %>%


    SA <- stim.Artifact(x$BlAvg)
    SA <- round((SA[1]+SA[2])/2, 0)

    x$BlAvg <- x$BlAvg %>%
        slice((SA+200):(SA+1149))

    print(ggplot(x$BlAvg) +
        geom_line(aes(Time, Data))+
        geom_line(aes(Time, Slope))+
        #geom_point(data = dfmVmax, aes(Time, Data), colour = "blue")+
        #geom_point(data = dfCross, aes(Time, Data), colour = "blue")+
        theme_bw())

    x$dfCross <- x$BlAvg %>%
        Cross0()

    x$stim <- x$data %>%
        slice((SA-100):(SA+200))

    x$ROI <- x$data %>%
        slice((SA+200):(SA+700)) %>%
        column_to_rownames("Time") %>%
        data.matrix()
    {
    magROI <- x$ROI
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
        x$mVmax <- mag

    }

    print(qplot(data = x$mVmax, x = Time, y = Data, ylim = c(-2,0), xlim = c(x$BlAvg$Time[1],x$BlAvg$Time[nrow(x$BlAvg)])))

    if(slp == TRUE){
        dfC <- x$dfCross
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
        }

    ROI <- x$ROI[P2:P3,]

    x$slpROI <- apply(ROI, 2, function(x){
        sl <- Slope.Read(x)
        sl <- sl$Slope
        return(sl)
    })



        row.names(x$slpROI) <- row.names(ROI)
        slpROI <- x$slpROI

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
        x$mVms <- slp1



    print(qplot(data = x$mVms, x = Time, y = Data, ylim = c(-3,0), xlim = c(x$BlAvg$Time[1],x$BlAvg$Time[nrow(x$BlAvg)])))





    }else{
        x$slpROI <- NA
        x$mVms <- NA}


    return(x)

}
