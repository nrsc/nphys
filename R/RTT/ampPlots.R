ampPlots <- function(x, amp = "a"){

  for(i in names(x)){
    if(grepl("TP", i) == TRUE){testPulse(x[[i]], amp = amp)}
    if(grepl("IV", i) == TRUE){
      a = quickPlot_amp(x[[i]], amp = amp)
      print(a)}
    if(grepl("IO", i) == TRUE){
      x = x[[i]]
      a = plotRTT(x, amp = amp)
      b = a+xlim(1, 200)+ggtitle("First pulse IOdV")
      grid.arrange(a,b, layout_matrix = cbind(1,1,1,2,2))
    }
    if(grepl("Step", i) == TRUE){
      x = x[[i]]
      a = plotRTT(x, amp = amp, post = 5001)+ggtitle(i)
      b = a +xlim(1, 100)#+ ylim(-100, 100)
      c = plotRTT_iv(x, amp = amp)
      grid.arrange(arrangeGrob(a,b,c, layout_matrix = rbind(c(1,1,1,1,1),
                                                            c(2,2,2,3,3))))
    }
    if(grepl("xFq", i) == TRUE){
      x = x[[i]]
      a = plotRTT(x, amp = amp) + ggtitle(i)
      b = a + xlim(1, 250)
      grid.arrange(a, b,
                   top = textGrob("",gp=gpar(fontface="bold")),
                   layout_matrix = cbind(1,1,1,2,2))
    }
  }

}




