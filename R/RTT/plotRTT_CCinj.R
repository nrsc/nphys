load("C:/Users/sdsaw/projRTT/dir/slices/2019-12-10_S2/P2/2019-12-10_S2_P2.rda")
ampX <- rda$Data$ampA
x = ampX$`a-CCinj-4`

Vmon1 <- x$Vmon1 %>%
  melt(., id.vars = "Time") %>%
  mutate_at(., vars("Time"), funs(.*1000)) %>%
  mutate_at(., vars(value), funs(.*1000)) #Convert to mV from V

Imon1 <- x$Imon1 %>%
  mutate_at(., vars("Time"), funs(.*1000)) %>%
  melt(., id.vars = "Time") %>%
  mutate_at(., vars(value), funs(.*1e12))


traces <- unique(Vmon1$variable)

p1 <-
  ggplot(subset(Vmon1, variable == "Trace.1.4.8.Vmon1"),
         aes(x = Time, y = value)) +
  geom_line() +
  theme_void()

  #geom_segment(x=350, xend = 400, y= -20, yend=-20) +
  #geom_segment(x=350, xend = 350, y= -20, yend=0) +
  #annotate("text", x=340, y = -10, label = "20mV", angle = 90) +
  #annotate("text", x = 375, y=-15,label = "50ms") +

p2 <- ggplot(Imon1, aes(x = Time, y = value, group = variable)) +
  geom_line(colour = "red")+
  geom_segment(x=350, xend = 400, y= 300, yend=300) +
  geom_segment(x=350, xend = 350, y= 300, yend=400) +
  annotate("text", x=340, y = 360, label = "100pA", angle = 90) +
  annotate("text", x = 375, y=360, label = "50ms") +
  theme_void()#; print(p2)

spikes <- sapply(unique(Vmon1$variable), function(s){
  df <- Vmon1[which(Vmon1$variable == s),]
  ret = nrow(findpeaks(df$value,minpeakheight = 10,nups = 2,ndowns = 2))
  ret[is.null(ret)] <- 0
  return(ret)
})

spikes <- cbind.data.frame(spikes = spikes,
                           Iinj = seq(round(min(Imon1$value),-2), by = 30, length.out = length(spikes)))

p3 <- ggplot(spikes, aes(x = Iinj, y = spikes))+
  geom_point()+
  xlab("Current")+
  ylab("Number of Spikes")+
  theme_pubr()+
  theme(plot.margin = margin(1,1,1,1, unit = "cm"))





gg <- grid.arrange(p1,p2,p3,
                   layout_matrix = rbind(c(1,1,1,3,3),
                                         c(1,1,1,3,3),
                                         c(1,1,1,1,1),
                                         c(1,1,1,1,1),
                                         c(1,1,1,1,1),
                                         c(2,2,2,2,2)))



