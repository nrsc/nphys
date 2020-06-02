#' Extract data or other variables from the imported ABF data.
#'
#'
#' @param x data from import
#'
#' @param int Character
#' Indicate what your interested in extracting from the contents of the imported ABF format.
#'
#' @param select Logical or Numeric
#' Indicate if you want to choose from a list of options to be returned.
#' Options to choose from are contents of ABF file after import.
#'
#' @param returnList Logical.
#' If TRUE, will return elements as a nested list.
#' Useful when extracting the nested dataframes that make up the majority of the nested data.
#' If FALSE, will unlist the elements ard return data as a single vector.
#' Useful if wanting to return something like sampling rate or signal channels.
#'
#' @return Extracted elements as determined by the user input at int. Default is "data".
#'
#' @examples
#' \dontrun{
#' x = field$ABF
#' dfs <- dfs_ABF(x)
#' }
#' @export
dfs_ABF <- function(x, int = "data", select = FALSE, returnList = TRUE){
    #Get options
    options <- unlist(unique(lapply(x, names)))


    if(!int %in% options & select == FALSE)
        stop("Selection not found. Use select = TRUE to select from list of options")

    if(select == TRUE)
        int = select.list(options, multiple = TRUE, preselect = "data")
        dfs <- lapply(x, function(d){
            df <- as.data.frame(d[int])
            return(df)
    })

    if(is.numeric(select)){
        dfs <- lapply(x, function(d){
            df <- as.data.frame(d[select])
            return(df)
            })
    }

    if(int == "data" & !select){
        dfs <- lapply(x, function(d){
            df <- as.data.frame(d[int])
            colnames(df) = paste("Sweep", 1:ncol(df), sep = "-")
            return(df)
        })
    }

# if returnList is set to false.
    if(!returnList){
        dfs <- unlist(dfs)
        return(dfs)
    }else{
        return(dfs)}

}
