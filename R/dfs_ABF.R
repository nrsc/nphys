#' Extract data or other variables from imported ABF format
#'
#' @param x data from import
#' @param int character
#' Set the option for extract
#' @param sel logical
#' Determine if you want to choose from a list of options to be returned. Ca
#'
#' @return list of extracted elements
#' @export
#'
#' @examples
#' x = field$ABF
#' dfs <- dfs_ABF(x)
dfs_ABF <- function(x, int = "data", select = FALSE, returnList = TRUE){

    options <- unlist(unique(lapply(x, names)))

    if (!int %in% options &
        select == FALSE)
        stop("Selection not found. Use sel = TRUE to select from list of options")


    if (select)
        int = select.list(opts, multiple = TRUE, preselect = "data")


    dfs <- lapply(x, function(d){
        df <- as.data.frame(d[int])
    })


    if(!returnList){
        dfs <- unlist(dfs)
        return(dfs)
    }else{
        return(dfs)}

}
