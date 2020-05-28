## Current Clamp analysis and presentation
library(R.matlab)
library(readODS)

Pros <- read_ods("exp/Protocols.ods",col_names = TRUE)
# Set up data

mat <- as.data.frame(readMat("exa/mat/exaCCinj_2.mat")) %>% # Original DAT file projRTT_2019-08-20_004.dat; A1_CCinj_9
  .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
  rename_at(1, ~"Time") %>% # Rename first column to Time
  mutate_at(vars(Time), funs(.*1000)) #Convert to ms from S




p <- Pros[which(Pros$Samples == nrow(mat)),]
p
Channels <- str_split(Pros$Channels[p], pattern = ";", simplify = TRUE)


names(mat) <- gsub("1.2$", Channels[1], names(mat))
names(mat) <- gsub("2.2$", Channels[2], names(mat))
names(mat) <- gsub("3.2$", Channels[3], names(mat))
names(mat)

# sapply(names(mat), function(x){
#     Ch = paste0(, ".2$")
#   tst = gsub(Ch, Channels[x], tst)
#   return(tst)
#  })


Vmon1 <- mat[,grep(pattern = "(Time|Vmon-1)$", names(mat))] %>%
  melt(., id.vars = "Time") %>%
  mutate_at(., vars(-"Time"), funs(.*1000)) #Convert to mV from V

Imon1 <- mat[,grep(pattern = "(Time|.2.2)$", names(mat))] %>%
  melt(., id.vars = "Time") %>%
  mutate_at(., vars(value), funs(.*1e12)) #Convert to pA

spikes <- sapply(unique(Vmon1$variable), function(x){
  df <- Vmon1[which(Vmon1$variable == x),]
  ret = nrow(findpeaks(df$value,minpeakheight = 10,nups = 2,ndowns = 2))
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
  annotate("text", x=340, y = -10, label = "20mV", angle = 90) +
  annotate("text", x = 375, y=-15,label = "50ms") +
  theme_void()#; print(p1)

p2 <- ggplot(Imon1, aes(x = Time, y = value, group = variable)) +
  geom_line(colour = "red")+
  geom_segment(x=350, xend = 400, y= 300, yend=300) +
  geom_segment(x=350, xend = 350, y= 300, yend=400) +
  annotate("text", x=340, y = 360, label = "100pA", angle = 90) +
  annotate("text", x = 375, y=360, label = "50ms") +
  theme_void()#; print(p2)

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


ggsave("figs/ccExa_2.png", gg, type = "cairo-png", dpi = 300, height = 10, width = 10, units = "in")

