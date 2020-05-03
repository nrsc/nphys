## ---- message = FALSE, echo = FALSE-------------------------------------------
knitr::opts_chunk$set(echo = TRUE, 
                      message=FALSE, 
                      warning=FALSE, 
                      fig.height=5, 
                      fig.width=8,
                      collapse = TRUE,
                      comment = "#>")


## ----setup--------------------------------------------------------------------
library(nphys)


## -----------------------------------------------------------------------------
knitr::kable(field$md[1:9], row.names = FALSE)
knitr::kable(field$md[10:15], row.names = FALSE)

## -----------------------------------------------------------------------------
print(field$files)

## -----------------------------------------------------------------------------
names(field$ABF)
names(field$ABF[[1]])

## -----------------------------------------------------------------------------
dfs <- dfs_ABF(field$ABF)
# Names of imported data
print(head(names(dfs)))

# Individual traces are named by their sweep when defaut selections are run
print(names(dfs[1]))

## -----------------------------------------------------------------------------
head(dfs_ABF(field$ABF, int = "samplingIntervalInSec"),3)

## ----eval = FALSE-------------------------------------------------------------
#  # Select from list by selecting from options
#  dfs_ABF(field$ABF, select = TRUE)
#  
#  # Provide numeric input to identify the numer representing the list element.
#  dfs_ABF(field$ABF, select = 4)

## -----------------------------------------------------------------------------
dfs_ABF(field$ABF, int = "samplingIntervalInSec", returnList = FALSE)

## -----------------------------------------------------------------------------
Sweeps <- pullSweeps(field$ABF)
head(names(Sweeps))
tail(names(Sweeps))

## ---- eval = FALSE------------------------------------------------------------
#  Sweeps = pullSweeps(field$ABF, select = TRUE)

## ---- eval = FALSE------------------------------------------------------------
#  Sweeps = pullSweeps(field$ABF, select = 1)
#  names(Sweeps)
#  head(Sweeps)

## -----------------------------------------------------------------------------
Sweeps = pullSweeps(field$ABF, select = 1, zero = FALSE)
head(Sweeps)

## -----------------------------------------------------------------------------

x = dfs_ABF(field$ABF)[[1]][[1]]
round(head(x),digits = 3)

x = zeroAdjust(x)
round(head(x),digits = 3)



## -----------------------------------------------------------------------------
x = dfs_ABF(field$ABF)[[1]][[1]]
round(head(x),digits = 3)
x = zeroAdjust(x, r = 1200:1500)
round(head(x),digits = 3)


