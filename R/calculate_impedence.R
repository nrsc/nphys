calculate_impedance <- function(df) {
# Ensure the dataframe has the necessary columns
  if (!all(c("voltage", "current",) %in% names(df))) {
    stop("Dataframe must contain 'voltage' and 'current' columns")
  }

  # Calculate impedance and add it as a new column
  df$impedance <- df$voltage / df$current

  # Return the updated dataframe
  return(df)
}

# # Define parameters
# f0 <- 0.2  # initial frequency in Hz
# f1 <- 40   # final frequency in Hz
# T <- 20    # duration in seconds

# # Generate time vector
# t <- seq(0, T, by = 0.01)  # adjust the step size as needed

# # Generate frequency vector
# f <- f0 + (f1 - f0) * t / T  # linear chirp

# # Create dataframe
# df <- data.frame(time = t, frequency = f)
