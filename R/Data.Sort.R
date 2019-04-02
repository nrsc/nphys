#' Sort imported atf data
#'
#' @param x List of imported atf files
#'
#' @return x
#' @export
Data.Sort <- function(x){
md = x$Metadata
#x = tst0
    Cf <- md$V2[which(md$V1 == "StimFile")]
    Cf0 <- gsub("abf", "atf", Cf)
    Cf0 <- which(str_detect(names(x$Data), Cf0))

    PreC <- rep("PreC", (Cf0-1))
    PostC <- rep("PostC", length((Cf0+1):length(x$Data)))
    dtNames <- c(PreC, "Cond", PostC)

    for (i in 1:length(x$Data)){
        #print(i)
        Sweep <- x$Data[[i]]
        n = ncol(Sweep)
        n1 = nrow(Sweep)
        #print(n)
        #print(n1)


        if (i == (Cf0+1)){
            name <- "Decay"
            dtNames[[i]] <- name
            next
        }
        if (n1 == 8260){
            name <- "-PP_"
            dtNames[[i]] <- paste0(dtNames[i], name, i)
            next
        }

        if (n1 != 8260 & n == 11 & n1 == 3100){
            name <- "-IO_"
            name <- paste0(dtNames[i], name, i)
            dtNames[[i]] <- name
            next
        }


        if(i != 1 & i != (Cf0+1) & i != Cf0 & n != 901){
            name <- "-Bl_"
            name <- paste0(dtNames[i], name, i)
            dtNames[[i]] <- name
        }

    }


    print(dtNames)


    names(x$Data) <- dtNames
    names(x$files) <- dtNames

    return(x)
}
