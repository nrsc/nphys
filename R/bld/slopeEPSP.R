slopeEPSP <- function(x){

ROI <- x

slpROI <- apply(ROI, 2, function(x){
    sl <- Slope.Read_0(x)
    sl <- sl$Slope
    return(sl)
})

row.names(slpROI) <- row.names(ROI)

slp1 <- apply(slpROI, 2, function(x) {
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
mVms <- slp1


}
