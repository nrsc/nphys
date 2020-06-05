library(dplyr)
library(reshape2)
library(tibble)
#compile = FALSE
### Collect data from rda files
#if(compile){

lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
#l = lf[48]
df0 <- NULL

for(l in lf){
#df = NULL
load(l)
print(sA$md)

bl = sA$DATA$NMDA$blDATA[2,] %>% dplyr::select(., -avg, -ms)
dfBl <- data.frame(Cell = sA$md$Cell, AgeGroup = sA$md$AgeGroup, Exp = sA$md$Treatment, tmnt = "Control", data.frame(t(bl)))
names(dfBl)[5] = "mag"
if(nrow(dfBl) <= 8){tl = nrow(dfBl)}else{tl = 8}
dfBl$norm = dfBl$mag/mean(tail(dfBl$mag, tl))
dfBl$pulse = seq(-nrow(dfBl), -1)
names(dfBl)

et = sA$DATA$NMDA$etDATA[2,] %>% dplyr::select(., -avg, -ms)
dfEt <- data.frame(Cell = sA$md$Cell, AgeGroup = sA$md$AgeGroup, Exp = sA$md$Treatment, tmnt = sA$md$Treatment, data.frame(t(et)))
names(dfEt)[5] = "mag"
dfEt$norm = dfEt$mag/mean(tail(dfBl$mag, 6))
dfEt$pulse = seq(0, length.out = nrow(dfEt))

dfBind = rbind(dfBl, dfEt)

df0 <- rbind(df0, dfBind)

}




### Write Table
write.table(df0, file = "data/wcScatters.csv", sep = ",", row.names = FALSE, col.names = TRUE)
#}



