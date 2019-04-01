#' Title
#'
#' @param x region of interest
#' @param p1 first point to investigate
#' @param p2 second point to investigate
#'
#' @return x
#' @export lmROI
#'
#' @examples
lmROI <- function(x, p1, p2){
    sBl0 <- NULL
    Time <- as.numeric(row.names(x))
    x <- apply(x, 2, as.numeric)

    x <- apply(x, 2, function(x){
        sBl0 <- NULL
        x <- cbind.data.frame(Time = Time, Data = x)
        tst <- lm(Data~Time, data = x[p1:p2,])[[1]][2]
        sBl0 <- rbind(sBl0, tst)
        return(sBl0)
    })

    return(x)
}
