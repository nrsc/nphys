#' Test pulse analysis after Heka MAT export
#'
#' @param x
#' @param dV = size of the voltage step in Volts
#' @param sF = sample rate
#' @param A = Amplifier
#'
#' @return
#' @export tp.mat
#'
#' @examples
tp.mat <- function(x, dV = -0.01, sF = 50000, A = 1){
# Variables
#name <- head(unlist(strsplit(tail(unlist(strsplit(x, "/")),1), "\\.")),1)

# Data
mat <- as.data.frame(readMat(x)) %>%
  .[!duplicated(lapply(.,summary))] %>% # Remove identical Time columns
  rename_at(1, ~"Time") %>% # Rename first column to Time
  mutate_at(vars(Time), funs(.*1000)) #Convert to ms from S

Imon1 = mat[,grep(pattern = "(Time|.1.2)$", names(mat))]
if(A == 2){Imon2 = mat[,grep(pattern = "(Time|.2.2)$", names(mat))]}


# Access and Membrane resistance
tpAvg <- cbind.data.frame(Time = Imon1[,"Time"], pA = rowMeans(Imon1[-1])*1e12)
tpAvg$pA <- bl_adjust(tpAvg$pA)
plot(tpAvg, type = "l")

# Gather fit data
TPfit = tpAvg[which.min(tpAvg$pA):(which.max(tpAvg$pA)-100),]
TPfit$y <- TPfit$pA*-1 # Convert
plot(TPfit$Time, TPfit$y)

# Estimate parameters for single order decay
Io <- round(max(TPfit$y),2)
Iss <- round(mean(tail(TPfit$y, 100)),2)
Ra = round(dV/Io*1e6, 2)
Rm = round(dV/Iss*1e6,2)
tau = (tail(which(TPfit$y>((Io-Iss)*.34)),1)+1)/(sF)

# Capacitance approximations
## Verion 1
Cm = round((tau*((1/Ra)+(1/Rm)))*1e6,2)
## Version 2
#Rp = ((Ra*Rm)/(Ra+Rm))/1e-6
#Cm = round((tau/Rp)*1e12,2)

gg <- ggplot(tpAvg, aes(x = Time, y = pA))+
  geom_line()+
  ggtitle("TestPulse")+
  xlab("Time (ms)")+
  ylab("Current (pA)")+
  annotate(geom = "text", x = 0, hjust = 0, y = max(tpAvg$pA), label = paste0("Ra = ", Ra, " MOhm"))+
  annotate(geom = "text", x = 0, hjust = 0, y = max(tpAvg$pA)*.9, label = paste0("Rm = ", Rm, " MOhm"))+
  annotate(geom = "text", x = 0, hjust = 0, y = max(tpAvg$pA)*.8, label = paste0("Cm = ", Cm, " pF"))+
  annotate(geom = "text", x = 0, hjust = 0, y = max(tpAvg$pA)*.7, label = paste0("tau = ", tau*1000, " ms"))+
  theme_pubclean() ; print(gg)

#ggsave("figs/tpTmp.png",gg,type = "cairo-png", dpi = 300, height = 4, width = 4, units = "in")
}

#x =  list.files("exa/mat", pattern = "exaTP_0.mat", recursive = TRUE, full.names = TRUE)
#tp.mat(x)



