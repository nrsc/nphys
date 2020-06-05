library(readABF)

lf <- list.files("dir/wc_slices", pattern = "SliceMD.csv", recursive = TRUE, full.names = TRUE)
l = lf[grep("17714.P1", lf)]


for(l in lf){
    sA <- list()
    sA$wd = wrkD(l)
    sA$md <- read.csv(l)
    print(sA$md)
    sA$files <- list.files(sA$wd, pattern = ".abf", full.names = TRUE, recursive = TRUE)
    sA$ABF <- lapply(sA$files, readABF::readABF)
    sA$pro <- read.table(list.files(sA$wd, pattern = "Pro.csv", full.names = TRUE),header = TRUE)
    names(sA$ABF) <- sA$pro$protocol
    sA$fthr <- sapply(names(sA$ABF), simplify = TRUE, function(x){
        dfs <- list()
        pf <- parent.frame()$i[]
        print(pf)
        dt <- data.frame(sA$ABF[[x]]["data"])
        f <- sA$pro[pf,]
        sigs <- rep_len(unlist(sA$ABF[[x]]["channelUnits"]), ncol(dt))
        # apply fthr sequence to IV
        if(grepl("IV", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$p0)+10000),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs,1:ncol(dfs), sep = "-")
        }
        # apply fthr sequence to IO
        if(grepl("IO", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$EPSC)+1200),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
        }
        # apply fthr sequence to PP
        if(grepl("PP", x)){
            dfs = dt[seq(as.numeric(f$p0),f$n),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
        }
        # apply fthr sequence to AMPA protocol
        if(grepl("AMPA", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$EPSC)+1200),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
            }
        # apply fthr sequence to NMDAr protocol
        if(grepl("NMDAr", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$EPSC)+1200),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,2], main = x)

            }

        return(dfs)

    })

f= gsub("-SliceMD.csv", ".rda", l)
save(sA, file = f)
}

