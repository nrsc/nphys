#' Build site for new patch
#'
#' @return sliceMD
#' @export newPatch
#'
#' @examples
newPatch <- function(Date, Slice, Patch){
  Params <- readODS::read_ods("exp/Params.ods", col_types = cols())
  MD = read.csv(file = "data/projRTT_MD.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
  if(missing(Date)){
    Date = as.character(Sys.Date())
  }
  if(missing(Slice)){
    Slice <- tail(list.files("data/slices", pattern = paste0(Date, "_S")),1)
  }else{
    Slice = paste(Date, Slice, sep = "_")
    }
  if(missing(Patch)){
    Patch <- paste0("P", length(list.files(paste("data/slices", Slice, sep = "/"), pattern = "P"))+1)
  }
  Path <- file.path("data/slices", paste(Slice, sep = "_"), Patch)
  sliceMD <- read.csv(file.path("data/slices", Slice, paste0(Slice, ".csv")), sep = ",", header = TRUE, stringsAsFactors = FALSE)
  sliceMD$Patch <- paste(Slice, Patch, sep="_")
  sliceMD$ICsoln <- select.list(Params$Icsoln, title = "Intracellular Solution?: ")
  if(sliceMD$ICsoln == "Other"){
    sliceMD$ICsoln = readline(prompt = "What ICsoln?: ")
    }
  sliceMD$Dye <- select.list(Params$Dyes, title = "Dye?")
  sliceMD$DAT <- paste0(paste("projRTT", Date, readline(prompt = "DAT file? (0XX): "), sep = "_"), ".dat")
  sliceMD$Amp <- select.list(c("a", "b", "Paired"), title = "Which Amplifier?: ")
  if(sliceMD$Amp == "Paired"){
    sliceMD$Region <- readline(prompt = "Brain region?: ")
    sliceMDb <- sliceMD
    sliceMD$Target <- readline(prompt = "Targeted cell type of amplifier A?: ")
    sliceMD$Patch <- paste0(sliceMD$Patch, "a")
    sliceMDb$Target <- readline(prompt = "Targeted Cell type of amplifier B?: ")
    sliceMDb$Patch <- paste0(sliceMDb$Patch, "b")
    sliceMD <- rbind.data.frame(sliceMD, sliceMDb)
  }else{
    sliceMD$Patch <- paste0(sliceMD$Patch, sliceMD$Amp)
    sliceMD$Region <- readline(prompt = "Region target?: ")
    sliceMD$Target <- readline(prompt = "Cell target?: ")
    }
  if(select.list(c("Yes", "No"), title = "Create directory and write table?") == "Yes"){
  ifelse(!dir.exists(Path), dir.create(Path), FALSE)
  write.table(sliceMD,
              file = file.path(Path, paste0(paste(Slice, Patch, sep = "_"), ".csv")),
              sep = ",",
              append = FALSE,
              quote = FALSE,
              col.names = TRUE,
              row.names = FALSE)
  }

  file.copy(list.files(Params$DataPath[1], pattern = sliceMD$DAT[1], recursive = TRUE, full.names = TRUE)[1], Path)

  return(sliceMD)
}
