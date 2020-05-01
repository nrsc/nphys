#' Generate a folder for compiling slice data in tmp
#'
#' @return NA
#' @export newSlice
#'
#' @examples
newSlice <- function(Date, Slice){
  if(missing(Date)){Date = as.character(Sys.Date())}
  if(missing(Slice)){Slice = paste0(Date,"_S",length(list.files("data/slices", pattern = Date))+1)}
  Path = file.path("data/slices", Slice)
  MD = read.csv(file = "data/projRTT_MD.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
  sliceMD <- MD[which(MD$Date == Date),]
  sliceMD$Bregma <- readline(prompt = "Approximate plus or minus bregma position (+/- mm)?: ")

  ifelse(!dir.exists(Path), dir.create(Path), FALSE)
  write.table(sliceMD,
              file = file.path(Path, paste0(Slice, ".csv")),
              sep = ",",
              append = FALSE,
              quote = FALSE,
              col.names = TRUE,
              row.names = FALSE)

}
