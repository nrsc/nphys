library(dplyr)
library(reshape2)
library(tibble)


compile = FALSE

### Collect data from rda files
if(compile){
lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
l = lf[10]
l = lf[grep("16o19.P4",lf)]
df0 <- NULL
for(l in lf){
load(l)
print(sA$md)
#sA$ana
#str(sA$ana)




df <- sA$ana %>% reshape2::melt(., id.vars = c("tmnt","mag")) %>%
    tidyr::separate(., L1, c("Protocol", "Course"), sep = "-") %>%
    #dplyr::filter(grepl("NMDA", Protocol)) %>%
    dplyr::mutate_at(., vars(Course), list(as.numeric)) %>%
    tibble::add_column(Time = seq(from = -1*(head(which(.$tmnt != "Control"),1)-1),
                                  length.out = length(.$tmnt)))# %>%

df$value <- NULL



    df <- cbind(Cell = sA$md$Cell, AgeGroup = sA$md$AgeGroup, Exp = sA$md$Treatment, df)


df0 <- rbind(df0, df)

}




### Write Table
write.table(df0, file = "data/wcMelt.csv", sep = ",")
}



