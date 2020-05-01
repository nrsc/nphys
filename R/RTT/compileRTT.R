#' Compile descriptive csv files for patches by strain
#'
#' @param x
#' @param save
#'
#' @return
#' @export
#'
#' @examples
compileRTT <- function(x, save = TRUE){
  Params <- readODS::read_ods("exp/projRTT_Params.ods", col_types = cols())
  if(missing(x)){x = select.list(Params$Strain, multiple = TRUE)}

  lf <- list.files(file.path("data/slices"),
                   pattern = ".csv",
                   recursive = TRUE,
                   full.names = TRUE)
  lf <- lf[grepl("P\\d.csv$",lf)]

  dtF <- NULL
#i = lf[1]
  for (i in lf) {

    patchInfo <-
      read.csv(
        i,
        header = TRUE,
        stringsAsFactors = FALSE

      )

  if(is.na(patchInfo$Strain)) next
  if(patchInfo$Strain[1] %in%  x) {dtF <- rbind(dtF, patchInfo)}

  }


if(save == TRUE){write.csv(dtF, file = file.path("data", paste0("compileRTT", ".csv")))}

return(dtF)

}

#tst <- compileRTT("AchPFC", save = FALSE)
