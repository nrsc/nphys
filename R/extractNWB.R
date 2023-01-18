#' Extract data from nwb file
#' ####
#' This function is utilized by the stimSets.R data wrangler script to extract the names of
#' protocols used across the datasets being investigated.
#' ####
#'
#'
#'
#' @param x path to nwb
#' @param version nwb file version
#' @param dataSet
#' @param sweeps
#' @param stimSet
#' @param stimulus_description
#' @param sampling_rate
#'
#' @rtrnurn
#' @export
#'
#' @examples
#' \dontrun{
#' ### V1
#' x = "exa/QN22.26.029.4A.05.01-compressed.nwb"
#' version = 1
#'
#' ### V2
#' x = "exa/QM22.26.031.4A.03.01-compressed.nwb"
#' version = 2
#'
#' nwb = rhdf5::H5Fopen(x)
#'
#' data = TRUE
#' stimulus = TRUE
#' sweeps = c(1,2,5,8)
#' acquisition_names = TRUE
#' stimulus_description = TRUE
#' sampling_rate = TRUE
#' comments = TRUE
#'
#'
#' }
#'
extractNWB = function(x,
                      data = FALSE,
                      stimulus = FALSE,
                      sweeps = NULL,
                      acquisition_names = FALSE,
                      stimulus_description = FALSE,
                      sampling_rate = FALSE,
                      comments = FALSE) {

    ### Close all h5 connections to begin extraction ###
    rhdf5::h5closeAll()

    #Print path to ensure functional operation
    print(x)

    # Get cell name
    cell = gsub(
        "-compressed",
        "",
        tools::file_path_sans_ext(nphys::fileD(x))
    )

    # Identify nwb version
    #if (is.null(version)) {}
        if ("nwb_version" %in% rhdf5::h5ls(x, recursive = FALSE)$name) {
            version = 1
            acquisition_path = "acquisition/timeseries"
            comSep = "\r"
        } else{
            version = 2
            acquisition_path = "acquisition"
            comSep = "\n"
        }

    ### Build return list
    rtrn = list(
        cell = cell,
        nwb_version = version
    )

    ## Create H5Id object
    x = rhdf5::H5Fopen(x)

    sweep_names = h5ls(H5Gopen(x, name = acquisition_path), recursive = FALSE)$name

    ### Add acquisition names to list
    if(acquisition_names){
        rtrn$sweep_names = sweep_names
    }

    ## Add all data in acquisition to list
    if (data) {
        dfs = NULL
        dfs = sapply(sweep_names, function(f) {
            h5read(file = x, name = file.path(acquisition_path, f, "data"))
        })

        rtrn$data = dfs
    }

    ## Extract data by sweep
    if (!is.null(sweeps)) {
        dfs = NULL

        if(is.numeric(sweeps)){
        dfs = sapply(sweep_names[sweeps], function(f) {
            h5read(file = x, name = file.path(acquisition_path, f, "data"))
            })
        }

        if(is.character(sweeps)){
        dfs = sapply(sweeps, function(f) {
            h5read(file = x, name = file.path(acquisition_path, f, "data"))
            })

        }

        rtrn$sweeps = dfs
    }

    ## Extract the stimulus description
    if (stimulus_description) {
        #### Nesting of data and attributes is different between v1 and v2 nwb files
        if (version == 1) {
            ##stimulus_description is a list element in version 1
            stimulus_description = sapply(sweep_names, function(f) {
                df = h5read(file = x, name = file.path(acquisition_path, f, "stimulus_description"))
                })
        }
        if (version == 2) {
            ##stimulus_description is an attribute in version 2
            stimulus_description = sapply(sweep_names, function(f) {
                rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f))$stimulus_description
            })
        }
        # return the protocol names
        rtrn$stimulus_description = stimulus_description
    }

    ## Extract isolated attributes
    if (sampling_rate) {
             sampling_rate = sapply(sweep_names, function(f) {
                rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f, "starting_time"))$rate
            })

        #names(sampling_rate) = sweep_names
        rtrn$sampling_rate = sampling_rate

    }

    if(any(comments != FALSE)){

        ## Select entire comment field from sweeps
        expComments = sapply(sweep_names, function(f) {
            df = data.frame(comment = do.call('cbind', strsplit(
                as.character(rhdf5::h5readAttributes(x, name = file.path(
                    acquisition_path, f
                ))$comment),
                comSep,
                fixed = TRUE
            )))
        })

        ## Select the Set Sweep Count
        sweepCount = lapply(expComments, function(l){
            l = data.frame(comment = l)
            names(l) = "comment"
            sweepCount = l$comment[grep("Set Sweep Count", l$comment)]
            if(length(sweepCount) == 0){
                sweepCount = NA
            }
            return(sweepCount)
        })

        ## Get the Epoch information
        Epochs = lapply(expComments, function(l){
            l = data.frame(l)
            names(l) = "comment"
            Epochs = l$comment[grep("HS#0:Epoch", l$comment)]
            if(length(Epochs) == 0){
                Epochs = NA
            }
            return(Epochs)
        })

        compComments = list(comments = expComments, sweepCount = sweepCount, Epochs = Epochs)
        rtrn$expComments = compComments
    }

    rhdf5::h5closeAll()

    return(rtrn)

}
