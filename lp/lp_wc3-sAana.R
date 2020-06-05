lf <- list.files("dir/wc_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)


for(l in lf){
    load(l)
    print(sA$md)
    pro = sA$pro
    sA$ana <- lapply(sA$fthr, function(x){
                ret = list()
                i = parent.frame()$i[]
                print(i)
                p <- pro[i,]
                if(grepl("IV|IO|PP", p$protocol))return()
                #print(p)
                roi = seq(p$EPSC, p$EPSC+600) - as.numeric(rownames(x)[1])
                #x = fthr[[7]]

                #NMDA analysis
                if(grepl("NMDAr", p$protocol)){
                    x1 = x[490:510,]
                    mag <- apply(x1, 2, function(s){
                    sum <- mean(s)
                    })
                    tmnt <- rep_len(as.character(p$Treatment),length(mag))
                    ret = data.frame(mag, tmnt)
                }

                #AMPA analysis
                if(grepl("AMPA", p$protocol)){
                    mag <- apply(x[roi,grep("pA", names(x))],2,min)
                    tmnt <- rep_len(as.character(p$Treatment),length(mag))
                    ret = data.frame(mag, tmnt)

                    }

                return(ret)
        })

    #save(sA, file = l)

    }
