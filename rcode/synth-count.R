################################################################################
# 	Synthetic Data via Multinomial Distribution
################################################################################
# Function for generating synthetic data via a multinomial distribution
# INPUTS:
#     x: a vector of values
# OUTPUTS:
#     synth_x: new synthetic counts

synth_count <- function(x) {
  # Sum of counts
  N <- sum(x)
  
  # Proportion of counts
  prop <- x / N
  
  # Draws from multinomial distribution
  synth_x <- rmultinom(N, 1, prob = prop) %>% rowSums()
  
  return(synth_x)
}