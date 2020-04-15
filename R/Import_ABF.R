#' Import ABF files from experiment.
#'
#' @param x csv metadata file associated with experiment uniquely tagged with Params$mdTag
#'
#' @return
#' @export
#'
#' @examples x = "field"
Import_ABF <- function(x, dir = ".", sv = TRUE){
if(grepl("-SliceMD.csv", x)==FALSE){x = paste0(x, "-SliceMD.csv")}
## Load experimental params as outlined as part of the exp folder
#Params <- readODS::read_ods("exp/Params.ods", col_types = readr::cols())
## If no slice is identified, promps will guide you through a choice menu to id
# which slice you'd like to import
#if(missing(Slice)){
#        ds <- select.list(Params$dirData[!is.na(Params$dirData)], title = "Data type")
#        AgeGroup <- select.list(Params$AgeGroup[!is.na(Params$AgeGroup)], title = "Age Group")
#        if(ds == "f_slices"){AgeGroup <- paste0(AgeGroup,ds)}
#        if(ds == "wc_slices"){AgeGroup <- paste0(AgeGroup,ds)}
#        AgeGroup <- gsub("_slices", "", AgeGroup)
#        Treatment <- select.list(Params$Treatment[!is.na(Params$Treatment)], title = "Treatment")
#        Slices <- list.files(file.path("dir", ds, AgeGroup, paste(AgeGroup, Treatment, sep = "-")))
#        Slice <- select.list(Slices, title = "Import what slice")
#}

## Apply metadata tag


## If a path is provided instead of just the unique idententifier,
x <- nphys::fileD(x) %>% list.files(dir, pattern = ., recursive = TRUE, full.names = TRUE)
# this will remove anything but what is at the end of the path, then will find the
# wd for the piece of data.
# This is for consistency so that either the identifier or the path can be read
if(length(x)!=1) stop("File not found")
## Find the file within the project directory,
wd <- nphys::wrkD(x)
## Test if an rda data file is already present.
# If an rda is already present for the collected data, it will ask you if you want
# to make a new rda file
if(length(list.files(wd, pattern = "-rda.rda"))!=0) {
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
rda$md <- read.csv(x, header = TRUE, stringsAsFactors = FALSE)

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




