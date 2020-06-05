#lf <- list.files("dir/wc_slices", pattern = "SliceMD.csv", recursive = TRUE, full.names = TRUE)
lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
i = lf[1]


for(l in lf){
    load(l)
    print(sA$md)
    sA$pro <- read.table(list.files(sA$wd, pattern = "Pro.csv", full.names = TRUE), header = TRUE)
    #write.table(sA$pro, file = gsub(".rda", "-Pro.csv", i), row.names = FALSE)
    #sA$pro$protocol <- paste(sA$pro$protocol, 1:length(sA$pro$protocol), sep = "-")
    sA$files <- list.files(sA$wd, pattern = ".abf", full.names = TRUE, recursive = TRUE)
    sA$ABF <- lapply(sA$files, readABF)
    names(sA$ABF) <- sA$pro$protocol
    sA$fthr <- sapply(names(sA$ABF), simplify = TRUE, function(x){
        dfs <- list()
        pf <- parent.frame()$i[]
        print(pf)
        dt <- data.frame(sA$ABF[[x]]["data"])
        f <- sA$pro[pf,]
        sigs <- rep_len(unlist(sA$ABF[[x]]["channelUnits"]), ncol(dt))

        if(grepl("IV", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$p0)+10000),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs,1:ncol(dfs), sep = "-")
        }

        if(grepl("IO", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$EPSC)+1200),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
        }
        if(grepl("PP", x)){
            dfs = dt[seq(as.numeric(f$p0),f$n),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
        }

        if(grepl("AMPA", x)){
            dfs = dt[seq(as.numeric(f$p0),as.numeric(f$EPSC)+1200),]
            dfs <- data.frame(apply(dfs, 2, function(x){
                tst = zeroAdjust(x, r = diff(c(f$p0,f$Bl)))
            }))
            colnames(dfs) <- paste(x,"Sweep",sigs, 1:ncol(dfs), sep = "-")
            plot(dfs[,1], main = x)
            }

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
    save(sA, file = l)
}

