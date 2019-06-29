dfeather <- read_feather("./exa/field/field-d.feather")
dfactors <- read.csv("./exa/field/field-dfactors.csv")
dfCom <- read.csv("./data/sAnalysisLFS.csv")
Slices <- as.character(dfCom$Slice)
names(dfCom)
Blsweeps <- which(grepl("PreC.Bl", dfactors$Sweep))


dt1 <- as.numeric(dfactors$slopeEPSP[Blsweeps])
dt2 <- dfactors$slopeEPSP[grep("Decay", dfactors$Sweep)]
dtSw <- c(tail(dt1,60), head(dt2, 240))
LTDpchange(dtSw, ret = FALSE)

dt2.1 <- as.numeric(dfactors$EPSPmin[Blsweeps])
dt2.2 <- dfactors$EPSPmin[grep("Decay", dfactors$Sweep)]
dtSw2 <- c(tail(dt2.1,60), head(dt2.2, 240))
LTDpchange(dtSw2, ret = FALSE)

dt3.1 <- as.numeric(dfactors$stimAmin[Blsweeps])
dt3.2 <- dfactors$stimAmin[grep("Decay", dfactors$Sweep)]
dtSw3 <- c(tail(dt3.1,60), head(dt3.2, 240))
LTDpchange(dtSw3, ret = FALSE)

dt4.1 <- as.numeric(dfactors$mVd[Blsweeps])
dt4.2 <- dfactors$mVd[grep("Decay", dfactors$Sweep)]
dtSw4 <- c(tail(dt4.1,60), head(dt4.2, 240))
LTDpchange(dtSw4, ret = FALSE)


f = "mVd"
dtEx1 <- as.numeric(dfactors[[f]][Blsweeps])
dtEx2 <- dfactors[[f]][grep("Decay", dfactors$Sweep)]
dtEx <- c(tail(dtEx1, 60), head(dtEx2, 240))
LTDpchange(dtEx, ret = FALSE)



#load_sA("field")
t_BlvDe(sA)




