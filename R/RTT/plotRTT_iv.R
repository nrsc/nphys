#' Plot 3D from import.mat
#'
#' @param x
#' @param I signal for analysis
#' @param pre
#' @param post
#'
#' @return
#' @export
#'
#' @examples x = rda$Data
plotRTT_iv <- function(x, amp = "a", AD = "AD0", pre = 1001, post = 1001, LJP = 8){
  if(amp == "a") {I = "Imon1"; V = "Vmon1"}
  if(amp == "b") {I = "Imon2"; V = "Vmon2"}
  I0 = as.data.frame(x[I])
  names(I0) <- gsub(paste0(I,"."), "", names(I0))
  V0 = as.data.frame(x[V])
  names(V0) <- gsub(paste0(V,"."), "", names(V0))
  AD0 = as.data.frame(x[AD])
  names(AD0) <- gsub(paste0(AD,"."), "", names(AD0))

  roi <- hd_tl(AD0, pre, post)
  p = IVroi(I0, V0, roi, LJP)
  return(p)

}
