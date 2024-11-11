#' Analysis function for APs
#' Includes a collection of descriptive statistics for each action potential.
#'
#' @param x sweep vector
#' @param minpeakheight numeric
#' @param rate numeric sampling frequency
#' @param eONi numeric index start of epoch check
#' @param eOFF numeric index end of epoch for check
#'
#' @return dataframe
#'
#' @examples
#'
#' \dontrun{
#' x = sweep
#' x = data[,"data_00075_AD0"]
#' minpeakheight = -10
#' rate = 50000
#' rate = unique(smryDF$sampling_rate)
#' bw = 2
#' minpeakheight = -10
#' minpeakdistance = .005*rate
#' rate = smryDF$rate[1]
#' eONi = smryDF$eONi[1]
#' eOFFi = smryDF$eOFFi[1]
#' }
#'
#' @export
APanalysis = function(x,
                      rate,
                      eONi,
                      eOFFi,
                      bw = 2,
                      minpeakheight = -10,
                      minpeakdistance = .005 * rate) {
    if (missing(eONi)) {
        eONi = 1
    }
    if (missing(eOFFi)) {
        eOFFi = length(x)
    }

    ## Smooth vector for fp analyses
    ksweep = nphys::ksmoothVec(x, bw)

    fp = nphys::fpks(
        ksweep$y,
        minpeakheight = minpeakheight,
        peakpat = "[+]{1,}[0]*[-]{1,}",
        minpeakdistance = minpeakdistance
    )

    if (is.null(fp)) {
        return(NULL)
    }
    colnames(fp) = c("amplitude", "apMAXi", "apONi", "apOFFi")

    isi_pre = c()
    isi = c()
    epoch_t = c()
    thresh = c()
    dvdtMax = c()
    dvdtMin = c()

    #sweep_diff = dvdt_mV(as.numeric(x)[(eONi+rate/10000):(eOFFi-rate/10000)], rate = rate, plot = TRUE, return = TRUE)
    #sweep_diff = dvdt_mV(ksweep$y, rate = rate, plot = TRUE, return = TRUE)
    #plot(sweep_diff$dtime, sweep_diff$dsignal[,2], type = "l", xlim = c(0.75,1))
    #rdiff = diff(sweep_diff$dsignal[,2])
    #plot(ksweep$y[(eONi+rate/10000):(eOFFi-rate/10000)], type = "l")
    #plot(rdiff, type = "l", xlim = c(20000,21000))


   # i = 18

    for (i in 1:nrow(fp)) {
        print(i)
        ### Time of Epoch
        epoch_t[i] = ((fp[i, "apMAXi"]) / rate) - (eONi / rate)

        # Gather segments for analysis
        # First spike and there is more than 1 spike in sweep
        if (i == 1 & i != nrow(fp)) {
            isi_seg_pre = ksweep$y[(eONi+100):fp[i, 2]]
            isi_seg = ksweep$y[fp[i, 2]:fp[i + 1, 3]]

            # First spike and there is only 1 spike in sweep
        } else if (i == 1 & i == nrow(fp)) {
            isi_seg_pre = ksweep$y[(eONi+100):fp[i, 2]]
            isi_seg = ksweep$y[fp[i, 2]:eOFFi]

            # More than 1 spike in trace and is the last spike of the sweep
        } else if (i != 1 && i == nrow(fp)) {
            isi_seg_pre = ksweep$y[fp[i - 1, 4]:fp[i, 2]]
            isi_seg = ksweep$y[fp[i, 2]:eOFFi]
            # Any other spike
        } else {
            isi_seg_pre = ksweep$y[fp[i - 1, 4]:fp[i, 2]]
            isi_seg = ksweep$y[fp[i, 2]:fp[i + 1, 3]]
        }

        #plot(isi_seg, type = "l")
        #plot(isi_seg_pre, type = "l")




        if(is.numeric(ap_seg_pre)){
            r = dvdt_mV(
                as.numeric(isi_seg_pre),
                rate = rate,
                plot = FALSE,
                return = TRUE
            )

            #plot(r$dsignal, type = "l")
            #which.max(r$dsignal[,2])

            wm = (which.max(r$dsignal[,1]) - which.max(r$dsignal[,2]))
            rrise0 = max(r$dsignal[1:(length(r$dsignal[,2])-wm*3),2])*2

            thold = r$dsignal[(head(which(
                r$dsignal[,2] > rrise0
                #sig_diff > mean(abs(sig_diff), na.rm = TRUE)
            ), 1) - 5), 1]
            ## In some instances, the AP in place is too slow to pick up by this metric. When that happens a NA is given for the time being.
            if(length(thold) == 0){
             thold = NA
            }

            thresh[i] = thold
        }else{
            thresh[i] = NA
        }



        ### Pre peak max
        dvdtMax[i] = max(r$dsignal[, 2], na.rm = TRUE)



        ### Post peak min
        #ap_seg_post = x[fp[i, 2]:fp[i, 4]]
        #plot(ap_seg_post, type = "l")
        rPost = dvdt_mV(
            as.numeric(isi_seg),
            rate = rate,
            plot = FALSE,
            return = TRUE
        )
        dvdtMin[i] = min(rPost$dsignal[, 2], na.rm = TRUE)

        isi_pre[i] = ifelse(!is.numeric(isi_seg_pre), NA, length(isi_seg_pre))
        isi[i] = ifelse(!is.numeric(isi_seg), NA, length(isi_seg))

    }

    ## Curate output ##
    fp = cbind(
        fp,
        isi_preIndex = isi_pre,
        isiIndex = isi,
        epoch_t = epoch_t,
        isi_preDur = isi_pre / rate,
        isiDur = isi / rate,
        inst_preRate = 1 / (isi_pre / rate),
        instRate = 1 / (isi / rate),
        threshold = thresh,
        dvdtMax = dvdtMax,
        dvdtMin = dvdtMin
    )
    rownames(fp) = paste0("AP", 1:nrow(fp))
    return(fp)

}
