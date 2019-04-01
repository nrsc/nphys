#' Read slope along a vector
#'
#' @param x data to be read
#'
#' @return iSlope
#' @export Slope.Read_0
#'
Slope.Read_0 <- function(x){

    x <- data.frame(x)
    nr <- data.frame(1:nrow(x))
    sq <- c(-10:-5, 5:10)
    Sl <- NULL
    s <- NULL

    for (n in sq){

        for (i in 11:nrow(nr)){

            Y1 <- x[i,]
            Y2 <- x[i+(n),]
            X1 <- as.numeric(nr[i,])
            X2 <- as.numeric(nr[i+(n),])

            Y <- c(Y2, Y1)
            X <- c(X2, X1)

            s[[i]] = lm(Y~X)$coef[2]*100

        }

        Sl <- cbind(Sl, s)

    }

    Slmean <- apply(Sl, 1, mean)
    Slmean <- na.fill(Slmean, 0)
    Time <- as.numeric(row.names(x))/100
    iSlope <- data.frame(Time, Slmean, x)
    colnames(iSlope) <- c("Time", "Slope", "Data")
    return(iSlope)

}
