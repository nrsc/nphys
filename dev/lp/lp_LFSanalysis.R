lf <-
    mixedsort(list.files("dir",
                         pattern = "sA.rda",
                         recursive = TRUE,
                         full.names = TRUE
    ))
i = lf[12]

for (i in lf[1:length(lf)]){
        print(which(lf == i))
        load(i)
        wd <- wrkD(i)

        {
            sAnalysis <-
                read.table(
                    list.files(
                        wd,
                        pattern = "SliceMD.csv",
                        recursive = TRUE,
                        full.names = TRUE
                    ),
                    #row.names = 1,
                    header = FALSE,
                    sep = ",",
                    stringsAsFactors = FALSE
                )

            #sAnalysis <- data.frame(t(sAnalysis))
        }

            tst <- sAnalysis[c("Slice", "Group", "Sex", "Age", "xSoln", "StimFile")]

            Slice <- as.character(sAnalysis$Slice)
            Group <- as.character(sAnalysis$Group)
            Comment <- as.character(sAnalysis$Comment)
            print(Slice)


        # m1 = sA$sAnalysis$m1
        # m2 = sA$sAnalysis$m2
        # m3 = sA$sAnalysis$m3
        m4 = sA$sAnalysis$m4


        tst1 = m4$Sct

        tst0 <- rbind(c("LTD", m4$LTD, "blS" = m4$blCof[2]))

    tst$m1_slope = m1$blCof[2]



#csvName <- gsub("-Summary.png", "-sAnalysisLFSn.csv", i)
#write.table(sAnalysis, file = csvName, sep = ",", row.names = FALSE, col.names = FALSE)

}

