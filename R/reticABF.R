#' Use reticulate and python to extract abf data
#'
#' @param x
#'
#' @return
#' @export
#'
#' @examples
#' x = loadD2AT(Rds = FALSE)
#' x = nnest
#'
reticABF <- function(x) {
    #### startup scripts ----
    pyabf = reticulate::import("pyabf", convert = TRUE)
    reticulate::source_python("py/reticPyABF.py", convert = TRUE)

    #### Import abf data from file ----
    pyImp = reticulate::py_suppress_warnings(lapply(x$files, function(f) {
        print(f)
        abf = pyabf$ABF(f)
    }))

    #abf =
    #### Get protocol names and manipulate to ensure specifics.
    x$dfs$protocols = reticulate::py_suppress_warnings(sapply(pyImp, function(f) {
        i = parent.frame()$i[]
        r = f[["protocol"]]
        r = as.character(r)
        r = gsub(" ",  "", r)
        r = gsub("HP-60",  "", r)
        #r = gsub("SS_-60_",  "", r)
        r = paste((as.numeric(i) - 1), r, sep = "-")
        return(r)
    }))
    names(pyImp) = x$dfs$protocols

    #### vSteps ----
    x$dfs$vSteps = reticulate::py_suppress_warnings(sapply(pyImp, function(f) {
        v = getVoltages(f)
    }, simplify = TRUE))

    #### extract levels from vSteps ----
    x$dfs$levels = lapply(x$dfs$vSteps, function(x)
        sapply(x, function(z)
            z$levels, simplify = TRUE))


    #### timeData ----
    x$dfs$timeData = lapply(pyImp, function(f) {
        ret = list(
            sweepTimesSec = as.numeric(f$sweepTimesSec),
            abfDateTimeString = stringr::str_split(
                f$abfDateTimeString,
                simplify = TRUE,
                pattern = "T"
            )[2]

        )
        ret$xStart = stringr::str_split(ret$abfDateTimeString,
                                        pattern = "\\.",
                                        simplify = TRUE)[1]
        ret$xTime = as.numeric(stringr::str_split(
            ret$abfDateTimeString,
            pattern = "\\.",
            simplify = TRUE
        )[2]) + ret$sweepTimesSec
        ret$sweepTime = paste0(ret$xStart, ret$xTime*1000, sep = ".")


        return(ret)
    })

    #### sweepTimes ----
    x$dfs$sweepTimes = lapply(x$dfs$timeData, function(t) {
        ret = data.frame(xStart = t$xStart, ms = t$xTime) %>%
            tidyr::separate(.,
                            col = xStart,
                            sep = ":",
                            into = c("H", "M", "S")) %>%
            dplyr::mutate_all(as.numeric) %>%
            dplyr::mutate(S = ifelse(ms >= 1000, S + 1, S)) %>%
            dplyr::mutate(ms = ifelse(ms >= 1000, ms - 1000, ms))
        ret$ms = round(ret$ms, digits = 7)
        ret = paste(ret$H, ret$M, ret$S, ret$ms, sep = ":")
    })

    #### protocol start Times ----
    x$dfs$proStart = sapply(x$dfs$timeData, function(t){
        ret = t$xStart
    }) %>% as.character(.)


    if(any(grepl("NaV", names(pyImp)))){
        x$dfs$NaVx_mV = x$dfs$levels[[head(grep("NaV", names(x$dfs$levels)),1)]][3,]-60
    }

    x$dfs$Nav_mV = x$dfs$levels[[head(grep("Nav", names(x$dfs$levels)),1)]][3,]-60

    x$dfs$p1s = lapply(x$dfs$vSteps, function(x)
        sapply(x, function(z) {
            data.frame(z$p1s)
        }, simplify = TRUE)) %>%
        lapply(., function(x) {
            x = as.data.frame(x)
            x = rowMeans(x)
        })
    x$dfs$p2s = lapply(x$dfs$vSteps, function(x)
        sapply(x, function(z) {
            data.frame(z$p2s)
        }, simplify = TRUE)) %>%
        lapply(., function(x) {
            x = as.data.frame(x)
            x = rowMeans(x)
        })



    return(x)

}

