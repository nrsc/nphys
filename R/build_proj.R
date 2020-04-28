#' Build a project directory
#'
#' @param x Character Identifiers for project name.
#' @param path path for directory
#'
#' @return NA Build project directory
#' @export
#'
#' @examples
#' \dontrun{
#' x = "EXA"
#' build_proj(x)
#' }
build_proj <- function(x, path = "~"){
name = paste0("proj", x)

ifelse(!dir.exists(file.path(path, name)), dir.create(file.path(path,name)), stop("directory already exists"))

download.file(url ="https://github.com/NRSC/proj/archive/master.zip", destfile = file.path(path, name, "master.zip"))
unzip(zipfile = file.path(path, name, "master.zip"), exdir = file.path(path, name))
file.remove(file.path(path, name, "master.zip"))
lf <- list.files(file.path(path,name), recursive = TRUE, full.names = TRUE)
file.rename(lf, gsub("/proj-master", "", lf))

}
