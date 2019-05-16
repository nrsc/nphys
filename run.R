### Run IO
tst = sA$Data[1]
names(tst)
sapply(as.data.frame(tst)[,-1], function(x, SA = 1500){
df = NULL
tst <- data.frame(x)
tst1 <- data.matrix(tst)
tst2 <- tst1[,ncol(tst1)]
tst3 <- bl_adjust(tst2)
#plot(1:length(tst3), tst3)
#tst4 <- slpRead(tst3)
#if(which.max(tst4) > 1500){SA = 1500}
#if(which.max(tst4) < 1500){SA = 1000}
tst5 = tst3[SA:(SA+1500)]

df <- cbind(df, tst5)
return(df)

}) %>%
    melt(., value.name = "mV") %>%
    ggplot(., aes(Var1, mV, colour = Var2)) +
    #stat_summary(fun.y = mean, geom = "line") +
    geom_line() +
    #scale_color_grey(start = 0.8, end = 0.2)+
    ylim(-2, 0.2) +
    theme_pubclean()+
    theme(legend.position = "none")

## Run PP
tst = sA$Data[2]
names(tst)
sapply(as.data.frame(tst)[,-1], function(x, SA = 1000){
    df = NULL
    tst <- data.frame(x)
    tst1 <- data.matrix(tst)
    tst2 <- tst1[,ncol(tst1)]
    tst3 <- bl_adjust(tst2)
    #plot(1:length(tst3), tst3)
    #tst4 <- slpRead(tst3)
    #if(which.max(tst4) > 1500){SA = 1500}
    #if(which.max(tst4) < 1500){SA = 1000}
    tst5 = tst3[SA:(SA+7000)]

    df <- cbind(df, tst5)
    return(df)

}) %>%
    melt(., value.name = "mV") %>%
    ggplot(., aes(Var1, mV)) +
    stat_summary(fun.y = mean, geom = "line") +
    #geom_line() +
    #scale_color_grey(start = 0.8, end = 0.2)+
    ylim(-2, 0.2) +
    theme_pubclean()+
    theme(legend.position = "none")



# Means

df_mean <- rowMeans(df)
dfmelt_mean <- melt(df_mean, value.name = "mV")
rownames(tst)


