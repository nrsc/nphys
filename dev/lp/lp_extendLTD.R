
df <- data.frame(x = sA$fctr$Time,y= sA$fctr$slopeEPSP, Sw = sA$fctr$Pro.Sweep)
avg = mean(df[seq((head(grep("Cond", df$Sw), 1)-1)-w-20, (head(grep("Cond", df$Sw), 1)-1)-w),"y"])
df$pCh <- df$y/avg*100
df$x = df$x - df$x[(head(grep("Cond", df$Sw), 1)-1)]

df <- df[-grep("IO|PP", df$Sw),]

ggplot(df, aes(x, pCh)) +
    geom_point() +
    #scale_x_continuous(breaks = seq(-15,75,by = 15), labels = seq(-15,75,by = 15))+
    #scale_y_continuous(breaks = seq(25,125,by = 25), labels = seq(25,125,by = 25), limits = c(25,125))+
    geom_hline(yintercept = 100, linetype = "dashed") +
    ylab("EPSP slope %") +
    xlab("Time (Minutes)")+
    theme_pubr()

#ggsave("Presentation/exaLFS.png", height=2,width=10,units="in",type="cairo-png", dpi = 300)



