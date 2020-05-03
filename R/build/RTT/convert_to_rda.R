#' Convert mat files into rda for saving compressed version
#'
#' @param Slice Which Slice?
#' @param Patch Which Patch?
#' @param Save Save rda or not.
#' @param sigs Use default signals: Imon1, Vmon1, AD0, Imon2, Vmon2
#'
#' @return
#' @export
#'
#' @examples
convert_to_rda <- function(Slice, Patch, del = FALSE, ret = FALSE, sigs = FALSE){
  if(missing(Slice)){
  Slice <- select.list(list.files("dir/slices"), title = "Select Slice")
  }
  if(missing(Patch)){
  Patch <- list.dirs(file.path("dir/slices", Slice), full.names = FALSE) %>% .[grepl("P\\d$", .)]
  Patch <- select.list(Patch)
  }
  rda <- list()
  rda$Path = file.path("dir/slices", Slice, Patch)
  rda$sliceMD <- read.csv(list.files(rda$Path, pattern = ".csv", full.names = TRUE))

  lf <- list.files(rda$Path, pattern = ".mat", full.names = TRUE)
  vals <- as.numeric(sapply(lf, function(x, y = ".mat"){
    x = gsub(y, "", x)
    tail(strsplit(x, "-")[[1]],1)}
  ))
  lf <- lf[order(vals)]

  nms <- sapply(lf, function(x){
    nm <- tools::file_path_sans_ext(tail(strsplit(x, "_")[[1]],1))
    return(nm)
  }, USE.NAMES = FALSE)


  rda$Data <- lapply(lf, function(x){
    print(x)
    if(sigs == TRUE){
      sig <- readline(prompt = "Enter signals: ") %>% strsplit(., ",") %>% unlist(.) %>% gsub(" ", "", .)
      mat <- import.mat(x, sig = sig, sort = TRUE)
    }else{
      sig = c("Imon1", "Imon2", "AD0", "Vmon1", "Vmon2")
      mat <- import.mat(x, sig = sig, sort = TRUE)
    }
    return(mat)
    })


  names(rda$Data) <- nms

  rda$Data <- sort_rdaDATA(rda$Data, amp = as.character(rda$sliceMD$Amp))

  rda$Data$ampA <- rda$Data$ampA[grep("^p-|^a-", nms)]
  rda$Data$ampB <- rda$Data$ampB[grep("^p-|^b-", nms)]

  save(rda, file = file.path(rda$Path, paste0(paste(Slice, Patch, sep = "_"), ".rda")))


  if(del == TRUE){
  file.remove(lf)
  }
  if(ret == TRUE){
  return(rda)
  }


}
