#' Plot traces from a dataframe of sweeps.
#'
#' @param x
#' @param sig
#' @param p0
#' @param p1
#' @param avg
#' @param multAx
#' @param multIn
#' @param scaleBar
#' @param msInt the number of samples per ms
#'
#' @return
#' @export
#'
#' @examples
df_to_trace <- function(x, sig = "pA", msInt = 0.1, p0 = 250, p1 = 750, avg = TRUE, multAx = 1.05, multIn = 1.05, scaleBar = 50){

    #x = AMPA

    x = x[,grep(sig, colnames(x))]

traces = as.data.frame(lapply(x, function(x){
    x = as.data.frame(x)[1:1450,]
})) %>%
    mutate(avg = rowMeans(.)) %>%
    mutate(ms = seq(msInt, length.out = nrow(.), by = msInt))


p0xy = data.frame(x = traces[p0, grep("ms", colnames(traces))], y = traces[p0, grep("avg", colnames(traces))])
p1xy = data.frame(x = traces[p1, grep("ms", colnames(traces))], y = traces[p1, grep("avg", colnames(traces))])

ymax = abs(max(max(apply(traces[p0:p1, -grep("ms", names(traces))],2, max)))*multAx)
ymin = abs(min(min(apply(traces[p0:p1, -grep("ms", names(traces))],2, min)))*multIn)*-1

if(ymax < 25) ymax = 25
if(ymin > -25) ymin = -25


gg = reshape2::melt(traces, id.vars = c("ms", "avg")) %>%
        ggplot(., aes(x = ms, y = value, group = variable))+
            geom_line(colour = "grey")+
            ylim(ymin, ymax)+
            theme_void()
if(is.numeric(p0)){
gg = gg + geom_point(data = p0xy, aes(x = x, y = y), shape = 5, inherit.aes = FALSE)
}
if(is.numeric(p1)){
    gg = gg + geom_point(data = p1xy, aes(x = x, y = y), shape = 5, inherit.aes = FALSE)
}
if(is.numeric(scaleBar)){

    if(abs(ymin) > abs(ymax)){
    scPos = ymin
    gg = gg + geom_segment(aes(x = 5, xend = 5, y = scPos/4, yend = (scPos/4)-scaleBar)) +
        geom_segment(aes(x = 5, xend = 15, y = scPos/4, yend = scPos/4))

    }
    if(abs(ymin) < abs(ymax)){
    scPos = ymax
    gg = gg + geom_segment(aes(x = 5, xend = 5, y = scPos/4, yend = (scPos/4)+scaleBar)) +
        geom_segment(aes(x = 5, xend = 15, y = scPos/4, yend = scPos/4))

    }


}
if(avg) {
    gg = gg + geom_line(data = traces, aes(x = ms, y = avg), colour = "black", inherit.aes = FALSE)
    }

return(gg)

#geom_text(aes(x = 5, xend = 5, y = ymax/4, yend = (ymax/4)+50))+
    #            ggtitle("Baseline")+
    #ylim(-40, ymax)+


}
