#' Sort js dataset from sA after import using readABF.
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
abf_Data.sort <- function(x){

  dfs <- dfs_ABF(x$ABF)


  names(dfs) <- nphys::fileD(x$files)
  Cf <- as.character(x$md$StimFile)
  Cf0 <- which(stringr::str_detect(names(dfs), Cf))
  PreC <- rep("PreC-Bl", (Cf0-1))
  PostC <- rep("PostC", length((Cf0+1):length(dfs)))
  dtNames <- c(PreC, "Cond", PostC)
  dtNames[Cf0+1] = "Decay"
  names(dfs) <- dtNames

  names(dfs)[as.numeric(which(lapply(dfs, nrow) == 8260))] <-
    gsub("Bl", "PP", names(dfs)[as.numeric(which(lapply(dfs, nrow) == 8260))])

  names(dfs)[as.numeric(which(lapply(dfs, nrow) == 8260))] <-
    gsub("PostC", "PostC-PP", names(dfs)[as.numeric(which(lapply(dfs, nrow) == 8260))])

  names(dfs)[as.numeric(which(lapply(dfs, nrow) == 3100 & lapply(dfs, ncol) == 10))] <-
    gsub("Bl", "IO", names(dfs)[as.numeric(which(lapply(dfs, nrow) == 3100 & lapply(dfs, ncol) == 10))])

  names(dfs)[as.numeric(which(lapply(dfs, nrow) == 3100 & lapply(dfs, ncol) == 10))] <-
    gsub("PostC", "PostC-IO", names(dfs)[as.numeric(which(lapply(dfs, nrow) == 3100 & lapply(dfs, ncol) == 10))])

  return(names(dfs))


  }
