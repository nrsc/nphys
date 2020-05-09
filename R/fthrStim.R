#' feather a sweep
#' Feather a sweep by first identifying its stim artifact
#' then selecting the numer of samples beyond you want.
#' @param x vector
#' @param stim Stim artifact. Numeric to identify the point along the 1:length(vector). If blank,
#' @param adj Passed to the function stimArtifact() as a UI variable that adjusts the returned value by n samples
#' @param duration number of samples to return beyond the stim artifact
#'
#' @return vector
#' @examples
#' \dontrun{
#'
#' }
#'
#' @export
fthrStim <- function(x, stim, adj = -100, duration = 1500){
if(missing(stim)){
  stim = stimArtifact(x, adj = adj)
  }


    x = x[stim:(stim+duration)]

}
