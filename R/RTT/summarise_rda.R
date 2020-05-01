summarise_rda <- function(x){
  P1 <- lapply(x$Data, function(c){
    roi <- hd_tl(c$AD0)
    p1 <- ggROI(c$Imon1, roi = roi)
    return(p1)
  })
  P2 <- lapply(x$Data, function(c){
    roi <- hd_tl(c$AD0)
    p2 = IVroi(c$Imon1, c$Vmon1, roi = roi, LJP = 19)
    return(p2)
  })
  return(list(P1 = P1, P2 = P2))
}
