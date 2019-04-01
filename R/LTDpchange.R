#' Plot of LTD over time
#'
#' @param x string of values
#' @param b baseline sweeps to analyze against
#'
#' @return
#' @export
LTDpchange <- function(x, b, d, ret = TRUE, ggPrint = TRUE){
if(missing(b)){b = 41:60}
if(missing(d)){d = 281:300}
oDt = x
m = mean(x[b])
ltd = (mean(x[d])/m)*100-100


mVmsLTD <- x %>%
    data.table() %>%
    mutate(., pChange = (./m)*100-100) %>%
    mutate(xSeq = seq(-15, by = .25, length.out = length(.)))

cMean <- colMeans(matrix(x, 4)) %>%
    data.table() %>%
    mutate(., pChange = (./m)*100-100) %>%
    mutate(xSeq = seq(-15, by = 1, length.out = length(.)))

cMean <- cMean[,-1]
cMean <- cMean[,c(2,1)]

bl <- head(mVmsLTD, 60)

gg <- ggplot() +
          geom_point(data = mVmsLTD, aes(xSeq, pChange), colour = "grey") +
          geom_point(data = cMean[1:15,], aes(xSeq, pChange), colour = "black") +
          geom_point(data = cMean[16:75,], aes(xSeq, pChange), colour = "black") +
          stat_smooth(data = bl, aes(xSeq, pChange), method = "lm")+
          ylim(-60, 40)+
          ggtitle(paste0("Slice")) +
          theme_bw()+
            theme(axis.title.x = element_blank(),
                  axis.text.x = element_blank())

blCof = coef(lm(bl$pChange~bl$xSeq))

rVars <- list(Sct = cMean, SctExt = mVmsLTD, oDt = oDt, LTD = ltd, blCof = blCof)

if(ggPrint == TRUE){print(gg)}
if(ret == TRUE){return(rVars)}else{return(gg)}


}
