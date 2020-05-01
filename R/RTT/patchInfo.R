patchInfo <- function(Slice, Patch){
    if(missing(Slice)){
      Slice <- select.list(list.files("data/slices"), title = "Select Slice")
    }
      Patch <- select.list(list.dirs(file.path("data/slices", Slice), full.names = FALSE)[-1])

    read.csv(list.files(file.path("data/slices", Slice, Patch), pattern = ".csv", full.names = TRUE))
}
