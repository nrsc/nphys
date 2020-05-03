### Run IO
load_sA("field")
#Select data

dfSweeps <- NULL
for(i in 1:length(sA$Data)){
# i = 1
tst = sA$Data[i]
names(tst)

#Get Protocol for analysis
if(grepl("IO",names(tst))==TRUE){pro = "IO"}
if(grepl("PP",names(tst))==TRUE){pro = "PP"}
if(grepl("Bl",names(tst))==TRUE){pro = "Bl"}
if(grepl("Cond",names(tst))==TRUE){pro = "Cond"}
if(grepl("Decay",names(tst))==TRUE){pro = "Decay"}

#Convert to DF and adjust baseline
tst0 <- data.frame(tst) %>%
    column_to_rownames(., colnames(.)[1]) %>%
    sapply(., function(x){
        df = NULL
        tst <- bl_adjust(x)
        df <- cbind(df, tst)
        })

#plot(1:nrow(tst0), tst0[,ncol(tst0)])
#plot(1:length(tst0), tst0)

# melt(tst0, value.name = "mV") %>%
#     ggplot(., aes(Var1, mV, colour = Var2)) +
#     geom_line() +
#     scale_color_grey(start = 0.8, end = 0.2)+
#     ylim(-2, 0.2) +
#     theme_pubclean()+
#     theme(legend.position = "none")


tst1 <- slpRead(tst0[,ncol(tst0)])
#plot(1:length(tst1), tst1)
if(which.max(tst1[1:3000]) > 1500){SA = 1500}
if(which.max(tst1[1:3000]) < 1500){SA = 1000}
if(pro == "PP"){
    SA1 = SA
    SA2 = SA+5000
    pulse1 = data.frame(tst0[SA1:(SA1+1500),])
    pulse2 = data.frame(tst0[SA2:(SA2+1500),])
    tst0 = bind_cols(pulse1, pulse2)
}else{
    tst0 = tst0[SA:(SA+1500),]
    }


dfSweeps <- cbind(dfSweeps, tst0)


}

write_feather(dfSweeps, "./exa/field/field.feather")
dfeather <- read_feather("./exa/field/field.feather")

names(dfeather)


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


