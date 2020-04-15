#' Title
#'
#' @param x
#' @param stim Stim artifact. Numeric to identify the point along the 1:length(vector). If blank,
#' @param duration number of samples to return beyond after the stim artifact
#'
#' @return
#' @export
#'
#' @examples
fEPSP_fthr <- function(x, stim, duration = 1500){
if(missing(stim)){stim = stimArtifact(x)}

    x = slice(x, stim:(stim+duration))

}
