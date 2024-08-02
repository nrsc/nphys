#' Edit a nphys function
#'
#' @param dir
#' @param fcn
#' @param ext
#'
#' @return
#' @export
#'
#' @examples
editNphys = function(dir = "~", fcn, ext){

  if(missing(ext)){
    ext = ".R"
  }

  if(missing(fcn)){
    f = select.list(list.files(file.path(dir, "nphys/R")))
    f = grep(f, list.files(file.path(dir, "nphys/R"), full.names = TRUE), value = TRUE)
    #stop("Define function")
  }else{
    f = list.files(file.path(dir, "nphys/R"), pattern = paste0(fcn, ext), full.names = TRUE)
  }

    file.edit(f)

}
