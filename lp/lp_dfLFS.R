lf <-
    mixedsort(list.files("rdta/Slices/",
                         pattern = "sAna.rda",
                         recursive = TRUE,
                         full.names = TRUE
    ))
dir <- getwd()

load(lf[12])


for (i in lf){


t <- paste(dir,i, sep = "/")
shell.exec(normalizePath(t))

wd <- wrkD(i)
rda <- list.files(wd, pattern = ".rda", full.names = TRUE)
load(rda)

sAnalysis <- read.table(list.files(wd, pattern = "SliceMD.csv", full.names = TRUE), header = FALSE, sep = ",", stringsAsFactors = FALSE)


dfC <- sA$LTD$Baseline$dfCross
mVmax = dfC$mV[3]
t_mVmax = dfC$Time[3]-dfC$Time[1]

KO <- select.list(c("Keep 1", "Keep 2", "Keep 3", "Omit"), title = "Keep or Omit?")

m1Sct <- sA$sAnalysis$m1$Sct %>% set_colnames(c("V1", "V2"))

m2Sct <- sA$sAnalysis$m2$Sct %>% set_colnames(c("V1", "V2"))

m3Sct <- sA$sAnalysis$m3$Sct %>% set_colnames(c("V1", "V2"))

if(KO == "Keep 1"){
    sAnalysis <- rbind(sAnalysis, c("KO", "Keep"))
    sAnalysis <- rbind(sAnalysis, c("mVmax", mVmax))
    sAnalysis <- rbind(sAnalysis, c("t_mVmax", t_mVmax))
    sAnalysis <- rbind(sAnalysis, c("LTD", sA$sAnalysis$m1$LTD))
    sAnalysis <- rbind(sAnalysis, m1Sct)
}
if(KO == "Keep 2"){
    sAnalysis <- rbind(sAnalysis, c("KO", "Keep"))
    sAnalysis <- rbind(sAnalysis, c("mVmax", mVmax))
    sAnalysis <- rbind(sAnalysis, c("t_mVmax", t_mVmax))
    sAnalysis <- rbind(sAnalysis, c("LTD", sA$sAnalysis$m2$LTD))
    sAnalysis <- rbind(sAnalysis, m2Sct)
}
if(KO == "Keep 3"){
    sAnalysis <- rbind(sAnalysis, c("KO", "Keep"))
    sAnalysis <- rbind(sAnalysis, c("mVmax", mVmax))
    sAnalysis <- rbind(sAnalysis, c("t_mVmax", t_mVmax))
    sAnalysis <- rbind(sAnalysis, c("LTD", sA$sAnalysis$m3$LTD))
    sAnalysis <- rbind(sAnalysis, m3Sct)
}
if(KO == "Omit"){
    sAnalysis <- rbind(sAnalysis, c("KO", KO))
    sAnalysis <- rbind(sAnalysis, c("mVmax", mVmax))
    sAnalysis <- rbind(sAnalysis, c("t_mVmax", t_mVmax))
    sAnalysis <- rbind(sAnalysis, c("LTD", sA$sAnalysis$m3$LTD))
    sAnalysis <- rbind(sAnalysis, m3Sct)
}

csvName <- gsub("-Summary.png", "-sAnalysisLFSn.csv", i)
write.table(sAnalysis, file = csvName, sep = ",", row.names = FALSE, col.names = FALSE)

}


# ltd <- cbind(sA$sAnalysis$m1$LTD, sA$sAnalysis$m2$LTD, sA$sAnalysis$m3$LTD) %>%
#     set_colnames(c("m1", "m2", "m3"))
# rownames(ltd) = "ltd"
#
# blCof <- cbind.data.frame(sA$sAnalysis$m1$blCof[2], sA$sAnalysis$m2$blCof[2], sA$sAnalysis$m3$blCof[2]) %>%
#     set_colnames(c("m1", "m2", "m3"))
#
# cb <- cbind.data.frame(m1Sct,m2Sct[2],m3Sct[2], deparse.level = 1) %>%
#     column_to_rownames("xSeq") %>%
#     set_colnames(c("m1", "m2", "m3"))
#
# tst <- cbind.data.frame(md, md[2], md[2]) %>%
#     column_to_rownames("V1") %>%
#     set_colnames(c("m1", "m2", "m3")) %>%
#     rbind.data.frame(., ltd, blCof, cb)



