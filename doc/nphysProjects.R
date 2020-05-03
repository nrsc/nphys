## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
library(nphys)

#data(field, package = "nphys")

## -----------------------------------------------------------------------------
load("~/nphys/data/field.rda")
#data(field)

print(field$wd)

## -----------------------------------------------------------------------------
#data(field)
print(names(field))

