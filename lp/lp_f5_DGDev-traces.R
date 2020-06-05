# This identifies the CSV file that is saved while doing an experiment. Generating the
# csv file requires UI and is generally the output of newSlice
library(nphys)
l.rda <- list.files("dir/DGDev/f_slices", pattern = "-sA.rda", recursive = TRUE, full.names = TRUE)
l.DGDev.rda <- list.files("dir/DGDev/f_slices", pattern = "-DGDev.rda", recursive = TRUE, full.names = TRUE)

l.rda[]
load(l.DGDev.rda[24])
l = l.rda[24]
l
which(l == l.rda)

for(l in l.rda){
    load(l)
    DGDev = sA[c("wd", "md", "files", "ABF")]
    print(DGDev$md)

    rm(sA)

    if(grepl("js", DGDev$md$Slice)){
        print("Writing js csv")
        write.csv(DGDev$md, file = list.files(DGDev$wd, pattern = ".csv", full.names = TRUE))
    }



    sampleInt.ms <- unique(dfs_ABF(field$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000
    if(length(sampleInt.ms)>1)stop("Different sample frequencies")

    adjNeg <- -100 # How far in front of the (first) stim
    adjPos <- 1400 # How far behind the (last) stim

    if(!grepl("Control", DGDev$md$Group)){
        if(!grepl("js", DGDev$md$Slice)){
            isol <- pullSweeps(DGDev$ABF) %>%  IsolateWsh(., Wsh = 20)
        }
        if(grepl("js", DGDev$md$Slice)){
            isol <- pullSweeps(DGDev$ABF) %>%  IsolateWsh(., Wsh = 60)
        }
        traces <- list()

            traces$ms = seq(sampleInt.ms, length.out = sum(abs(adjNeg), abs(adjPos),1), by =sampleInt.ms)

            traces$blTrace = pullSweeps(DGDev$ABF)[,-isol$WshSweeps] %>%
                avgSweeps() %>% zeroAdjust()

            traces$washTrace = pullSweeps(DGDev$ABF)[,isol$WshSweeps] %>%
                avgSweeps() %>% zeroAdjust()


            traces$decayTrace = pullSweeps(DGDev$ABF, pull = "Decay") %>%
                avgSweeps()  %>% zeroAdjust()



            if(length(DGDev$ABF$Cond$data)==1){
                traces$condTrace = unlist(DGDev$ABF$Cond$data) %>% fthrStim() %>% zeroAdjust()
            }else{
                traces$condTrace = pullSweeps(DGDev$ABF, pull = "Cond") %>%
                    avgSweeps(.) %>%
                    zeroAdjust(.)
            }

            DGDev$traces <- traces


    }
    if(grepl("Control", DGDev$md$Group)){
            traces <- list()

            traces$ms = seq(sampleInt.ms, length.out = sum(abs(adjNeg), abs(adjPos),1), by =sampleInt.ms)

            traces$blTrace = pullSweeps(DGDev$ABF) %>%
                    avgSweeps(.) %>%
                    zeroAdjust(.)

            traces$washTrace = NA


            traces$decayTrace = pullSweeps(DGDev$ABF, pull = "Decay") %>%
                    avgSweeps(.) %>%
                    zeroAdjust(.)



           if(length(DGDev$ABF$Cond$data)==1){
            traces$condTrace = unlist(DGDev$ABF$Cond$data) %>% fthrStim() %>% zeroAdjust()
                         }else{
            traces$condTrace = pullSweeps(DGDev$ABF, pull = "Cond") %>%
                    avgSweeps(.) %>%
                    zeroAdjust(.)
           }

            DGDev$traces <- traces

            }


f = gsub("-sA","-DGDev", l)
save(DGDev, file = f)
}
