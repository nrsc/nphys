#' Import ABF files from experiment.
#'
#' @param x csv metadata file associated with experiment uniquely tagged with Params$mdTag
#' @param dir base directory to start  search in
#' @param sv Logical. Save or return. Default is TRUE. If FALSE, will return the list as an object. If TRUE, list will be saved as an rda file in the same directory where x-mdTag.csv was identified.
#' @param format what format of file are you importing.
#'
#'
#' @return list with all the components to run data analysis
#' @importFrom utils read.csv
#' @importFrom utils select.list
#' @importFrom utils tail
#' @examples
#' \dontrun{
#' field = Import_ABF("field", dir = "exa/field")
#' }
#' @export
Import_ABF <- function(x, dir, format = "abf", sv = TRUE){
    if(missing(dir)){dir = getwd()}
    if(grepl("-SliceMD.csv", x)==FALSE){x = paste0(x, "-SliceMD.csv")}
## If a path is provided instead of just the unique idententifier,
# this will remove anything but what is at the end of the path, then will find the
# wd for the piece of data.
# This is for consistency so that either the identifier or the path can be read
x <- nphys::fileD(x)

## Find the file by the ID_mdTag.csv pattern, starting your search in the directory outlined by the variable dir.
lf = list.files(dir, pattern = x, recursive = TRUE, full.names = TRUE)
## Test if an rda data file is already present, or that there are not duplicates in your data
if(length(lf)==0) stop("File not found")
if(length(lf)>1) stop("Tagged ID is not unique. Which would your like to import?")
# If an rda is already present for the collected data, it will ask you if you want
# to make a new rda file
wd <- nphys::wrkD(lf)
if(length(list.files(wd, pattern = ".rda"))!=0) {
    base::ifelse(
        select.list(c(TRUE, FALSE), title = "Overwrite rda data already present??"),
        print("Overwriting data."),
        stop("Not overwriting... Probably the right choice")
    )
}
## Going to start out by building a list to compile the data.

rda <- list()
rda$wd <- wd # Working directory for the data point

# Read and compile the metadata generated while gathering the experiment data
rda$md <- read.csv(lf, header = TRUE, stringsAsFactors = FALSE)

# and the files associated with exp in abf format

rda$files =list.files(
            rda$wd,
            pattern = ".abf",
            full.names = TRUE,
            recursive = TRUE
    )

## Test that the files were found
if(length(rda$files)==0){stop("Error, no files found in SliceMD folder")}

## Import the abf files using the package readABF
rda$ABF = lapply(rda$files, readABF::readABF)

## Data.sort function: Specific to project
names(rda$ABF) <- projDGDev::abf_Data.sort(rda)


## Parameter in function that determines if you want to save the data
# in the datapoint wd, or return the nested list as an object
ifelse(sv, save(rda, file = gsub("-SliceMD.csv", "-rda.rda", x)), return(rda))
# END
}




