sliceInfo <- function(Slice){
  if(missing(Slice)){
    Slice <- select.list(list.files("data/slices"), title = "Select Slice")
  }
  read.csv(list.files(file.path("data/slices", Slice), pattern = ".csv", full.names = TRUE))
}
