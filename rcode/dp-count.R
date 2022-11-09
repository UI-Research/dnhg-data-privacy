################################################################################
# 	Laplace mechanism on counts
################################################################################
# Function for smart rounded DP values for multiple counts
# INPUTS:
#     x: a dataframe that has the unique values in the first column and counts 
#        in the second column (df)
#     eps: epsilon, privacy loss (num)
# OUTPUTS:
#     dp_x: new differentially private counts

dp_count <- function(x, eps) {
  N <- sum(x)
  dp_x <- sapply(x, function(x) max(x + rdoublex(1, 0, 1 / eps), 0)) 
  # %>%
  #   `/`(sum(.)) %>%
  #   `*`(N) %>%
  #   smart_round(.)

  return(dp_x)
}