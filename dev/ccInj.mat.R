## Current Clamp analysis and presentation
library(R.matlab)
library(readODS)
library(tidyverse)
library(reshape2)
library(pracma)
library(ggpubr)
library(grid)
library(gridExtra)
# Set up data

mat <- as.data.frame(readMat("exa/exaCCinj_2.mat")) %>% # Original DAT file projRTT_2019-08-20_004.dat; A1_CCinj_9
  .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
  rename_at(1, ~"Time") %>% # Rename first column to Time
  mutate_at(vars(Time), funs(.*1000)) #Convert to ms from S

names(mat) <- gsub("1.2$", "mV", names(mat))
names(mat) <- gsub("2.2$", "pA", names(mat))

names(mat)
str(mat)

Vmon1 <- mat[,grep(pattern = "(Time|mV)$", names(mat))] %>%
  mutate_at(., vars(-"Time"), funs(.*1000)) %>%  #Convert to mV from V
  reshape2::melt(., id.vars = "Time")

Imon1 <- mat[,grep(pattern = "(Time|pA)$", names(mat))] %>%
  mutate_at(., vars(-"Time"), funs(.*1e12)) %>%  #Convert to pA
  reshape2::melt(., id.vars = "Time")

spikes <- sapply(unique(Vmon1$variable), function(x){
  df <- Vmon1[which(Vmon1$variable == x),]
  ret = nrow(pracma::findpeaks(df$value,minpeakheight = 10,nups = 2,ndowns = 2))
  ret[is.null(ret)] <- 0
  return(ret)
})

spikes <- cbind.data.frame(spikes = spikes,
                            Iinj = seq(round(min(Imon1$value),-2), by = 30, length.out = length(spikes)))

# Create plots
p1 <- ggplot(Vmon1, aes(x = Time, y = value, group = variable)) +
  geom_line() +
  geom_segment(x=350, xend = 400, y= -20, yend=-20) +
  geom_segment(x=350, xend = 350, y= -20, yend=0) +
  #annotate("text", x=340, y = -10, label = "20mV", angle = 90) +
  #annotate("text", x = 375, y=-15,label = "50ms") +
  theme_void()#; print(p1)

p2 <- ggplot(Imon1, aes(x = Time, y = value, group = variable)) +
  geom_line(colour = "red")+
  geom_segment(x=350, xend = 400, y= 300, yend=300) +
  geom_segment(x=350, xend = 350, y= 300, yend=400) +
  #annotate("text", x=340, y = 360, label = "100pA", angle = 90) +
  #annotate("text", x = 375, y=360, label = "50ms") +
  theme_void()#; print(p2)

p3 <- ggplot(spikes, aes(x = Iinj, y = spikes))+
  geom_point()+
  xlab("Current")+
  ylab("Number of Spikes")+
  xlim(0,NA)+
  theme_pubr()+
  theme(plot.margin = margin(.1,.1,.1,.1, unit = "cm"))





gg <- arrangeGrob(p1,p2,p3,
                   layout_matrix = rbind(c(NA,NA,1,1,1,1,1,1),
                                         c(3,3,1,1,1,1,1,1),
                                         c(NA,1,1,1,1,1,1,1),
                                         c(NA,1,1,1,1,1,1,1),
                                         c(NA,1,1,1,1,1,1,1),
                                         c(NA,1,1,1,1,1,1,1),
                                         c(NA,2,2,2,2,2,2,2)))


ggsave("figs/spikeCount.png", gg, type = "cairo", dpi = 300, height = 12, width = 10, units = "in")

