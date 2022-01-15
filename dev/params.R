## Params finally
params <- list(
    DGDev =  list(
        proj = "DGDev",
        dbdir = "/mnt/M2/db/DGDev",
        wdir = "~/nphys/wdir",
        imp = ".abf",
        nnest = "-DGDev.Rds",
        mdTag = "-DGDevMD.csv"
    )
)
list2env(params[["DGDev"]], envir = .GlobalEnv)
