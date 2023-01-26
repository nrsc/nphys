#' Load rda nest into Global Env
#'
#' @param x Unique identifier for data nest
#' @param dir top level directory to start at for searching for data nest.
#' @param ID rda identifier. Used to distinguish between experiment types and is based
#' upon the name of the rda file. must be flagged.
#' @param select
#'
#' @return Metadata
#' @export load_rda
#'
#' @examples
load_rda <- function(x, dir = ".", ID = "-nphys", select = "FALSE"){
    if(missing(x)){x = "field"}

    wd <- list.dirs(dir)[head(grep(x, list.dirs(dir)), 1)]

    load(file.path(wd, paste0(x, ID, ".rda")), .GlobalEnv)

    md <- read.csv(list.files(wd, pattern = paste0(x, "-SliceMD.csv"), recursive = TRUE, full.names = TRUE), stringsAsFactors = FALSE, header = FALSE)

    return(md)

}
