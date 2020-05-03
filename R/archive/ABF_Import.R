#' Import ABF files from experiment.
#'
#' @param Slice metadata associated with unique slice tagged with -SliceMD.csv
#'
#' @return
#' @export
#'
#' @examples x = "exa/field"
Import_ABF <- function(x, lfdir = ".", sv = TRUE){
## Load experimental params as outlined as part of the exp folder
Params <- readODS::read_ods("exp/Params.ods", col_types = readr::cols())
## If no slice is identified, promps will guide you through a choice menu to id
# which slice you'd like to import
if(missing(x)){
        ds <- select.list(Params$dirData[!is.na(Params$dirData)], title = "Data type")
        AgeGroup <- select.list(Params$AgeGroup[!is.na(Params$AgeGroup)], title = "Age Group")
        if(ds == "f_slices"){AgeGroup <- paste0(AgeGroup,ds)}
        if(ds == "wc_slices"){AgeGroup <- paste0(AgeGroup,ds)}
        AgeGroup <- gsub("_slices", "", AgeGroup)
        Treatment <- select.list(Params$Treatment[!is.na(Params$Treatment)], title = "Treatment")
        Slices <- list.files(file.path("dir", ds, AgeGroup, paste(AgeGroup, Treatment, sep = "-")))
        Slice <- select.list(Slices, title = "Import what slice")
}
## Apply metadata tag
if(grepl("-SliceMD.csv", Slice)==FALSE){Slice = paste0(Slice, "-SliceMD.csv")}
## If a path is provided instead of just the unique idententifier,
# this will remove anything but what is at the end of the path, then will find the
# wd for the piece of data.
# This is for consistency so that either the identifier or the path can be read
Slice <- nphys::fileD(Slice) %>%
    list.files(lfdir, pattern = ., recursive = TRUE, full.names = TRUE)
if(length(Slice)!=1) stop("File not found")
## Find the file within the project directory,
wd <- nphys::wrkD(Slice)
## Test if an rda data file is already present.
# If an rda is already present for the collected data, it will ask you if you want
# to make a new sA file
if(length(list.files(wd, pattern = "-sA.rda"))!=0) {
    base::ifelse(
        select.list(c(TRUE, FALSE), title = "Overwrite sA data already present??"),
        print("Overwriting data."),
        stop("Not overwriting... Probably the right choice")
    )
}
## If the function continues, start out by building a list
# read the metadata generated while gathering the point data
md <- read.csv(Slice, header = TRUE, stringsAsFactors = FALSE)
# Then generate the nested list of relevant data
sA <- list()
# Working directory for the data point
sA$wd <- wd
# metadata, as generated during experiment
sA$md = md
# and the files associated with exp in abf format
sA$files =list.files(
            wd,
            pattern = ".abf",
            full.names = TRUE,
            recursive = TRUE
    )
## Test that the files were found
if(length(sA$files)==0){stop("Error, no files found in SliceMD folder")}
## Import the abf files using the package readABF
sA$ABF = lapply(sA$files, readABF::readABF)
## Data.sort function: Specific to project
names(sA$ABF) <- projDGDev::abf_Data.sort(sA)
## Parameter in function that determines if you want to save the data
# in the datapoint wd, or return the nested list as an object
ifelse(sv, save(sA, file = gsub("-SliceMD.csv", "-sA.rda", Slice)), return(sA))
# END
}




