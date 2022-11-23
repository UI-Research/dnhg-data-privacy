################################################################################
# 	DP Data Wrapper
################################################################################
# Function that is a wrapper for generating DP data
# INPUTS:
#     data: dataframe of count data (df)
#     eps: epsilon, privacy loss (num)
#     n: number of repetitions (num)
# OUTPUTS:
#     dp_data: dp data (df)

dp_fun <- function(data, eps, n) {
  temp <- lapply(1:n, function(x) lap_san(data, eps))
  dp_data <- temp[[1]]
  
  for(i in 2:n) {
    dp_data[, 2:ncol(data)] <- dp_data[, 2:ncol(data)] + temp[[i]][, 2:ncol(data)]
  }
  dp_data[, 2:ncol(data)] <- dp_data[, 2:ncol(data)] / n
  
  return(dp_data)
}