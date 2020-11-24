# Building on wc-traceFigs.R
# Intended to make grids to compare each event.
library(ggpubr)
library(magrittr)
library(readABF)
library(stringr)
library(nphys)
library(gginnards)

lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)


for(l in lf){
    load(l)
    print(sA$md)
    print(names(sA$fthr))
    msInt = unique(dfs_ABF(sA$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000

ycoord <- lapply(names(sA$fthr), function(x){
        i = parent.frame()$i[]
        x = as.data.frame(sA$fthr[i])
        traces <- x[,c(grep("pA",names(x)))]
        traces$avg <- nphys::avgSweeps(traces, nAvg = ncol(traces))
        ymin = min(traces$avg[250:length(traces$avg)])
        ymax = max(traces$avg[250:length(traces$avg)])
        ret = data.frame(ymin = ymin, ymax = ymax)
        return(ret)
        })



names(ycoord) <- names(sA$fthr)

ymaxN = max(as.numeric(sapply(ycoord[grep("NMDAr", names(ycoord))], function(x){
    x["ymax"]
})))*1.2
yminN = -25


ymaxA = 25

yminA = min(as.numeric(sapply(ycoord[grep("AMPA", names(ycoord))], function(x){
    x["ymin"]
})))*1.2





figs <- lapply(names(sA$fthr), function(x){

        # Count
        i = parent.frame()$i[]

        #pro = sA$pro[grep(x, sA$pro$protocol),]
        pro = sA$pro[i,] # New way


        ## Select traces
        traces = data.frame(sA$fthr[names(sA$fthr) %in% x])
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
            g = g + geom_point(data = tPtMelt, aes(x = ms, y = value), inherit.aes = FALSE, colour = "red") +
                ylim(yminN, ymaxN)

        }

        if(grepl("AMPA", x)){
            tpt <- NULL
            tPt <- data.frame(traces[which(traces$avg == min(traces$avg)),])
            tPtMelt <- reshape2::melt(tPt, id.vars = c("ms", "avg"))
            g = g + geom_point(data = tPtMelt, aes(x = ms, y = value), inherit.aes = FALSE, colour = "red")+
                ylim(yminA, ymaxA)


        }

        if(grepl("IV|IO", x)){
            g = g + geom_line(colour = "black")
            }


        return(g)



        })


}





names(figs) <- names(sA$fthr)





if(SAVE_FIGS == TRUE){



NMDAfigs = figs[grep("NMDAr", names(figs))]
NMDAgrd = arrangeGrob(
    grobs = NMDAfigs,
    ncol = 3)
ggsave(file.path(dir,paste0(sA$md$Cell, "-NMDAgrd.jpg")), plot = NMDAgrd, width = 20, height = 20, dpi = 72)


AMPAfigs = figs[grep("AMPA", names(figs))]
if(length(AMPAfigs) > 0){
AMPAgrd = arrangeGrob(
    grobs = AMPAfigs,
    ncol = 3)
ggsave(file.path(dir,paste0(sA$md$Cell, "-AMPAgrd.jpg")), plot = AMPAgrd, width = 20, height = 20, dpi = 72)
}

PPfigs = figs[grep("PP", names(figs))]

if(length(PPfigs) > 0){

PPgrd = arrangeGrob(
    grobs = PPfigs,
    ncol = 1)
    print("saving PP")
ggsave(file.path(dir,paste0(sA$md$Cell, "-PPgrd.jpg")), plot = PPgrd, width = 20, height = 20, dpi = 72)
}



IOfigs = figs[grep("IO", names(figs))]
if(length(IOfigs) > 0){

    IOgrd = arrangeGrob(
        grobs = PPfigs,
        ncol = 1)
    print("saving PP")
    ggsave(file.path(dir,paste0(sA$md$Cell, "-PPgrd.jpg")), plot = PPgrd, width = 20, height = 20, dpi = 72)
}




}








#result[!vapply(result, is.null, logical(1))]
