lf <-
    list.files(
        "exa/WC",
        pattern = "SliceMD.csv",
        recursive = TRUE,
        full.names = TRUE
    )

#load(lf[1])
wd <- wrkD(lf[1])
fd <- gsub("-SliceMD.csv", "", fileD(lf[1]))
wcA <- wc_Import("fd")
wcA$Metadata
AmNm <- which(wcA$fdir$protocol == "AMPA" | wcA$fdir$protocol == "NMDA")

tst <- unlist(apply(wcA$fdir[AmNm,], 1, function(x){
    s0 <- x["Treatment"]
    s1 <- as.numeric(x["n1"])-1
    s <- rep(s0, s1)
}))

#tst0 <- gsub(2, "100mM", gsub(1, "50mM", gsub(0, "Control", tst)))

tst2 <- unlist(apply(wcA$fdir[AmNm,], 1, function(x){
    s0 <- x["protocol"]
    s1 <- as.numeric(x["n1"])-1
    s <- rep(s0, s1)
}))

exp <- t(rbind(Protocol = tst2, Treatment = tst))

names(wcA$Data)

df <- data.frame(lapply(names(wcA$Data[AmNm]), function(x){
    f <- which(wcA$fdir$files == x)
    dt <- data.frame(wcA$Data[x])
    dt <- dt[,-c(grep("Time", names(dt)))]
    p0 <- as.numeric(wcA$fdir[f,"p0"])
    Bl <- as.numeric(wcA$fdir[f,"Bl"])
    SA <- as.numeric(wcA$fdir[f,"EPSC"])
    dt2 <- apply(dt, 2, bl_adjust, r = p0:Bl)
    dtr <- dt2[(SA-100):(SA+1000),]
}))


plot(df[[1]][100:500])


####





