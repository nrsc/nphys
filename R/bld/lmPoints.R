#' lm at each sweep
#'
#' @param x
#'
#' @return
#' @export lmPoints
#' @example x=field$traces$Bl_Avg
lmPoints <- function(x, pts){
    if(missing(pts))stop("Need to choose points")
    if(pts != 2)stop("Select two points along trace")



        t2 <- lm(Data~Time, data = t[tpt1:tpt2,])[[1]][2]



    })

    return(tst)
}
