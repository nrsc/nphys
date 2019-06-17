#' Adjust Baseline of data frame and return a list that includes the mV drift
#'
#'
#' @param x Data to be adjusted
#' @param r range of samples to calculate Bl mean from
#'
#' @export
baseline_adjust <- function(x, r) {
    if (missing(r)) {
        r = 1:1000
    }

    x = as.data.frame(x)
    df <- x[,-which(grepl("*Time", names(x)))]
    mV <- lapply(df[r,], mean)
    df <- data.frame(Map("-", df, mV))
    rownames(df) = as.numeric(rownames(df))/100


    return(list(data = data.matrix(df), mVdrift = unlist(mV)))

}
