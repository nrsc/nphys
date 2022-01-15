#' Extract data or other variables from the imported ABF data.
#'
#'
#' @param x dnest
#' data from import after running the newEXP() function.
#' #'
#' @param int Character
#' Indicate what your interested in extracting from the contents of the imported ABF format.
#' "data" returns
#' "Signals" returns the signals for each protocol in x
#' "sfqS" returns the sampling frequency
#'
#' @param sig Character
#' Signal you are interested in extracting from the data.
#' If uncertain what the signals are for each protocol run:
#' dfs = dfsD2AT(x, int = "Signal)
#'
#'
#' @param select Logical or Numeric
#' Indicate if you want to choose from a list of options to be returned.
#' Options to choose from are contents of ABF file after import.
#' @param r.abf
#' @param py.abf
#'
#' @return Extracted elements as determined by the user input at int. Default is "data".
#'
#'
#'
#' @examples
#'
#' x = d2at
#' x$call <- abfNphys(x)
#' x$data <- abfNphys(x, int = "data") # Returns data sweeps
#'
#' ## Add to dfs
#' x$dfs$signal <- abfNphys(x, int = "Signal")
#' x$dfs$sfqS <- abfNphys(x, int = "sfqS")
#' x = d2at
#'
#' @export
expDATA <-
    function(x,source = "readABF"
             #int = "data",
             #sig = "IN 0C",
             #select = FALSE,
             #r.abf = FALSE,
             #py.abf = FALSE
             ){

        #if(!r.abf && !py.abf)
        #    stop("need to specify methods")

    #### Calling to extract data using the readABF package ----
        ## There are certain benefits to each import method
        ## Callings
        if (source == "readABF") {

            md = x$md
            files = x$f$abf
            x = lapply(files, readABF::readABF)

            ####Get options
            options <- unlist(unique(lapply(abf, names)))

            #### Use select option to get list of choices at the first level.
            if (select) {
                int = select.list(options)
                dfs <- sapply(abfR, function(d) {
                    df <- d[int]
                    return(df)
                })
                return(dfs)
            }
            #### If already know numeric select from abf list


            if (is.numeric(select)) {
                dfs <- lapply(abfR, function(d) {
                    df <- d[select]
                    return(df)
                })
                return(dfs)
            }
            #### If calling for Signals signals
            if (sig == "select") {
                sgnl <- sapply(abf, function(d) {
                    sigs <- d[]$channelNames
                })
                sgnl = unique(sgnl)
                return(sgnl)
            }


            #### Basic data select
            if (int == "data") {
                dfs <- lapply(x, function(d) {
                    sig = paste0('^', sig, '$')
                    sigSelect <- grepl(sig, d[]$channelNames)
                    df <- data.frame(d[int])
                    df0 = df[, as.vector(sigSelect)]
                    return(df0)
                })
                return(dfs)
            }
            # Test for select and return error if not satisfied
            # if (!int %in% options & select == FALSE & int != "-data")
            #     stop("Selection not found. Use select = TRUE to select from list of options")

            #### To remove data
            if (int == "-data") {
                dfs <- lapply(x, function(d) {
                    d[-which(names(d) == "data")]
                }) %>% .[!is.na(.[])]
                return(dfs)
            }



            #Signal frequency in Seconds
            if (int == "sfqS") {
                sfqS <- lapply(x, function(d) {
                    sfqS <- d[]$samplingIntervalInSec
                })
                return(as.numeric(unique(sfqS)))
            }
            # Signal frequency in ms
            if (int == "sfqms") {
                sfqS <- lapply(x, function(d) {
                    sfqS <- d[]$samplingIntervalInSec
                    sfqms = sfqS/1000
                })
                return(as.numeric(unique(sfqS)))
            }

        }

        if ("pyABF") {
            #x = nphys::reticABF(x)
        }


    #### Return ----
        return(dfs)

    }
