#' Import ABF files from experiment.
#'
#' @param x Unique ID. Will be combined with mdFlag to isolate and import.
#'
#' @param mdFlag tag that will identify md from experimental parameters
#'
#' @param dir base directory to start search in
#'
#' @param format what format of file are you importing.
#'
#' @param sv Logical. Save nnest. Default is TRUE. Will return list of elements. Named as nnest.
#'
#' @param ret = return the list or just save it.
#'
#' @return list with all the components to run data analysis
#' @importFrom utils read.csv
#' @importFrom utils select.list
#' @importFrom utils tail
#' @importFrom readABF readABF
#' @examples
#' \dontrun{
#' field = importABF("field", mdFlage = "-MD.csv", dir = "exa/field")
#' }
#' @export
importABF <- function(x, mdFlag = "-exaMD.csv", dir = ".", format = "abf", sv = TRUE, ret = TRUE){
    ## If a path is provided instead of just the unique idententifier,
    # this will remove anything but what is at the end of the path, then will find the
    # wd for the piece of data.
    #pat = paste0(x, mdFlag)
    ## Find the file by the ID-mdTag pattern, starting your search in the directory outlined by the variable dir.
    lf = list.files(dir, pattern = paste0(x,mdFlag), recursive = TRUE, full.names = TRUE)
    ## Test if an rda data file is already present, or that there are not duplicates in your data
    if(length(lf)==0) stop("File not found")
    if(length(lf)>1) stop("Tagged ID is not unique. Which would your like to import?")
    # If an rda is already present for the collected data, it will ask you if you want
    # to make a new rda file
    wd <- nphys::wrkD(lf)
    ## Going to start out by building a list to compile the data.
    nnest <- list()
    nnest$wd <- wd # Working directory for the data point


    # Read and compile the metadata generated while gathering the experiment data
    nnest$md <- read.csv(lf, header = TRUE, stringsAsFactors = FALSE)

# and the files associated with exp in abf format

nnest$files =list.files(
            nnest$wd,
            pattern = ".abf",
            full.names = TRUE,
            recursive = TRUE
    )

## Test that the files were found
if(length(nnest$files)==0){stop("Error, no files found in SliceMD folder")}

## Import the abf files using the package readABF
nnest$ABF = lapply(nnest$files, readABF::readABF)

## Data.sort function: Specific to project
names(nnest$ABF) <- abf_Data.sort(nnest)

## Parameter in function that determines if you want to save the data
# in the datapoint wd, or return the nested list as an object
if(sv){
    if(length(list.files(wd, pattern = ".rda"))!=0) {
    base::ifelse(
        select.list(c(TRUE, FALSE), title = "Overwrite rda data already present??"),
        save(nnest, file = gsub("-MD.csv", ".rda", x)),
        stop("Not overwriting... Probably the right choice")
    )
    }
}

if(ret) {return(nnest)}
# END
}




