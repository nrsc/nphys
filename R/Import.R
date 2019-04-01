#' Import atf files into the R environment
#'
#' @param x The name of a Slice
#' @param fmt Format
#' @export Import
#' @importFrom utils read.delim
#' @return dfR
Import <- function(x, dDir, fmt){
if(missing(dDir)){dDir = "."}
if(missing(fmt)){fmt = "atf"}

    wd <- list.dirs()[head(grep(file.path(x), list.dirs(dDir)), 1)]
    md <-
        read.csv(list.files(pattern = paste0(x, "-SliceMD.csv"), recursive = TRUE),
                 stringsAsFactors = FALSE, header = FALSE)

    dtdir <- grep(file.path(x, fmt), list.dirs(dDir))
    atf <- list.files(list.dirs()[dtdir], pattern = fmt, recursive = TRUE, full.names = TRUE)


dfs <- list()

for (f in atf){

        df <- read.delim(f, header = TRUE, skip = 2)
        dfs[[f]] <- df

}

files <- lapply(atf, function(x){
    f <- str_split(x, "/", simplify = TRUE)
    f <- f[length(f)]
    return(f)
})

dfR <-list(
        wd = wd,
        Metadata = md,
        files = files,
        Data = dfs
    )


return(dfR)

}


