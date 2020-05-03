#' Title
#'
#' @param x data to be read
#'
#' @return iSlope
#' @export Slope.Read
#'
Slope.Read <- function(x){

    x <- data.frame(x)
    nr <- data.frame(1:nrow(x))
    sq <- c(-10:-5, 5:10)
    Sl <- NULL
    s <- NULL

    for (n in sq){

        for (i in 11:nrow(nr)){


            Y1 <- x[i,]
            Y2 <- x[i+(n),]
            X1 <- nr[i,]
            X2 <- nr[i+(n),]

            Y <- c(Y2, Y1)
            X <- c(X2, X1)

            s[[i]] = as.numeric(diff(Y)/diff(X)*100)

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
