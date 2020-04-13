dfeather <- read_feather("./exa/field/field.feather")

BlAvg <- data.frame(rowMeans(dfeather[,tail(grep("Bl", names(dfeather)),20)])) %>%
    set_colnames("mV") %>%
    add_column(Time = as.numeric(rownames(.)), .before = 1)

yMin <- min(BlAvg$mV[150:800])*1.5
plot(mV ~ Time,data = BlAvg, type = "l", ylim = c(yMin,0.2))
print("Pick identifiers")
pts <- BlAvg[identify(BlAvg$Time, BlAvg$mV, n = 3),]

pts

sweep <- BlAvg$mV

stimA <- sweep[0:(pts$Time[1]+15)]
fVolley <- sweep[(pts$Time[1]-15):(pts$Time[2]+15)]
fEPSP <- sweep[(pts$Time[2]-15):(pts$Time[3]+15)]
fEPSPdecay <- sweep[(pts$Time[3]-15):length(sweep)]

swPts <- NULL
swPts$p1 <- which(sweep == max(fVolley))
swPts$p2 <- which(sweep == min(fVolley))
swPts$p3 <- which(sweep == max(fEPSP))
swPts$p4 <- which(sweep == min(fEPSP))
if(sweep[p2] == sweep[p3]){FV = FALSE}else{FV = TRUE}

swPts_0 <- data.frame(swPts)

swPts_0 <- cbind(swPts, sapply(swPts, function(x){sweep[x]}))





