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
fdir <- wcA$fdir

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
    SA <- as.numeric(wcA$fdir[f,"SA"])
    dt2 <- apply(dt, 2, bl_adjust, r = p0:Bl)
    dtr <- dt2[(SA-100):(SA+1000),]
}))



AMPA <- which(wcA$fdir$protocol == "AMPA")
x0 = as.data.frame(wcA$Data[AMPA])[8000:10000,]
ms <- x0[,1]
x1 = x0[,-c(grep("Time", names(x0)))]
rownames(x1) <- ms


NMDA <- which(wcA$fdir$protocol == "NMDAr")
NMDAtr <- wcA$fdir[AMPA,"Treatment"]

x <- fdir[NMDAr,]


rownames(x1)

x2 <- as.data.frame(apply(x1, 2, bl_adjust, r = 9500:10000))
x3 <- x2[8000:10000,]
tst <- sapply(x3, max)
plot(tst)


i = 5
p <- wcA$Protocol[i,]

p1 <- as.numeric(str_split(tst, ":", simplify = TRUE))[1]
p2 <- as.numeric(str_split(tst, ":", simplify = TRUE))[2]
dtROI <- x[p1:p2,]
plot(dtROI[,4])
identify_points()

for(i in 1:length(wcA$Data)){
p





TP <- x[tst[1]:tst[2],]





}










