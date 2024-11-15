#' Get Epoch from stimulus
#'
#' @param x Epoch description pulled from extractNWB expParas$comments$Epochs
#'
#' @return
#' @examples
#'
#'
#' @export
epochStimulus = function(x, s, ntail = 2) {


    stimTrace = x

    traceDiff = tail(which(diff(stimTrace) != 0), ntail)

    if (length(traceDiff) == 0) {
        df = data.frame(eONi = 0,
                        eOFFi = length(stimTrace),
                        amp = 0)
        return(df)
    }


    if (any(is.na(stimTrace))) {
        #tail(which(!is.na(stimTrace)), 1)
        df = data.frame(
            eONi = tail(traceDiff, 1),
            eOFFi = tail(which(!is.na(stimTrace)), 1),
            amp = stimTrace[tail(which(!is.na(stimTrace)), 1)]
        )
        return(df)

    }

    if (is.na(traceDiff[1])) {
        df = data.frame(eONi = 0,
                        eOFFi = length(stimTrace),
                        amp = 0)
    } else{
        eONi = traceDiff[1]
        eOFFi = traceDiff[2]
        amp = unique(stimTrace[(eONi + 1):(eOFFi - 1)])
        df = data.frame(eONi = eONi,
                        eOFFi = eOFFi,
                        amp = amp)

    }



    return(df)

}
