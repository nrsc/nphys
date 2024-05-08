#' Title
#'
#' @param x sweep vector
#' @param minpeakheight
#' @param rate
#' @param eON
#' @param eOFF
#'
#' @return
#' @examples
#' x = nphys
#' x = ksweep
#' minpeakheight = -10
#' rate = 50000
#' rate = rate
#' bw = 4
#' minpeakdistance = .01*rate
#'
#' @export
APanalysis = function(x, rate, eONi, eOFFi, bw = 2, minpeakheight = -10, minpeakdistance = .005*rate){

  if(missing(eONi)){
    eONi = 1
  }
  if(missing(eOFFi)){
    eOFFi = length(x)
  }

  ksweep = nphys::ksmoothVec(x, bw)

  #fp = pracma::findpeaks(ksweep$y, minpeakheight = minpeakheight, peakpat = "[+]{1,}[0]*[-]{1,}", minpeakdistance = 100)
  fp = fpks(ksweep$y, minpeakheight = minpeakheight, peakpat = "[+]{1,}[0]*[-]{1,}", minpeakdistance = minpeakdistance)

  if(is.null(fp)){
    return(NULL)
  }
  colnames(fp) = c("amplitude", "apMAXi", "apONi", "apOFFi")

  isi = c()
  epoch_t = c()
  thresh = c()
  dvdtMax = c()
  dvdtMin = c()

  #par(mfrow = c(4,3))
  #par(mfrow = c(1,1))
  for (i in 1:nrow(fp)) {
    print(i)
    if (i == nrow(fp)) {
      # if(length(fp[i, 2]:eOFFi) < 10){
      #   next
      # }
      isi_seg = x[fp[i, 2]:eOFFi]
    }else{
      # if(length(fp[i, 2]:fp[i+1,3]) < 10){
      #   next
      # }
      isi_seg = x[fp[i, 2]:fp[i+1,3]]
    }

    ap_seg = ksweep$y[(fp[i, 3]-(rate/500)):(fp[i,4]+(rate/100))] # ap section as determined by fp, led by 1ms, and followed by
    #plot(ap_seg, type = "l")
    r = dvdt_mV(ap_seg, rate = rate, plot = FALSE, return = TRUE)
    #r = dvdt_mV(ap_seg, rate = rate, plot = TRUE, return = TRUE)

    rdiff = diff(r$dsignal[,2])

      thresh[i] = r$dsignal[head(which(rdiff > mean(abs(rdiff), na.rm = TRUE)),1),1]
      dvdtMax[i] = max(r$dsignal[,2], na.rm = TRUE)
      dvdtMin[i] = min(r$dsignal[,2], na.rm = TRUE)
      isi[i] = length(isi_seg)
      epoch_t[i] = ((fp[i, "apMAXi"])/rate)

    }

  epoch_t = epoch_t - (eONi/rate)

  fp = cbind(fp, isiIndex = isi, epoch_t = epoch_t, isiDur = isi/rate, instRate = 1/(isi/rate), threshold = thresh, dvdtMax = dvdtMax, dvdtMin = dvdtMin)

  # fp = fp[!is.na(fp[,"isiIndex"]),]
  # fp = fp[!which(fp[,"isiIndex"] < 100),]



  rownames(fp) = paste0("AP", 1:nrow(fp))


  return(fp)
}
