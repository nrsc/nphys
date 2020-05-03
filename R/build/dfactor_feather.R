dfactor_feather <- function(x, df){
    x = dfeather
    df <- dfactors

    mVd <- data.frame(unlist(lapply(x$Data, mVdrift)),stringsAsFactors = FALSE) %>%
        set_colnames("mVd") %>%
        set_rownames(gsub("-", ".", gsub("Section","Sweep", rownames(.))))

    dfactors <- data.frame(Sweep = names(dfeather), stringsAsFactors = FALSE) %>%
        full_join(., mVd, by = "Sweep")



}

#tst_dfeather <- tst_sweep_feather(x)
