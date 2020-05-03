#' Load sA data into Global Env
#'
#' @param x
#' @param dDir
#'
#' @return Metadata
#' @export load_sA
#'
#' @examples
load_sA <- function(x, dDir){
    if(missing(x)){x = "field"}
    if(missing(dDir)){dDir = "."}


wd <- list.dirs(dDir)[head(grep(x, list.dirs(dDir)), 1)]
md <-
    read.csv(list.files(wd, pattern = paste0(x, "-SliceMD.csv"), recursive = TRUE, full.names = TRUE),
             stringsAsFactors = FALSE, header = FALSE)

load(file.path(wd, paste0(x, "-sA.rda")), .GlobalEnv)

#return(sA)
return(md)

}
