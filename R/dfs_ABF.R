#' Extract data or other variables from imported ABF format
#'
#' @param x data from import
#' @param int Set the option for what your interested in extracting from the ABF
#' @param select Indicate if you want to choose from a list of options to be returned.
#' Options to choose from are contents of ABF file after import.
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
        int = select.list(optsions, multiple = TRUE, preselect = "data")

    dfs <- lapply(x, function(d){
        df <- as.data.frame(d[int])
    })

# if returnList is set to false,
    if(!returnList){
        dfs <- unlist(dfs)
        return(dfs)
    }else{
        return(dfs)}

}
