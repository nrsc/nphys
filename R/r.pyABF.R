#' Use reticulate and python to extract abf data
#'
#' @param x = file or list of files
#'
#' @return return a dfs that contains everything outlined in select
#'
#' @examples
#'
#'
#' x = loadD2AT(i, Rds = FALSE)
#' x = d2at
#'
#'
#' @export
# reticABF <- function(x, select = c("protocols", "testPulse", "vSteps", "levels", "timeData", "sweepTimes")) {
# #### startup scripts
# # Import modules and other personal scripts
#     pyabf = reticulate::import("pyabf", convert = TRUE)
#     reticulate::source_python("py/reticPyABF.py", convert = TRUE)
#
# ##### Setup place for output
#     dfs = list()
# ##### Define what x is for now
#     files = x
# ##### Import abf data from file using the python module pyABF
#     # See documents on setting up python and reticulate ()
#     pyImp = reticulate::py_suppress_warnings(lapply(files, function(f) {
#         abf = pyabf$ABF(f)
#         #names(abf) =
#     }))
#
#
# ##### Get protocol names and manipulate to ensure specifics are maintained
#     # First thing to be. This method also adds a count to
#     dfs$protocols = reticulate::py_suppress_warnings(sapply(pyImp, function(f) {
#         i = parent.frame()$i[]
#         r = f[["protocol"]]
#         r = as.character(r)
#         r = gsub(" ",  "", r)
#         #r = gsub("HP-60",  "", r)
#         #r = gsub("SS_-60_",  "", r)
#         r = paste((as.numeric(i) - 1), r, sep = "-")
#         return(r)
#     }))
#     # and set names of pyImp
#     names(pyImp) = dfs$protocols
#     ## Another option that currently does not show names.
#     #names(pyImp) = sapply(pyImp, function(p){p["protocol"]})
#
#     #if(any(grepl("protocol", select)){
#     #}
#
#
#     # if(any(grepl("testPulse", select))){
#     #     tp = pyImp[grep("testPulse", names(pyImp), value = TRUE)]
#     #     #tp$testPulse$
#     #
#     # }
# ######## Testing data import
#     pro = pyImp$`4-NaV_5x_100ms`
#     pro$sweepCount
#     pro$sweepPointCount
#     pr1 = array(pro$data, ncol = pro$sweepCount, nrow = pro$sweepPointCount*2)
#     str(pr1)
#     pr1[1:25, 1:10]
#     #### END TEST
#
#
# #### vSteps ----
#     dfs$vSteps = reticulate::py_suppress_warnings(sapply(pyImp, function(f) {
#         v = getVoltages(f)
#         }, simplify = TRUE))
#
# #### extract levels from vSteps ----
#     x$dfs$levels = lapply(x$dfs$vSteps, function(x)
#         sapply(x, function(z)
#             z$levels, simplify = TRUE))
#
#
# #### timeData ----
#     x$dfs$timeData = lapply(pyImp, function(f) {
#         ret = list(
#             sweepTimesSec = as.numeric(f$sweepTimesSec),
#             abfDateTimeString = stringr::str_split(
#                 f$abfDateTimeString,
#                 simplify = TRUE,
#                 pattern = "T"
#             )[2]
#
#         )
#         ret$xStart = stringr::str_split(ret$abfDateTimeString,
#                                         pattern = "\\.",
#                                         simplify = TRUE)[1]
#         ret$xTime = as.numeric(stringr::str_split(
#             ret$abfDateTimeString,
#             pattern = "\\.",
#             simplify = TRUE
#         )[2]) + ret$sweepTimesSec
#         ret$sweepTime = paste0(ret$xStart, ret$xTime*1000, sep = ".")
#
#
#         return(ret)
#     })
#
# #### sweepTimes ----
#     x$dfs$sweepTimes = lapply(x$dfs$timeData, function(t) {
#         ret = data.frame(xStart = t$xStart, ms = t$xTime) %>%
#             tidyr::separate(.,
#                             col = xStart,
#                             sep = ":",
#                             into = c("H", "M", "S")) %>%
#             mutate_all(as.numeric) %>%
#             mutate(S = ifelse(ms >= 1000, S + 1, S)) %>%
#             mutate(ms = ifelse(ms >= 1000, ms - 1000, ms))
#         ret$ms = round(ret$ms, digits = 7)
#         ret = paste(ret$H, ret$M, ret$S, ret$ms, sep = ":")
#     })
#
# #### protocol start Times ----
#     x$dfs$proStart = sapply(x$dfs$timeData, function(t){
#         ret = t$xStart
#         }) %>% as.character(.)
#
#
#     if(any(grepl("NaV", names(pyImp)))){
#         x$dfs$NaVx_mV = x$dfs$levels[[head(grep("NaV", names(x$dfs$levels)),1)]][3,]-60
#     }
#
#     x$dfs$Nav_mV = x$dfs$levels[[head(grep("Nav", names(x$dfs$levels)),1)]][3,]-60
#
#     x$dfs$p1s = lapply(x$dfs$vSteps, function(x)
#         sapply(x, function(z) {
#             data.frame(z$p1s)
#         }, simplify = TRUE)) %>%
#         lapply(., function(x) {
#             x = as.data.frame(x)
#             x = rowMeans(x)
#         })
#     x$dfs$p2s = lapply(x$dfs$vSteps, function(x)
#         sapply(x, function(z) {
#             data.frame(z$p2s)
#         }, simplify = TRUE)) %>%
#         lapply(., function(x) {
#             x = as.data.frame(x)
#             x = rowMeans(x)
#         })
#
#     return(x)
#
# }

