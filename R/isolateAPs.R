#' Title
#'
#' @param x sweep vector
#'
#' @return
#'
#' @examples
#'
#' hct = loadHCT("Q20.26.005.1A.02.02")
#' sweep = extractNWB(hct$files$nwb, sweeps = hct$ffts$data_00036_AD0$trace, slim = TRUE)
#' rate = hct$ffts$data_00036_AD0$rate
#' plot(sweep, type = "l")
#'
#' x = sweep
#'seg_term = 0.05
#'
#' @export
isolateAPs = function(x, fp, rate, eONi, eOFFi, seg_term = 0.05){

  if (missing(eOFFi)) {
    message(
      "using length of sweep for epoch. This will have an effect on output for
            interspike interval and rate for the final spike"
    )
    eOFFi = length(x)

  }

  if(missing(fp)){
    fp = APanalysis(x, rate)
    if (is.null(fp)) {
      message("no peaks in sweep")
      return(NULL)
    }
  }




  #### dfSw -- Isolate segments of interest and assemble into a dataframe ####
  dfSw = c()
  #mVseg = c()
  for (i in 1:nrow(fp)) {
    #n = which(isiFilter == i)
    #print(n)
    if (i == nrow(fp)) {
      ## If this is the last row in the peak, take segment from the last AP
      ##
      df = data.frame(sweep[fp[i, "apMAXi"]:(eOFFi)])
    } else{
      df = data.frame(sweep[fp[i, "apMAXi"]:(fp[i + 1, 3] - (rate * seg_term))])
    }
    dfSw = qpcR:::cbind.na(i = dfSw, df)
  }
  dfSw$x = NULL
  names(dfSw) = paste0("AP", 1:nrow(fp))

  return(dfSw)
}
