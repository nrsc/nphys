#df <- read.table("data/JimiControl.csv", sep = ",", header = TRUE, stringsAsFactors = FALSE)
#abf <- list.files("D:/rawD/Jimi", pattern = ".abf", full.names = TRUE, recursive = TRUE)

apply(dfn, 1, function(x){
    md = x[1:7]
    print(md)
    ifelse(!dir.exists(file.path("dir/js_Slices", x[1])), dir.create(file.path("dir/js_Slices", x[1])), FALSE)
    write.csv(md, file = file.path("dir/js_Slices", x[1], paste0(x[1], ".csv")), col.names = FALSE)
    sF <- which(grepl(x[4], abf) == TRUE)
    tst = wrkD(abf[sF])
    print(tst)
    for(i in tst){
    shell.exec(i)
    }

    readline(prompt = "Press enter for next")


})




