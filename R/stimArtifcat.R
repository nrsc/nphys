#' Utilize the point along a trace
#' where the rate of change between points
#' is the greatest to identify the stim artifact.
#'
#' @param x Vector along with which to examine. Currently only supports one SA per trace
#'
#' @return
#' @export
#'
#' @examples x = field$traces$Bl_avg
stimArtifact <- function(x, adj = 0, headORtail = "head", n = 1){

if(headORtail == "head"){
x = head(which(diff(x) == sort(diff(x))[1]),1)+adj
}

if(headORtail == "tail"){
x = which(diff(x) == sort(diff(x)))
}



return(x)

}

