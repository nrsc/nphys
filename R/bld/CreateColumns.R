#' Create Columns
#'
#' @param x dataframe
#' @param n numer of desired columns
#'
#' @return x
#' @export CreateColumns
#'
CreateColumns <- function(x, n){
if(missing(n)){n = 80}

    if(ncol(x)<n){
        print("Making Columns")
        newCols<-n-ncol(x)
        df <- NULL
        df <- data.frame(1:nrow(x))
        nColNames <- seq(1:newCols)
        for (i in 1:newCols){
            df[,i] <- 0
        }
        x <- cbind.data.frame(df, x)
    }else

        return(x)

}

