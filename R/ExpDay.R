#' Experimental day
#'
#' @param x
#'
#' @return
#' @export ExpDay
#'
#' @examples
ExpDay <- function(x){

Params <- readODS::read_ods("exp/DGDev.ods", col_types = cols())



md <- MetaData()
print(md)

if(select.list(c("Yes", "No"), title = "Details Correct?") == "No"){
    md <- MetaData()
    print(md)
}

if(select.list(c("Yes", "No"), title = "Write to Table?") == "Yes"){

        write.table(md, file = list.files(pattern = "MD.csv", recursive = TRUE), sep = ",", append = TRUE, quote = FALSE,
                col.names = FALSE, row.names = FALSE)
        print("projRTT_MD updated")
    }

MD <- read.csv(file = "data/projRTT_MD.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)

if(select.list(c("Yes", "No"), title = "DataPath") == "Yes"){
    Path = file.path(Params$DataPath[1], as.character(md$Date))
    ifelse(!dir.exists(Path),dir.create(Path), FALSE)
    }

# if(select.list(c("Yes", "No"), title = "New Slice") == "Yes"){
#     newSlice()
# }

}

