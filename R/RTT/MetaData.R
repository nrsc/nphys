#' Metadata function for ExpDay
#'
#' @return
#' @export MetaData
#'
#' @examples
MetaData <- function(){

  Date <- as.character(Sys.Date())
  Strain <- readline(prompt = "Strain : ")
  ID <- readline(prompt = "Animal ID: ")
  Treatment <- readline(prompt = "Treatment: ")
  DOB = ymd(readline(prompt="Date of Birth (YYMMDD): "))
  Age <- ifelse(is.na(DOB), NA, round(as.numeric(difftime(as.POSIXct(Date), as.POSIXct(DOB))),0))
  Sex = select.list(c("M", "F"), title = "Sex?: ")
  rSoln = readline(prompt="Recording Soln?: ")
  xSoln = readline(prompt="Cutting Soln?: ")
  CutTime <- readline(prompt = "Cut Time?: ")
  Comment <- readline(prompt = "Comment: ")

  md <- data.frame(Date, Strain, ID, Treatment, DOB, Age, Sex, rSoln, xSoln, CutTime, Comment, stringsAsFactors = FALSE)

  return(md)

}
