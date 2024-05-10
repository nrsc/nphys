#' Convert useful ipfx functions to R for portability
#'
#' @param x
#'
#' @return
#'
#' @examples

#' @export get_nwb_version
#Get nwb version

#ipfx = reticulate::import("ipfx", convert = TRUE)
get_nwb_version = function(x){
    rhdf5::H5close()
    ipfx = reticulate::import("ipfx", convert = TRUE)
    get_nwb_version = ipfx$dataset$create$get_nwb_version
    ret = get_nwb_version(x)
    return(ret)
}



