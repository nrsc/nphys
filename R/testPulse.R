#' Test pulse analysis
#'
#' @param v voltage trace
#' @param i current trace
#' @param dV magnitude of test pulse in Volts.
#' @param dI magnitude of test pulse in Amps.
#'
#' @export testPulse
#'
#' @examples
testPulse <- function(v, i, dV = NA, dI = NA){
  # if(amp == "a"){sigI = "Imon1"; sigV = "Vmon1"}
  # if(amp == "b"){sigI = "Imon2"; sigV = "Vmon2"}
  # if(amp == NA){sigI = "Imon1"; sigV = "Vmon1"}
  # I = x[[sigI]]
  # V = x[[sigV]]
  #
  # sF = length(which(I$Time < .001))*1000
  #
  # I = I[1:c(sF/10),]
  # V = V[1:c(sF/10),]
  #
  # #dV = (mean(V[head(which(V[,2]< mean(V[,2]))),2])- mean(V[(head(which(V[,2]< mean(V[,2])))-20),2]))*-1
  # #dV <- round(dV, 3)
  # tp <- cbind.data.frame(Time = I[,"Time"], pA = bl_adjust(rowMeans(I[-1]))*1e12)
  # TPfit = tp[which.min(tp$pA):(which.max(tp$pA)-100),]
  # TPfit$y <- TPfit$pA*-1
  # #plot(TPfit$Time, TPfit$y)
  #
  # Io <- round(max(TPfit$y),2)
  # Iss <- round(mean(tail(TPfit$y*1, 100)),2)
  # Ra = round(dV/Io*1e6, 2)
  # Rm = round(dV/Iss*1e6,2)
  # tau = (tail(which(TPfit$y>((Io-Iss)*.34)),1)+1)/(sF)
  #
  # Cm = round((tau*((1/Ra)+(1/Rm)))*1e6,2)
  #
  # gg <- ggplot(tp, aes(x = Time*1000, y = pA))+
  #   geom_line()+
  #   ggtitle("TestPulse")+
  #   xlab("Time (ms)")+
  #   ylab("Current (pA)")+
  #   annotate(geom = "text", x = 0.005, hjust = 0, y = max(tp$pA)*.7, label = paste0("Ra = ", Ra, " MOhm"))+
  #   annotate(geom = "text", x = 0.005, hjust = 0, y = max(tp$pA)*.6, label = paste0("Rm = ", Rm, " MOhm"))+
  #   annotate(geom = "text", x = 0.005, hjust = 0, y = max(tp$pA)*.5, label = paste0("Cm = ", Cm, " pF"))+
  #   annotate(geom = "text", x = 0.005, hjust = 0, y = max(tp$pA)*.4, label = paste0("tau = ", tau*1000, " ms"))+
  #   theme_pubclean()+
  #   theme(panel.grid = element_blank()); print(gg)
  #
  # return(list(Rm = Rm, Cm = Cm, t = tau*1000))

  }


