library(nphys)
library(ggplot2)
grDevices::png("figs/ap.png", width = 6, height = 2, units = "in", res = 300)
ggplot(ccExa$ap, aes(x = ms, mV))+
    geom_line()+
    theme_void()
dev.off()
