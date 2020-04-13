#' Change protocol names in sA;sData
#'
#' @param fNames
#'
#' @return fNames
#' @export proRename
#'
#' @examples
proRename <- function(fNames){
    xP <- select.list(fNames, title = "Which file is incorrectly named?")
    xN <- which(fNames == xP)
    print(fNames[xN])
    fNames[xN] = proSet(xN)
    while(select.list(c("Yes", "No"), title = "Again?") == "Yes"){
        xP <- select.list(fNames, title = "Which file is incorrectly named?")
        xN <- which(fNames == xP)
        print(fNames[xN])
        fNames[xN] = proSet(xN)
    }

    return(fNames)

}
