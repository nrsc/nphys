#' Field Data Set
#' @docType data
#'
#' @format a \code{nested.list} with 5 elements:
#' \describe{
#'  \item{wd}{working directory}
#'  \item{md}{Experimental metadata}
#'  \item{files}{Imported files}
#'  \item{ABF}{Imported data from files}
#'  \item{traces}{example traces}
#' }
#'
#' @description  My own data set outlining a normal field electrophysiology experiment to asses long-term depression in the hippocampus
#' @source Christie Laboratory, Victoria B.C.
#' @keywords datasets
#' @usage data(field)
#'
"field"
# This script builds the field data set
#
# field = importABF(x ="field", dir = "exa/field", ret = TRUE, sv = FALSE)
#
# # We can utilize the dfs_ABF() function to extract the sampling interval
# sampleInt.ms <- unique(dfs_ABF(field$ABF, int = "samplingIntervalInSec", returnList = FALSE))*1000 # convert to ms
# if(length(sampleInt.ms)>1)stop("Different sample frequencies")
#
# adjNeg = -100
# adjPos = 1400
#
#
# field$traces <- list(
#
#     ms = seq(sampleInt.ms, length.out = sum(abs(adjNeg), abs(adjPos),1), by =sampleInt.ms),
#
#     blAvg <- pullSweeps(field$ABF, pull = "PreC-Bl", adjNeg = adjNeg, adjPos = adjPos) %>%
#         avgSweeps(),
#
#     decayAvg <- pullSweeps(field$ABF, pull = "Decay", adjNeg = adjNeg, adjPos = adjPos) %>%
#         avgSweeps(),
#
#     condAvg <- pullSweeps(field$ABF, pull = "Cond", adjNeg = adjNeg, adjPos = adjPos) %>%
#         avgSweeps()
# )
#
# usethis::use_data(field, overwrite = TRUE)
