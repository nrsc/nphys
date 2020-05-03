#' Plot 3D from import.mat
#'
#' @param x
#' @param pre
#' @param post
#'
#' @return
#' @export
#'
#' @examples
plot3dRTT <- function(x, I = "Imon1", V = "Vmon1", AD = "AD0", pre = 1001, post = 2001, LJP = 8, drop = NA){
  I0 = as.data.frame(x[I])
  names(I0) <- gsub(paste0(I,"."), "", names(I0))
  V0 = as.data.frame(x[V])
  names(V0) <- gsub(paste0(V,"."), "", names(V0))
  AD0 = as.data.frame(x[AD])
  names(AD0) <- gsub(paste0(AD,"."), "", names(AD0))
  roi <- hd_tl(AD0, pre, post)

  I0 <- slice(I0, roi[1]:roi[2])
  I0 <- cbind.data.frame(Time = (I0[1]-min(I0[1]))*1000, sapply(I0[-1], function(x) bl_adjust(x)))
  if(is.numeric(drop)){
    I0 <- I0[,-c(drop+1)]
  }


  Imelt <- melt(I0, id.vars = c("Time"))
  Imelt$value <- Imelt$value*1e12

  V0 <- V0[-grep("Time", names(V0))]
  Vhold <- round(V0[roi[1],]*1000, 0) - LJP

  plot_ly(Imelt, x = ~Time, y = ~variable, z = ~value, type = 'scatter3d', mode ='lines', split = ~variable) %>%
    plotly::layout(scene = list(
      yaxis = list(title = "Vhold",
                   tickmode = "array",
                   nticks = length(Vhold),
                   tickvals = 1:length(Vhold),
                   ticktext = seq(min(Vhold), max(Vhold), by = 10)),
      zaxis = list(title = "pA")
    ))

}
