#' Analysis function for APs
#' Includes a collection of descriptive statistics for each action potential.
#'
#' @param x sweep vector
#' @param minpeakheight
#' @param rate
#' @param eON
#' @param eOFF
#'
#' @return
#' @examples
#' x = sweep
#' x = data[,"data_00075_AD0"]
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

  isi_pre = c()
  isi = c()
  epoch_t = c()
  thresh = c()
  dvdtMax = c()
  dvdtMin = c()




  for (i in 1:nrow(fp)) {
    print(i)
    if (i == 1 & i != nrow(fp)) {
        isi_seg_pre = NA
        isi_seg = x[fp[i, 2]:fp[i+1,3]]
        #isi_seg_post = NA
    } else if (i == 1 & i == nrow(fp)) {
      isi_seg_pre = NA
      isi_seg = NA
    } else if (i == nrow(fp)) {
      isi_seg_pre = x[fp[i-1,4]:fp[i, 2]]
      isi_seg = NA
    } else {
      # if(length(fp[i, 2]:fp[i+1,3]) < 10){
      #   next
      # }
      isi_seg_pre = x[fp[i-1,4]:fp[i, 2]]
      isi_seg = x[fp[i, 2]:fp[i+1,3]]
    }

     #Select epoch time of action potential
    epoch_t[i] = ((fp[i, "apMAXi"])/rate) - (eONi/rate)



    ap_seg = ksweep$y[(fp[i, 3]-(rate/500)):(fp[i,4]+(rate/100))] # ap section as determined by fp, led by 1ms, and followed by
    #plot(ap_seg, type = "l")
    r = dvdt_mV(ap_seg, rate = rate, plot = FALSE, return = TRUE)
    #r = dvdt_mV(ap_seg, rate = rate, plot = TRUE, return = TRUE)


    rdiff = diff(r$dsignal[,2])
    thresh[i] = r$dsignal[head(which(rdiff > mean(abs(rdiff), na.rm = TRUE)),1),1]
    dvdtMax[i] = max(r$dsignal[,2], na.rm = TRUE)
    dvdtMin[i] = min(r$dsignal[,2], na.rm = TRUE)
    isi_pre[i] = ifelse(is.na(isi_seg_pre), NA, length(isi_seg_pre))
    isi[i] = ifelse(is.na(isi_seg), NA, length(isi_seg))
    }


  #epoch_t = epoch_t - (eONi/rate)
  #epoch_t




  ## Curate output ##
  fp = cbind(fp, isi_preIndex = isi_pre, isiIndex = isi, epoch_t = epoch_t, isi_preDur = isi_pre/rate, isiDur = isi/rate, inst_preRate = 1/(isi_pre/rate), instRate = 1/(isi/rate), threshold = thresh, dvdtMax = dvdtMax, dvdtMin = dvdtMin)
  rownames(fp) = paste0("AP", 1:nrow(fp))
  return(fp)
}
