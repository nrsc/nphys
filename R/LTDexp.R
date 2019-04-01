#' Collect LTD Data
#'
#' @param x
#'
#' @return r0
#' @export
LTDexp <- function(x){
x = sData$Data
    Blr <- which(grepl("PreC-Bl", names(x)) == TRUE)

    # Bla <- x[Blr]
    # Bla <- lapply(Bla, function(x){
    #     x <- x[1:3000,]
    # })
    Baseline <- cbind.data.frame(x[Bla]) %>%
        baseline_adjust() %>%



    Cond <- as.data.frame(x["Cond"]) %>%
        baseline_adjust()


    Decay <- as.data.frame(x["Decay"]) %>%
        baseline_adjust()

    nameData <- c("Baseline", "Cond", "Decay")
    r0 <- lapply(nameData, function(x) get(x))
    names(r0) <- nameData

    r0 <- lapply(r0, baseline_adjust)


    return(r0)

}
