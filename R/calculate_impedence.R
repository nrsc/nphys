#'
#'
calculate_impedance <- function(df, f0, f1, T) {
  # Ensure the dataframe has the necessary columns
  if (!all(c("voltage", "current",) %in% names(df))) {
    stop("Dataframe must contain 'voltage' and 'current' columns")
  }


  # Calculate impedance and add it as a new column
  df$impedance <- df$voltage / df$current

  # Return the updated dataframe
  return(df)
}