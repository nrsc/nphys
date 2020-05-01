ZeroChR2.mat <- function(x, sig = c("Imon1", "Vmon1", "AD0")){
  #sig = c("Imon-1", "Vmon-1", "AD-0")

  mat <- as.data.frame(readMat(lf)) %>%
    .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
    rename_at(1, ~"Time") %>% # Rename first column to Time
    mutate_at(vars(Time), funs(.*1000)) #Convert to ms from S

  mat <- mat[-grep(".1$", names(mat))]
  names(mat) <- gsub("1.2$", sig[1], names(mat))
  names(mat) <- gsub("2.2$", sig[2], names(mat))
  names(mat) <- gsub("3.2$", sig[3], names(mat))



  return(mat)

}



lf <- list.files("data", pattern = "a-ZeroChR2-6.mat", recursive = TRUE, full.names = TRUE)

mat <- ZeroChR2.mat(lf)

Imon1 = mat[,grep(pattern = "(Time|Imon1)", names(mat))]
Vmon1 = mat[,grep(pattern = "(Time|Vmon1)", names(mat))]
AD0 = mat[,grep(pattern = "(Time|AD-0)", names(mat))]

Imon1ROI <- slice(Imon1, head(which(Imon1$Time > 1500))[1]:head(which(Imon1$Time >1900))[1])

Imon1ROI <- as.data.frame(lapply(Imon1ROI, bl_adjust)) %>% melt(., id.vars = "Time")


Imon1melt <- as.data.frame(lapply(Imon1ROI, bl_adjust)) %>% melt(., id.vars = "Time")


ggplot(Imon1melt, aes(x = Time, y = value, group = variable))+
  geom_line()+
  theme_void()




plot(Imon1ROI$Time, Imon1ROI$Trace.1.6.5.Imon1, type = "l")



mat <- as.data.frame(readMat(lf)) %>%
  .[!duplicated(lapply(.,summary))] %>%
  rename_at(1, ~"Time") %>% # Rename first column to Time
  mutate_at(vars(Time), funs(.*1000))
mat <- mat[-grep(".1$", names(mat))]
names(mat)
tst <- sapply(1:length(sig), function(x){
  n = names(mat)
  l = paste0(x,".2$")
  n <- gsub(l, sig[x], n)
  return(n)
})

tst
