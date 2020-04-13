lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
load(lf[1])
print(which(lf == j))



for (j in lf[1:length(lf)]){
        load(j)
        
        clm <- sapply(wcA$Data, function(x){
                n <- nrow(x)
                n1 <- ncol(x)
                clm <- c(n,n1)
                return(clm)
        }) %>% 
                t()
protocolDir <- NULL

print(wcA$wd)

for (i in 1:nrow(clm)){
        #i = 3
        n = as.numeric(clm[i,1])
        n1 = as.numeric(clm[i,2])

        if(n == 15000 &
           n1 == 10) {
                protocol = "IV curve"
                ROI = c("1:10000")
                Pts = c("6500:6700")
                Bla <- c("200:600")
                TP <- NA
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 13000 & n1 == 6) {
                protocol = "IO"
                ROI = c("500:1500")
                Pts = c("650")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 15000 & n1 == 5) {
                protocol = "AMPAr_NMDAr"
                ROI = c("8000:10000")
                Pts = c("8250")
                Bla = c("7500:8000")
                TP  = c("1:1000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 15000 & n1 == 3) {
                protocol = "AMPAr"
                ROI = c("8000:10000")
                Pts = c("8250")
                Bla = c("7500:8000")
                TP  = c("1:1000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 15000 & n1 == 2) {
                protocolDir[[i]] = NA
        }
        if (n == 2600 & n1 == 5) {
                protocol = "PP"
                ROI = c("500:2000")
                Pts = c("500")
                Bla = c("1:500")
                TP  = NA
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 2600 & n1 == 4) {
                protocol = "PP"
                ROI = c("500:2000")
                Pts = c("500:1500")
                Bla = c("1:500")
                TP  = NA
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 13000 & n1 == 9) {
                protocol = "AMPA"
                ROI = c("500:1500")
                Pts = c("700")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 17000 & n1 == 5) {
                protocol = "AMPAr_NMDAr"
                ROI = c("10000:12000")
                Pts = c("10250")
                Bla = c("9500:10000")
                TP  = c("1:1000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 17000 & n1 == 2) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 13000 & n1 == 4) {
                protocol = "IO"
                ROI = c("500:1500")
                Pts = c("700")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 17000 & n1 == 3) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 32000 & n1 == 3) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 32000 & n1 == 4) {
                protocol = "IO"
                ROI = c("1000:2000")
                Pts = c("1000")
                Bla = c("1:850")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 13000 & n1 == 7) {
                protocol = "IO"
                ROI = c("750:1750")
                Pts = c("750")
                Bla = c("1:500")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 16000 & n1 == 10) {
                protocol = "IV curve"
                ROI = c("1:10000")
                Pts = c("6500:6700")
                Bla <- c("200:600")
                TP <- c("14000:15500")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 4) {
                protocol = "AMPA"
                ROI = c("500:1500")
                Pts = c("700")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 21000 & n1 == 4) {
                protocol = "NMDAr"
                ROI  = c("10500:12000")
                Pts = c("700")
                Bla = c("1:600")
                TP = NA
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 19) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 15000 & n1 == 7) {
                protocol = "NMDAr"
                ROI  = c("6000:8000")
                Pts = c("6250")
                Bla = c("6000:6200")
                TP = c("13000:14500")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 8) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 7) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 6) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 3) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 10) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 15000 & n1 == 4) {
                protocol = "NMDAr"
                ROI = c("8000:10000")
                Pts = c("8250")
                Bla = c("8000:8200")
                TP  = c("1:1000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 16000 & n1 == 7) {
                protocol = "NMDAr"
                ROI = c("10000:12000")
                Pts = c("10250")
                Bla = c("10000:10200")
                TP  = NA
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 2600 & n1 == 2) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 18000 & n1 == 13) {
                protocol = "AMPA"
                ROI = c("700:1700")
                Pts = c("780")
                Bla = c("1:600")
                TP  = c("10500:12000")
                protocolDir[[i]] <-
                        cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        if (n == 2600 & n1 == 3) {
                protocol = NA
                ROI = NA
                Pts = NA
                Bla = NA
                TP  = NA
                protocolDir[[i]] <- cbind(n, n1, protocol, ROI, Pts, Bla, TP)
        }
        
        
}
        
protocolDir <- do.call(rbind, protocolDir)        
colnames(protocolDir) <- c("n","n1", "protocol", "ROI", "Stim0", "BlRegion", "TestPulse")
names(wcA$Data) <- protocolDir[,3]
wcA$Protocol <- protocolDir
save(wcA, file = j)

}

#write.table(wcA$Protocol, file = gsub(".rda", "-Pro.csv", i), sep = ",", col.names = TRUE, row.names = FALSE)
       
#wcA <- wcImport(i, "atf")
#n <- paste0(i, ".rda")
#wd <- wcA$wd
#paste(wd, n, sep = "/")




