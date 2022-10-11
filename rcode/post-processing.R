################################################################################
# 	Post-processing
################################################################################
# Function for post-processing the values
# (i.e., factor counts cannot exceed total counts)
# INPUTS:
#     x: a vector of values that assumes the first value is the total count
# OUTPUTS:
#     dat_x: new synthetic counts

post_processing <- function(x) {
  # Number of factors
  p <- length(x) - 1
  
  x[1] <- replace(x[1], x[1] < max(x[2:p]), max(x[2:p]))
  
  dat_x <- x  
  
  return(dat_x)
}
