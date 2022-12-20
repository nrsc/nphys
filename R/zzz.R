ipfx = NULL
.onLoad <- function(libname, pkgname){
    ipfx = reticulate::import("ipfx", delay_load = TRUE)
}
