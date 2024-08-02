#' Downsample based on rate of change between points. Can greatly reduce the number of points in a trace
#'
#' @param signal sweep vector
#' @param threshold absolute value of difference between signal points.
#'
#' @return
#' @export
#'
#' @examples
threshold_downsampling <- function(signal, threshold) {
    if(missing(threshold))
        threshold = 0.1

    downsampled_signal <- c(signal[1])
    for (i in 2:length(signal)) {
        if (abs(signal[i] - signal[i-1]) > threshold) {
            downsampled_signal <- c(downsampled_signal, signal[i])
        }
    }
    return(downsampled_signal)
}
