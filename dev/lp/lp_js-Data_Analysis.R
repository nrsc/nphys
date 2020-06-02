#lp_js-Data_Analysis
l.rda <- list.files("dir/js_slices", pattern = ".rda", recursive = TRUE, full.names = TRUE)
load(l.rda[12])

for(i in l.rda){
    load(l.rda)
    fthr = sA$fthr

    tbl = data.frame(unique(str_split(names(sA$fthr), "-", simplify = TRUE)[,1:2]))

# Select from sel the potential combinations of names in sA$fthr
    # Sel combines tbl columns for general approach
    sel <- unlist(unite(tbl,newcol, remove = TRUE, sep = "-"))
    grep(sel[3], names(sA$fthr))
    # Will set up select for pre or post cond for future.



}
