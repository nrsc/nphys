#' Return the Epochs in a dataframe format for easier
#'
#'
#'
#' @param x Epoch description pulled from extractNWB output comments$Epochs
#'
#' @return dataframe of epochs
#' @examples
#'
#'
#' @export
epochDF_from_nwb_comments = function(x){


  if(is.na(x)){
    return(NA)
  }

  x = unlist(x)

  x = data.frame(strsplit(x, split = ":"))
  colnames(x) = "Epochs"


  x = tidyr::separate(
    x,
    col = Epochs,
    into = c("T0", "T1", "Type"),
    sep = ","
  ) %>% tidyr::separate(.,
                        col = Type,
                        into = c("Type", "Subtype", "V1", "V2", "V3", "V4", "V5"),
                        sep = ";")

  x = as.data.frame(x)

  return(x)

}
