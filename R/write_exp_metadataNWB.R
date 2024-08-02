#' Write experimental metadata critical for dandi upload to an nwb file
#'
#' @param nwb_file nwb file path
#' @param subject_id character
#' @param age character ISO 8601 format
#' @param sex character
#' @param species character latin specific species designation
#'
#'
#' @return NA
#' @export write_exp_metadataNWB
#'
#' @examples
#' \dontrun{
#' nwb_file = "~/Q21.26.005.11.03.04-compressed.nwb"
#' subject_id = "Q21.26.005"
#' age = "M"
#' sex = "P5Y90D"
#' species = "macaca nemestrina"
#'
#'
#'
#' }
#'
#'
#'
#'
#'
#'
#'
#'
write_exp_metadataNWB = function(nwb_file, subject_id, age, sex, species){

  rhdf5::H5close()

  nwb = rhdf5::H5Fopen(nwb_file)

  rhdf5::h5writeDataset(subject_id, nwb, "general/subject/subject_id")
  rhdf5::h5writeDataset(species, nwb, "general/subject/species")
  rhdf5::h5writeDataset(sex, nwb, "general/subject/sex")
  rhdf5::h5writeDataset(age, nwb, "general/subject/age")

  rhdf5::H5close()

  rhdf5::h5deleteAttribute(nwb_file, "general/subject/age", attribute = "rhdf5-NA.OK")
  rhdf5::h5deleteAttribute(nwb_file, "general/subject/species", attribute = "rhdf5-NA.OK")
  rhdf5::h5deleteAttribute(nwb_file, "general/subject/sex", attribute = "rhdf5-NA.OK")
  rhdf5::h5deleteAttribute(nwb_file, "general/subject/subject_id", attribute = "rhdf5-NA.OK")



}
