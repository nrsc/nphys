library(stringr)
wcUI <- readODS::read_ods("data/wcAnalysis.ods", col_names = TRUE)
lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
#x = unique(wcUI$Cell)[1]
df = NULL
l = lf[4]
#l = lf[grep("17818.P1", lf)]

#sA$DATA$NMDA

#data = lapply(unique(wcUI$Cell), function(x){
for(l in lf){
    load(l)

    wc = wcUI[grep(sA$md$Cell, wcUI$Cell),]
    print(sA$md)

    msInt = unique(dfs_ABF(sA$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000 # Change from S to ms


    Bl = sA$fthr[as.numeric(str_split(wc$NMDAr_Con, pattern = ",", simplify = TRUE))]
    Bl = as.data.frame(lapply(Bl, function(x){
        x = as.data.frame(x)[1:1450,]
        })) %>%
        mutate(avg = rowMeans(.)) %>%
        mutate(ms = seq(msInt, length.out = nrow(.), by = msInt))

    EtOH = as.data.frame(sA$fthr[as.numeric(str_split(wc$NMDAr_Et, pattern = ",", simplify = TRUE))])
    EtOH = as.data.frame(lapply(EtOH, function(x){
        x = as.data.frame(x)[1:1450,]
    })) %>%
        mutate(avg = rowMeans(.)) %>%
        mutate(ms = seq(msInt, length.out = nrow(.), by = msInt))

    stim = head(unique(apply(Bl[,-grep("ms", names(Bl))], 2, stimArtifact)),1)
    p5ms = stim + 50
    pZero = stim + which.min(Bl[stim:p5ms,1])
    p50ms = pZero+550
    blData = Bl[c(pZero, p50ms),]
    etData = EtOH[c(pZero, p50ms),]

    Change = etData$avg[2]/blData$avg[2]

    sA$DATA = NULL
    sA$DATA$NMDA = list(blDATA = blData, etDATA = etData, Change = Change)

    if(grepl("DGDev", sA$wd)){
        print("DGDev in wd")
        sA$wd = gsub("DGDev/", "", sA$wd)
    }


    save(sA, file = l)



   dt = data.frame(
       Cell = sA$md$Cell,
       Treatment = sA$md$Treatment,
       AgeGroup = sA$md$AgeGroup,
       Bl_avg = blData$avg[2],
       Et_avg = etData$avg[2],
       Change = Change
   )

   df = rbind(df, dt)




df = df[!duplicated(df$Cell),]
write.table(df, file = "data/wcBlvEt_data.csv", sep = ",", row.names = FALSE)

}
