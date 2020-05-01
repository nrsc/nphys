#' Add protocol to rda file
#'
#' @param x rda file to be altered
#'
#' @return
#' @export
#'
#' @examples
append_to_rda <- function(x){
  lf <- list.files(x$Path, pattern = ".mat", full.names = TRUE)
  vals <- as.numeric(sapply(lf, function(x, y = ".mat"){
     x = gsub(y, "", x)
     tail(strsplit(x, "-")[[1]],1)}
   ))
  lf <- lf[order(vals)]
  pro <-  sapply(lf, function(x) tail(strsplit(x,"_", fixed = TRUE)[[1]],1),USE.NAMES = FALSE)
  pro <- gsub(".mat", "", pro)
  # if(length(pro) >1){
  #   pro <- select.list(pro, title = "Select protocol to append")
  # }

  mat <- lapply(lf, function(x){
    print(x)
    sigs <- readline(prompt = "Enter signals: ") %>% strsplit(., ",") %>% unlist(.)
    if(isempty(sigs)) sigs = c("Imon1", "Imon2", "AD0", "Vmon1", "Vmon2")
    sigs <- gsub(" ", "", sigs)
    mat <- import.mat(x, sig = sigs, sort = TRUE)
    return(mat)
  })

  names(mat) <- pro

  x$Data[pro] <- mat

  vals <- as.numeric(sapply(names(x$Data), function(x){
    tail(strsplit(x, "-")[[1]],1)
    }))
  x$Data <- x$Data[order(vals)]

  return(x)

}
