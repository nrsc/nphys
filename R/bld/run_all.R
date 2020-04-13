## run functions

# Import data from "field"
sA <- nphys::Import("field") %>% Data.Sort()
dfeather <- sweep_feather(sA$Data)
# if necessary change protocol names
# t_BlAvg(sA)
#names(sA$Data) <- nphys::proRename(names(Data$Data))
# identifies the folder "field" searching through all folders in home directory.
# load_sA("field")
# create dfeather ffrom sA

## LTD exp from dfeather
LTD <- LTDexp(dfeather)
BlAvg <- Avg_Sweeps(LTD$Baseline)
dfC <- identify_points(BlAvg)
DeAvg <- Avg_Sweeps(LTD$Decay)

mVd <- data.frame(unlist(sapply(sA$Data, mVdrift)),stringsAsFactors = FALSE) %>%
    set_colnames("mVd") %>%
    set_rownames(gsub("-", ".", gsub("Section","Sweep", rownames(.)))) %>%
    rownames_to_column(var = "Sweep")


#Load dfeather
#dfeather <- read_feather("./exa/field/field-d.feather")

dfactors <- data.frame(Sweep = names(dfeather), stringsAsFactors = FALSE) %>%
    full_join(., mVd, by = "Sweep")



plot(dfactors$slopeEPSP)



#dfactors <- read.csv("exa/field/field-dfactors.csv", sep = ",", header = TRUE)


## Get mVd
