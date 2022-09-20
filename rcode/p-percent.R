#################################################################################
#	p-percent function
#################################################################################
# Function for implementing p-percent disclosure method
# INPUTS:
#      x: a vector of numeric values (integer)
#      p: pre-specified percentage for p-percent test (num)
#
# OUTPUTS:
#      S: p-percent value (num)

p_percent <- function(x, p) {
  
  # reverse sort the values that contribute to the total cell count
  x <- x %>% sort %>% rev()
  
  # largest value contributor to cell count
  x1 <- x[1]
  
  # second largest value contributor to cell count
  x2 <- x[2]
  
  # vector of all remaining values in x
  y <- x[-c(1, 2)]
  
  # p-percent value
  S <- x1 - (100 / p) * sum(y)
  
  return(S)
}