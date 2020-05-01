#' Import Mat file
#'
#' @param x
#' @param sig Signals as they are read observed
#'
#' @return
#' @export
#'
#' @examples
import.mat <- function(x, sig, sort = FALSE){
  if(missing(sig)){sig  = c("Imon1", "Imon2", "AD0", "Vmon1", "Vmon2")}

  mat <- as.data.frame(readMat(x)) %>%
    .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
    rename_at(1, ~"Time")# %>% # Rename first column to Time
    # mutate_at(vars(Time), funs(.*1000)) %>%  #Convert to ms from S

  if(any(grepl(".1$", names(mat))==TRUE)==TRUE){
    mat[-grep(".1$", names(mat))]
    }

  for(i in 1:length(sig)){
    tst <- paste0(i, ".2$")
    names(mat) <- gsub(tst, sig[i], names(mat))
  }

  if(sort == TRUE){
  mat <- lapply(sig, function(x){
    df0 <- mat[c(grep("Time", colnames(mat)), grep(x, colnames(mat)))]
    return(df0)
  })
  names(mat) = sig
  }

  return(mat)

}
