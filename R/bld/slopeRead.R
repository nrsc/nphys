#' Read slope along a vector
#'
#' @param x data to be read
#'
#' @return iSlope
#' @export slopeRead
slopeRead <- function(x, simple = TRUE){
x <- data.frame(x)
nr <- data.frame(1:nrow(x))
Sl <- NULL
s <- NULL

if(simple == TRUE){sq <- c(-10, 10)}else{sq = c(-10:-5, 5:10)}

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

Slmean <- apply(Sl, 1, mean) %>% na.fill(., 0)

return(Slmean)

}





#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
# for(i in )
# tst <- x[sq[10]:(sq[10]+,]
#
# X <- as.numeric(rownames(tst))
# lm()
#
#
# r2
#
#     nr <- as.numeric(1:nrow(x))
#     Sl <- NULL
#     s <- NULL
#
#     for (n in sq){
#
#         for (i in 11:nrow(nr)){
#
#             Y1 <- x[i,]
#             Y2 <- x[i+(n),]
#             X1 <- as.numeric(nr[i,])
#             X2 <- as.numeric(nr[i+(n),])
#
#             Y <- c(Y2, Y1)
#             X <- c(X2, X1)
#             s[[i]] = lm(Y~X)$coef[2]
#         }
#
#
#     }
#
#         Sl <- cbind(Sl, s)
#
#     }
#
#     Slmean <- apply(Sl, 1, mean)
#     Slmean <- na.fill(Slmean, NA)
#     Time <- as.numeric(row.names(x))
#     iSlope <- data.frame(Time, Slmean, x)
#     colnames(iSlope) <- c("Time", "Slope", "Data")
#     return(iSlope)
#
# }
