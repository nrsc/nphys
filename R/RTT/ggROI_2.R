#' Plot region of interest with ggplot
#'
#' @param x
#' @param AD0 stimulus signal - averaged
#' @param roi region of interest - best determined by hd_tl
#' @param drop drop any pesky traces
#'
#' @return
#' @export
#'
#' @examples
ggROI_2 <- function(df, mode = "VC", amp = "a", AD0, roi, Bl = 1001, drop = 0, ADadj = 5){
  #df <- rda$Data$ampA$`a-5xFq-6`
  if(missing(roi)){
    roi = hd_tl(df$AD0)
  }
  if(mode == "VC") sig = "Imon"
  if(mode == "CC") sig = "Vmon"
  if(amp == "a") sig = paste0(sig, "1")
  if(amp == "b") sig = paste0(sig, "2")

  df2 <- slice(df[[sig]], roi[1]:roi[2])

  i2 <- data.frame(Time = df2[,1],
                   apply(df2[-1], 2, function(x){
                      x2 = bl_adjust(x, 1:Bl)
                      x3 = x2*1e12
                      }))
  mm <-
  if(drop != 0){
    df3 <- df3[,-c(drop+2)]
  }
  Imelt <- melt(i2, id.vars = "Time")# %>%
  AD <- stimON(df$AD0)
  tst <- NbClust::NbClust(AD[,1:2], method = "ward.D", index = "marriot")
  #AD$Group <- tst$Best.partition
  pts <- AD %>% group_by(Group) %>% summarise_at(vars(Time), funs(mean(., na.rm = TRUE)))
  #Imelt$value <- Imelt$value*1e12
  #ADmelt <- melt(AD, id.vars = "Time")# %>%
  #Imelt$AD <- Imelt$AD*(abs(MaxMinZero(Imelt$value))/ADadj)
  #data = subset(Imelt[grepl("AD", Imelt$variable),])
  ggplot(Imelt, aes(x = Time, y = value, group = variable)) +
    geom_line()+
    #geom_step(data = ADmelt, aes(pts$Time, y = 5))
    ylab("pA")+
    xlab("Time (ms)")+
    theme_pubclean()
}

#I = rda$Data$ampA$`a-5xFq-4`$Imon1
