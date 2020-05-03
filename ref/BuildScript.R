# #Originates from
# https://github.com/r-lib/devtools/issues/1541
#
# #install.packages("knitr")
# #install.packages("rmarkdown")
# install.packages("nlme")
# install.packages("mvtnorm")
# install.packages("numDeriv")
# install.packages("nnet")
# library(devtools)
# library(roxygen2)
# library(knitr)
# library(rmarkdown)
#
#
# library(nlme)
# library(mvtnorm)
# library(numDeriv)
# library(nnet)
#
# setwd("C:\\Users\\xbd\\Documents\\statistics_research\\STATPACK_2017\\July032017")
# authors_at_r <- paste0(
#     "'",
#     person(
#         "First",
#         "Last",
#         email = "FirstLast@univerity.edu",
#         role  = c("aut", "cre")
#     ),
#     "'"
# )
#
# options(devtools.desc.author = authors_at_r)
# options(devtools.name = "First Last")
# options(devtools.desc.license = "GPL-2")
# options(devtools.desc = list("Version"     = "0.1",
#                              "Maintainer"  = "'First Last' <FirstLast@univerity.edu>",
#                              "Title"       = "STATPACK calculation",
#                              "Description" = "STATPACK calculation.",
#                              "Imports"     = "nlme, mvtnorm, numDeriv, nnet",
#                              "Suggests"    =" knitr, rmarkdown ",
#                              "Depends"     = "R (>= 3.0.1)"
# ))
# options()[grep("devtools", names(options()))]
#
#
# create("STATPACK")
#
# ## now add data sets to the folder data
# #dir.create(file.path("STATPACK", "data"))
#
# # the dataset used for STATPACKglm example
# c83<-read.table('C:\\Users\\xbd\\Documents\\statistics_research\\Coding\\bin.txt',header=T)
#
# # the datset used for STATPACKgls example
# coc<-read.table('C:\\Users\\xbd\\Documents\\statistics_research\\Coding\\coc\\cocaine.txt',header=T)
#
# # the dataset used for STATPACKglmm example
# skquit<-read.table(file="C:\\Users\\xbd\\Documents\\statistics_research\\Coding\\glmm_source_code\\Robin2.dat.txt",
#                    col.names=c("id","quit","int","time","helmert1","helmert2","helmert3","h1time","h2time"
#                                ,"h3time","racew","tv","manual"))
#
# load( file="C:\\Users\\xbd\\Documents\\statistics_research\\STATPACK_2017\\STATPACK_dropbox\\data\\qolef.Rda")
# load( file="C:\\Users\\xbd\\Documents\\statistics_research\\STATPACK_2017\\STATPACK_dropbox\\data\\qol.Rda")
#
# use_data(c83, coc, skquit, qol, qolef, pkg="STATPACK", internal=FALSE, overwrite=TRUE)
#
# ## now create documentation file
# setwd("./STATPACK")
