#' Extract data from nwb file
#' ####
#' This function is utilized by the stimSets.R data wrangler script to extract the names of
#' protocols used across the datasets being investigated.
#' ####
#' Utilizes the rhdf5 package to load nwb object into environment and follows
#' sequence of directive to extract data.
#'
#' @param x path to nwb
#' @param data return timeseries in NWB
#' @param sweeps
#' @param stimSet
#' @param stimulus_description
#' @param sampling_rate
#'
#' @export
#'
#' @examples
#' \dontrun{
#' ### V1
#' x = "data-raw/NWBv1/NWBv1.nwb"
#' version = 1
#'
#' ### V2
#' x = "data-raw/NWBv2/NWBv2.nwb"
#' version = 2
#'
#' nwb = rhdf5::H5Fopen(x)
#'
#' acquisition = FALSE
#' stimulus = TRUE
#' sweeps = c(1,2,5,8)
#' acquisition_names = TRUE
#' stimulus_description = TRUE
#' sampling_rate = TRUE
#' sweeps = NULL
#' comments = TRUE
#' epochs = TRUE
#'
#'
#' }
#'
extractNWB = function(x,
                      acquisition = FALSE,
                      sweeps = NULL,
                      stimulus_sweeps = NULL,
                      epochs = TRUE,
                      slim = FALSE) {
  ### Close all h5 connections to begin extraction ###
  rhdf5::h5closeAll()

  #Print path to ensure functional operation
  print(x)

  # Get file ID
  cellID = gsub("-compressed",
                "",
                tools::file_path_sans_ext(nphys::fileD(x)))






  #### Identify nwb version ####
  #ver = nphys::get_nwb_version(f)
  #if(ver$major == 1){

  if ("nwb_version" %in% rhdf5::h5ls(x, recursive = FALSE)$name) {
    version = 1
    acquisition_path = "acquisition/timeseries"
    stimulus_path = "stimulus/presentation"
    comSep = "\r"
  } else{
    version = 2
    acquisition_path = "acquisition"
    stimulus_path = "stimulus/presentation"
    comSep = "\n"
  }

  ### Build return list
  exp = list(cellID = cellID,
             nwb_file = x,
             nwb_version = version)

  ## Create H5Id object
  x = rhdf5::H5Fopen(x)

  ### Add acquisition names to list ###
  exp$sweep_names = rhdf5::h5ls(rhdf5::H5Gopen(x, name = acquisition_path), recursive = FALSE)$name

  ## Get sampling rate for each acquisition sweep
  exp$sampling_rate = sapply(exp$sweep_names, function(f) {
    rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f, "starting_time"))$rate
  })

  #### Extract the stimulus description ####

  #### Nesting of data and attributes is different between v1 and v2 nwb files
  if (version == 1) {
    ##stimulus_description is a list element in version 1
    exp$stimulus_description = sapply(exp$sweep_names, function(f) {
      df = rhdf5::h5read(
        file = x,
        name = file.path(acquisition_path, f, "stimulus_description")
      )
    })
  }
  if (version == 2) {
    ##stimulus_description is an attribute in version 2
    exp$stimulus_description = sapply(exp$sweep_names, function(f) {
      rhdf5::h5readAttributes(x, name = file.path(acquisition_path, f))$stimulus_description
    })
  }

  ## Select entire comment field from sweeps
  exp$comments = sapply(exp$sweep_names, function(f) {
    df = data.frame(comment = do.call('cbind', strsplit(
      as.character(rhdf5::h5readAttributes(x, name = file.path(
        acquisition_path, f
      ))$comment),
      comSep,
      fixed = TRUE
    )))
  })

  #exp$starting_times =
  exp$starting_times = sapply(exp$comments, function(f) {
    r = f[grep("High precision sweep start", f)]
    r = gsub("High precision sweep start: ", "", r)
  })
  names(exp$starting_times) = gsub(".comment", "", names(exp$starting_times))

  ## Select the Set Sweep Count
  exp$sweepCount = lapply(exp$comments, function(l) {
    l = data.frame(comment = l)
    names(l) = "comment"
    sweepCount = l$comment[grep("Set Sweep Count", l$comment)]
    if (length(sweepCount) == 0) {
      sweepCount = NA
    }
    return(sweepCount)
  })

  ## Set sweeps that are NA into catagories that reflect their sweep relationships.
  for (i in which(is.na(exp$sweepCount))) {
    exp$sweepCount[i] = exp$sweepCount[i - 1]
  }

  #exp$starting_times

  ## Get the Epoch information
  if(epochs){
  exp$epochs = lapply(exp$comments, function(l) {

    i = parent.frame()$i[]
    n = exp$sweep_names[i]

    l = data.frame(l)
    names(l) = "comment"
    HSactive = grep(":Headstage Active: On", l[[1]], value = TRUE)
    HS_Epochs = paste0(gsub(":Headstage Active: On", "", HSactive), ":Epochs")
    HS_Epochs = paste(HS_Epochs, collapse = "|")

    Epochs = l$comment[grep(HS_Epochs, l$comment)]

    if (length(Epochs) == 0) {

      Epochs = NA

    }

      suppressWarnings({
        epochDF = nphys::epochDF_from_nwb_comments(Epochs)
      })


      return(list(
        HSactive = HSactive,
        HS_Epochs = HS_Epochs,
        epochs = Epochs,
        epochDF = epochDF
      ))


  })
  }

  #### Extracting Acquisition Data ####
  ## Add all acquisition in acquisition to list
  if (acquisition) {
    dfs = NULL
    dfs = sapply(exp$sweep_names, function(f) {
      rhdf5::h5read(file = x,
                    name = file.path(acquisition_path, f, "data"))
    })

    if(slim){
      return(dfs)
    }

    exp$data = dfs
  }

  ### Extract data by sweep name or number. ####
  if (!is.null(sweeps)) {
    dfs = NULL

    if (is.numeric(sweeps)) {
      dfs = sapply(exp$sweep_names[sweeps], function(f) {
        rhdf5::h5read(file = x,
                      name = file.path(acquisition_path, f, "data"))
      })
    }

    if (is.character(sweeps)) {
      dfs = sapply(sweeps, function(f) {
        rhdf5::h5read(file = x,
                      name = file.path(acquisition_path, f, "data"))
      })

    }

    if(slim){
      return(dfs)
    }

    exp$sweeps = dfs
  }

  ### Extract stimulus by sweep name or number. ####
  if (!is.null(stimulus_sweeps)) {
    dfs = NULL
    if (is.numeric(stimulus_sweeps)) {
      dfs = sapply(exp$sweep_names[stimulus_sweeps], function(f) {
        f = gsub("AD", "DA", f)
        rhdf5::h5read(file = x,
                      name = file.path(stimulus_path, f, "data"))
      })
    }

    if (is.character(stimulus_sweeps)) {
      # if (grep("AD", stimulus_sweeps[1])) {
      #   stimulus_sweeps = sapply(stimulus_sweeps, function(f) {
      #     f = gsub("AD", "DA", f)
      #   })

      dfs = sapply(stimulus_sweeps, function(f) {
        f = gsub("AD", "DA", f)
        rhdf5::h5read(file = x,
                      name = file.path(stimulus_path, f, "data"))
      })

      }
    if(slim){
      return(dfs)
    }

    exp$stimulus_sweeps = dfs

  }

  ## Ensure that H5 is closed ##
  rhdf5::h5closeAll()

  return(exp)

}
