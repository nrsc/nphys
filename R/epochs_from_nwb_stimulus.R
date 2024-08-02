#' Get epochs from stimulus trace by identifying significant changes in point differences
#'
#' @param x Can be either the nnested list with
#' @param s
#' @param ntail
#' @param n_expected
#'
#' @return
#' @examples
#'
#'
#' @export
epochs_from_nwb_stimulus = function(x, s, ntail = 2, n_expected) {

    if (file.exists(x)) {
        stimTrace = nphys::extractNWB(x, stimulus_sweeps = s, slim = TRUE)
        }

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
