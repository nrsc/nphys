traceSweeps <- function(x){
        # Function IsolateWsh returns list(Sweeps, Wsh) as numeric identifiers.
        Sweeps <- x %>% IsolateWsh(Wsh = Wsh)
        # Row means of the identified columns.
        Avg <- rowMeans(x[,tail(Sweeps$Sweeps, nAvg)])
        return(Avg)
    }


}
