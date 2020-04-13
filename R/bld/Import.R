#' Import atf files into the R environment
#'
#' @param x The name of a Slice
#' @param dDir directory to search from
#' @param fmt File format to import - must be in its own folder named for the format.
#' @return dfR
#' @importFrom utils read.delim
#' @export
Import <- function(x, dDir = ".", fmt = "atf"){

    x = "expLTD"
# get variable working directory for slice import
    wd <- list.dirs()[head(grep(file.path(x), list.dirs(dDir)), 1)]
# Gather metadata. The md is the link between this script and newSlice
    md <-
        read.csv(list.files(pattern = paste0(x, "-SliceMD.csv"), recursive = TRUE),
                 stringsAsFactors = FALSE, header = FALSE)
    md <- t(md)
    colnames(md) <- md[1,]
    md <- as.data.frame(md, stringsAsFactors = FALSE)[-1,]


# Search for the format directory by slice
    dtdir <- grep(file.path(x, fmt), list.dirs(dDir))
# read the data files in folder path
    atf <- list.files(list.dirs()[dtdir], pattern = fmt, recursive = TRUE, full.names = TRUE)
# Import data frames.
    dfs <- sapply(atf, function(x){
        x <- read.delim(x, header = TRUE, skip = 2)
        return(x)
        })
# file names from
    files <- fileD(atf)
    names(dfs) <- files
    dfR <-list(
        wd = wd,
        Metadata = data.frame(md),
        files = files,
        Data = dfs
    )


return(dfR)

}

#tst = Import("field")

