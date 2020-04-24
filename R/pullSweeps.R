#' Pull specific sweeps from imported data
#'
#' @param x field$ABF
#' @param pull Part of the experiment you want to pull as determined by names(field$ABF)
#' @param select logical
#' If TRUE, will prompt with options to select.
#' @param zero adjust baseline of traces to zero
#' @param feather logical to determine if you want to return remove the points in front of the stim artifact
#' @return dataframe of sweeps
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' x = field$ABF %>% pullSweeps()
#' }
#' @export
pullSweeps <- function(x, pull = "PreC-Bl", select = FALSE, zero = TRUE, feather = TRUE){

    if(select){
        pull = select.list(names(x))
        df <- dfs_ABF(x[grep(pull, names(x))]) %>% as.data.frame()
    }
    if(is.numeric(select)){

        df <- dfs_ABF(x[select]) %>% as.data.frame()
    }
    # Default to select by pull
    if(!select){
        df <- dfs_ABF(x[grep(pull, names(x))]) %>% as.data.frame()
    }

    if(zero) df <- sapply(df, zeroAdjust) %>% as.data.frame()

    if(feather){
        df = df[stimArtifact(df[,1]):(stimArtifact(df[,1])+1500),]
    }

    return(df)

}
