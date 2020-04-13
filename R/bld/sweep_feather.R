#' All sweeps to feather
#'
#' @param x
#'
#' @return dfSweeps
#' @export
sweep_feather <- function(x, units = "ms"){
    #x = sA$Data
    dfSweeps <- data.frame(row.names = seq(1,1501))
    for(i in 1:length(x)){

        l = x[i]
        #names(tst)

        #Get Protocol for analysis
        if(grepl("IO",names(l))==TRUE){pro = "IO"}
        if(grepl("PP",names(l))==TRUE){pro = "PP"}
        if(grepl("Bl",names(l))==TRUE){pro = "Bl"}
        if(grepl("Cond",names(l))==TRUE){pro = "Cond"}
        if(grepl("Decay",names(l))==TRUE){pro = "Decay"}

        #Convert to DF and adjust baseline
        l <- data.frame(l) %>%
            column_to_rownames(., colnames(.)[1]) %>%
            sapply(., function(x){
                df = NULL
                tst <- bl_adjust(x)
                df <- cbind(df, tst)
            }) %>% as.data.frame(.)


        SA = head(which(diff(l[1:3000,ncol(l)]) == sort(diff(l[1:3000,ncol(l)]))[1]),1)-100
        if(SA < 0){
        #l = l[,-c(ncol(l))]
        SA = head(which(diff(l[1:3000,4]) == sort(diff(l[1:3000,4]))[1]),1)-100
        }

        if(pro == "PP"){
            SA1 = SA
            SA2 = SA+5000
            pulse1 = data.frame(l[SA1:(SA1+1500),])
            pulse2 = data.frame(l[SA2:(SA2+1500),])
            l = bind_cols(pulse1, pulse2)
        }else{
            l = l[SA:(SA+1500),]
        }


        dfSweeps <- cbind(dfSweeps, l)


    }

    if(units == "ms"){
        rownames(dfSweeps) <- as.numeric(rownames(dfSweeps))/100
    }

    names(dfSweeps) <- gsub("Section", "Sweep", names(dfSweeps))
    return(dfSweeps)
}

#tst_dfeather <- tst_sweep_feather(x)
