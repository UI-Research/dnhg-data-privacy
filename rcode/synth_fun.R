################################################################################
# 	Synthetic Data Wrapper
################################################################################
# Function that is a wrapper for generating synthetic data
# INPUTS:
#     data: dataframe of count data (df)
#     alpha: alpha value for the dirichlet prior (num)
#     n: number of repetitions (num)
# OUTPUTS:
#     synth_data: dp data (df)

synth_fun <- function(data, alpha, n) {
  temp <- foreach(i = 1:n) %dopar% synth(data, alpha)
  synth_data <- temp[[1]]
  
  for(i in 2:n) {
    synth_data[, 2:ncol(data)] <- synth_data[, 2:ncol(data)] + temp[[i]][, 2:ncol(data)]
  }
  synth_data[, 2:ncol(data)] <- synth_data[, 2:ncol(data)] / n
  
  return(synth_data)
}