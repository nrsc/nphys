#' Name your protocol
#'
#' @return
#' @export
#'
#' @examples
proSet <- function(x){
    pC <- select.list(c("PreC", "PostC"), title = "Pre or Post conditioning")
    pS <- select.list(c("IO", "PP", "Bl", "Cond", "Decay"), title = "Protocol type")
    pro <- paste(paste(pC, pS, sep = "-"), x, sep = "_")
    return(pro)
    }
