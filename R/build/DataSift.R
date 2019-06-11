lf <- mixedsort(list.files("dir.link/f_Slices", pattern = ".sAna.rda", recursive = TRUE, full.names = TRUE))
load(lf[4])


#function(x){

Bl0 <- sAna$LTD$Baseline
De0 <- sAna$LTD$Decay
x = Bl0$data

rownames(x) = x[,1]
x = x[1501:3000,-1]
x = x[,tail(1:ncol(x), 80)]
rownames(x) <- seq(0,14.99, by = 0.01)

dfBl = list("data" = x)

dfBl$BlAvg <- rowMeans(dfBl$data[,tail(colnames(dfBl$data), 20)]) %>%
    Slope.Read_0()# %>%




#}

