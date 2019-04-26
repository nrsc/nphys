#' Adjust Baseline
#'
#'
#' @param x Dataframe to be adjusted
#' @param r range of samples to calculate Bl mean from
#'
#' @export
sweepRead <- function(x, r) {
    if (missing(r)) {
        r = 1:1000
    }
    x = as.data.frame(x)

    df <- x[,-which(grepl("*Time", names(x)))]
    mV <- lapply(df[r,], mean)
    df <- data.frame(Map("-", df, mV))
    rownames(df) = as.numeric(rownames(df))/100


    return(list(data = as.matrix(df), mVdrift = unlist(mV)))

}
