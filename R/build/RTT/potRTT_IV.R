plotRTT_IV <- function(x, amp = "a", AD = "AD0"){
  if(amp == "a"){I = "Imon1";V = "Vmon1"}
  if(amp == "b"){I = "Imon2";V = "Vmon2"}
  I0 = as.data.frame(x[I])
  names(I0) <- gsub(paste0(I,"."), "", names(I0))
  V0 = as.data.frame(x[V])
  names(V0) <- gsub(paste0(V,"."), "", names(V0))
  AD0 = as.data.frame(x[AD])
  names(AD0) <- gsub(paste0(AD,"."), "", names(AD0))
  roi <- hd_tl(AD0)

  quickPlot_amp(ampA$`a-IV-2`, sig = "Imon1")

  }
