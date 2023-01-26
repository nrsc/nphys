#' ## Storing R Objects in a SQLite Database
#' Two packages we are using. The first is the ```RSQLite``` which will be used to create and manage an in-memory SQLite database.
#'  The second is ```igraph``` which I will use to create and visualize a random network. Some of the work I do is on network simulation.
#'   I often don't know the metrics I need from a simulated network when it's created,
#'   so I want to be able to store the networks that are created so that I can go back later and analyze them.
library(RSQLite)
library(igraph)
library(DBI)

source("dev/R/params.R")

#' Create a database in memory.
#dbDGDev <- dbConnect(SQLite(), ":memory:")

lf <- list.files(dbdir, pattern = nnest, full.names = TRUE,recursive = TRUE)
#l = lf[4]

db = list()
for(l in lf[1:5]){
db[[l]] <- readRDS(l)
}


df <- data.frame(a=lf[1:5],
                 g = I(lapply(db, function(x){serialize(x, NULL)})))






names(db)


