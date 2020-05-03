lf <- list.files("dir/wc_slices/50mM")
MD =  read.csv("dir/wc_slices/dfComWC.csv")

for (i in lf[9:11]){
    print(i)
    wcA <- wcImport(i, "atf", MD = MD)
    wd <- wcA$wd
    print(wcA$Metadata$Cell)
    n <- paste0(i, ".rda")
    save(wcA, file = paste(wd, n, sep = "/"))
}
