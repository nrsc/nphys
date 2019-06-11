SlopefEPSP <- function(x){

    dfInt <- list()

    for (i in 1:ncol(x)){

        df = as.data.frame(x[,i])
        dfi <- NULL
        #dfi <- as.data.frame(y[P1:(P1+P2)])
        dfi <- Slope.Read(df)
        d <- dfi$Slope
        dfInt[[i]] <- d
        #dfInt <- plyr::compact(dfInt)
    }

    df <- as.data.frame(dfInt)
    colnames(df) <- 1:ncol(df)
    return(df)

}
