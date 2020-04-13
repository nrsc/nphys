#' Returns the 10 and 50% points of the observable EPSP
#'
#' @param x
#'
#' @return pts
#' @export ptsI
#'
#' @examples
ptsI <- function(x){

Bl0 <- sA$LTD$Baseline
De0 <- sA$LTD$Decay
dfC <- Bl0$dfCross

p1 = dfC$Time[2]*100-1500
p2 = dfC$Time[3]*100-1500
pt1 = dfC$mV[2]
pt2 = dfC$mV[3]
d <- abs(pt2 - pt1)*-.1
pt1 <- pt1 + d
pt2 <- pt2 - 5*d

pt1 <- head(which(Bl0$BlAvg$mV[p1:p2] < pt1)+p1, 1)
pt2 <- tail(which(Bl0$BlAvg$mV[p1:p2] > pt2)+p1, 1)
pts = list(pt1, pt2)

return(pts)

}
