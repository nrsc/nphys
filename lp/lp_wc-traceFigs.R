# DGDev loop template
library(ggpubr)
library(magrittr)
library(readABF)
library(stringr)
library(nphys)
library(gginnards)

lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
l = lf[1]
lf = lf[-grep("100mM", lf)]



for(l in lf){
    load(l)
    print(sA$md)
    names(sA$fthr)
    msInt = unique(dfs_ABF(sA$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000

dir = file.path("figs/refTracs_wc", paste(sA$md$Treatment, sA$md$Cell, sep = "-"))
ifelse(!dir.exists(dir), dir.create(dir), next)


#x = names(sA$fthr)[4]

lapply(names(sA$fthr), function(x){

        # Count
        i = parent.frame()$i[]

        pro = sA$pro[sA$pro$protocol %in% x,] # New way
        #pro = sA$pro[grep(x, sA$pro$protocol),]


        ## Select traces
        traces = data.frame(sA$fthr[x])
        traces <- traces[,c(grep("pA",names(traces)))]
        #sum <- summarise_all(traces, list(var = var))
        traces$avg <- avgSweeps(traces, nAvg = ncol(traces))
        traces$ms <- seq(msInt, length.out = nrow(traces), by = msInt)
        tMelt <- reshape2::melt(traces, id.vars = c("ms", "avg"))



        g = ggplot(tMelt, aes(x = ms, y = value, group = variable))+
            ggtitle(paste(sA$md$Cell, x, pro$Treatment, sep = " - ")) +
            ylab("pA") +
            theme_pubclean()

        if(!grepl("IV|IO", x)) {
            g = g +
                geom_line(colour = "grey")+
                geom_line(data = tMelt, aes(x = ms, y = avg), colour = "black")
            }

        if(grepl("NMDAr", x)){
            tpt <- NULL
            tPt <- data.frame(traces[which(traces$avg == min(traces$avg))+500,])
            tPtMelt <- reshape2::melt(tPt, id.vars = c("ms", "avg"))
            g = g + geom_point(data = tPtMelt, aes(x = ms, y = value), inherit.aes = FALSE, colour = "red")

        }

        if(grepl("IV|IO", x)){
            g = g + geom_line(colour = "black")
        }


        print(g)

        ggsave(plot = g, file.path(dir, paste0(paste(i,x, pro$Treatment, sep = "-"), ".jpg")))



        # return(g)



        })




}



#result[!vapply(result, is.null, logical(1))]
