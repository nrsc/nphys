#' dataframe manicure
#' standardize sweeps to df structure. addfs
#'
#' @param x
#' @param sig Signal name present in colnames
#' @param ROI Region of interest. Need to work on this ways to optimize this.
#' @param msInt sample frequency in ms
#'
#' @return
#' @export
#'
#' @examples
# dfMani <- function(x, sig = "pA", msInt = 0.1, ROI){
# if(missing(ROI)){ROI = 1:nrow(x)}
#     x = x[,grep(sig, colnames(x))] %>%
#         slice(., ROI) %>%
#         mutate(avg = rowMeans(.)) %>%
#         mutate(ms = seq(msInt, length.out = nrow(.), by = msInt))
#
#
# }
