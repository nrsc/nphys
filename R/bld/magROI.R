magROI <- function(x){
    magROI <- x
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

    return(mag)



}
