# This script is what determines what makes up the field$traces sub section of the field dataset
data(field)

# Make these into slider thingies.
adjNeg <- -100 # How far in front of the (first) stim
adjPos <- 1400 # How far behind the (last) stim

sampleInt.ms <- unique(dfs_ABF(field$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000

if(length(sampleInt.ms)>1)stop("Different sample frequencies")


field$traces <- list(

    ms = seq(sampleInt.ms, length.out = sum(abs(adjNeg), abs(adjPos),1), by =sampleInt.ms),

    Bl_Avg = avgSweeps(field$ABF, obs = "PreC-Bl")%>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))],

    Decay_Avg = avgSweeps(field$ABF, obs = "Decay") %>% bl_adjust(.) %>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))],

    Cond_Avg = avgSweeps(field$ABF, obs = "Cond") %>% bl_adjust(.) %>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))]
)

#usethis::use_data(field, overwrite = TRUE)
