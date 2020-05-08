#' Pull specific sweeps from imported data
#'
#' @param x field$ABF
#' @param pull Part of the experiment you want to pull as determined by names(field$ABF)
#' @param select logical
#' If TRUE, will prompt with options to select.
#' @param zero adjust baseline of traces to zero. Is ignored if feather is set to FALSE
#' @param adjNeg how much to add to the stim artifact for the start point when observing the sweep. Default is -100 samples
#' @param adjPos how much to add to the stim artifact for the end point when observing the sweep. Default is 1400 samples
#' @param feather logical to determine if you want to return remove the points in front of the stim artifact. If FALSE, a list will be returned
#'
#' @return dataframe of sweeps unless feather is FALSE
#' @importFrom magrittr %>%
#' @examples
#' \dontrun{
#' x = field$ABF %>% pullSweeps()
#' }
#' @export
pullSweeps <- function(x, pull = "PreC-Bl", select = FALSE, zero = TRUE, feather = TRUE, adjNeg = -100, adjPos = 1400){

    if(select & !is.numeric(select)){
        pull = select.list(names(x))
        df <- dfs_ABF(x[grep(pull, names(x))])
        #df <- as.data.frame(df)

    }
    if(is.numeric(select)){

        df <- dfs_ABF(x[select])# %>% as.data.frame()
    }
    # Default to select by pull
    if(!select){
        df <- dfs_ABF(x[grep(pull, names(x))])# %>% as.data.frame()
    }

    if(feather){
        df = lapply(df, function(x){
            x = x[1:3000,]
        }) %>% as.data.frame()
        if(zero) df <- apply(df, 2, zeroAdjust) %>% as.data.frame()
        df = df[(stimArtifact(df[,1])+adjNeg):(stimArtifact(df[,1])+adjPos),]
    }

    return(df)

}
