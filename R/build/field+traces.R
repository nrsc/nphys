#resDuration
adjNeg <- -100 # How far in front of the (first) stim
adjPos <- 1400 # How far behind the (last) stim

sampleInt <- lapply()

field$traces <- list(

    Bl_Avg = avgSweeps(field$ABF, obs = "PreC-Bl")%>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))],

    Decay_Avg = avgSweeps(field$ABF, obs = "Decay") %>% bl_adjust(.) %>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))],
    Cond_Avg = avgSweeps(field$ABF, obs = "Cond") %>% bl_adjust(.) %>%
        bl_adjust(.) %>% .[stimArtifact(.,adj = adjNeg):(stimArtifact(.,adj = adjPos))]
)

field$tracesTime = seq(0, length.out = sum(abs(adjNeg), abs(adjPos)), by =)
#usethis::use_data()
