## Current Clamp analysis and presentation
#library(R.matlab)
#library(readODS)
#lf <- list.files("exa", full.names = TRUE)
#x = lf[7]


# Set up data

mat <- as.data.frame(readMat(x)) %>% # Original DAT file projRTT_2019-08-20_004.dat; A1_CCinj_9
  .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
  rename_at(1, ~"Time") %>% # Rename first column to Time
  mutate_at(vars(Time), funs(.*1000)) #Convert to ms from S

names(mat) <- gsub("1.2$", Channels[1], names(mat))
names(mat) <- gsub("2.2$", Channels[2], names(mat))
names(mat) <- gsub("3.2$", Channels[3], names(mat))

Vmon1 <- mat[,grep(pattern = "(Time|Vmon-1)$", names(mat))] %>%
  #melt(., id.vars = "Time") %>%
  mutate_at(., vars(-"Time"), funs(.*1000)) #Convert to mV from V

Imon1 <- mat[,grep(pattern = "(Time|Imon-1)$", names(mat))] %>%
  #melt(., id.vars = "Time") %>%
  mutate_at(., vars(-"Time"), funs(.*1e12)) #Convert to pA




mltVmon1 <- melt(Vmon1, id.vars = "Time")

plot(mltVmon1$Time, mltVmon1$value, col=mltVmon1$variable, ylab = "mV", xlab = "Time (ms)", type = "p")
