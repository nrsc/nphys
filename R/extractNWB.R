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
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#' ### V1
#' x = "exa/QN22.26.029.4A.05.01-compressed.nwb"
#'
#' ### V2
#' x = "exa/QM22.26.031.4A.03.01-compressed.nwb"
#'
#' nwb = rhdf5::H5Fopen(x)
#' }
#'
extractNWB = function(x,
                      version = NULL,
                      data = FALSE,
                      stimulus = FALSE,
                      sweeps = NULL,
                      acquisition_names = FALSE,
                      stimulus_description = FALSE,
                      sampling_rate = FALSE) {
    ##TODO##
    #Proceed based upon NWB format
    #Select by sweep
    #Select by protocol
    ########

    #Print path to ensure functional operation
    print(x)

    rhdf5::h5closeAll()

    # Connect to file
    #nwb = rhdf5::H5Fopen(x)

    # Identify nwb version
    if (is.null(version)) {
        if ("nwb_version" %in% rhdf5::h5ls(x, recursive = FALSE)$name) {
            version = 1
            acquisition_path = "acquisition/timeseries"
        } else{
            version = 2
            acquisition_path = "acquisition"
        }
    }

    cell = gsub(
        "-compressed",
        "",
        tools::file_path_sans_ext(nphys::fileD(x))
    )

    ret = list(
        cell = cell,
        nwb_path = x,
        nwb_version = version
    )

    sweep_names = names(h5read(file = x, name = acquisition_path))
    ret = list()

    ## ac all data
    if (data) {
        dfs = NULL
        dfs = sapply(sweep_names, function(f) {
            h5read(file = x, name = file.path(acquisition_path, f, "data"))
        })# %>% as.data.frame()

        ret$data = dfs
    }

    ## Extract data based on sweeps
    if (!is.null(sweeps)) {
        dfs = NULL
        dfs = sapply(sweep_names[sweeps], function(f) {
            h5read(file = x, name = file.path(acquisition_path, f, "data"))
            })# %>% as.data.frame()
        ret$sweeps = dfs
    }

    ## Extract the stimulus description
    if (stimulus_description) {
        #### Nesting of data and attributes is different between v1 and v2 nwb files
        if (version == 1) {
            ##stimulus_description is a list element in v=1
            stimulus_description = sapply(sweep_names, function(f) {
                df = h5read(file = x, name = file.path(acquisition_path, f, "stimulus_description"))
                #acq[[f]]$stimulus_description
            })
        }

        if (version == 2) {
            ##stimulus_description is an attribute in version 2
            stimulus_description = sapply(sweep_names, function(f) {
                rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f))$stimulus_description
            })
        }
        # return the stim set
        ret$stimulus_description = stimulus_description
    }

    if(acquisition_names){
        ret$sweep_names = sweep_names
    }

    ## Extract isolated attributes
    if (sampling_rate) {
             sampling_rate = sapply(sweep_names, function(f) {
                rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f, "starting_time"))$rate
            })

        #names(sampling_rate) = sweep_names
        ret$sampling_rate = sampling_rate

    }

    rhdf5::h5closeAll()

    return(ret)

}
