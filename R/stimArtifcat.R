#' Utilize the point along a trace
#' where the rate of change between points
#' is the greatest to identify the stim artifact.
#'
#' @param x Vector along with which to examine. Currently only supports one stim artifact per trace
#' @param adj Make adjustments to how far up or down the trace from the stim artifact you want returned

#' @importFrom utils head
#'
#' @return index along trace that matches the point where the difference between points is the greatest to identify the on phase of the stim artifact.
#' This is necessary when trying to locate the response along the trace, but not having the Stim channel data.
#' @examples
#' \dontrun{
#' stimArtifact(field$traces$Bl_avg)
#' }
#' @export stimArtifact
stimArtifact <- function(x, adj = 0){

    x = head(which(diff(x) == sort(diff(x))[1]),1)+adj

return(x)

}

