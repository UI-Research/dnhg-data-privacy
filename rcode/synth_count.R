################################################################################
# 	Synthetic Data via Multinomial Distribution
################################################################################
# Function for generating synthetic data via a multinomial distribution
# INPUTS:
#     x: a vector of values
# OUTPUTS:
#     synth_x: new synthetic counts

synth_count <- function(x, alpha) {
  # Sum of counts
  N <- sum(x)
  
  # Sample proportions from Dirichlet Prior
  sample_prop = rgamma(length(unlist(x)),
                       unlist(alpha + x))
  sample_prop = sample_prop / sum(sample_prop)
  
  # Draws from multinomial distribution
  synth_x <- rmultinom(N, 1, prob = sample_prop) %>% 
    rowSums()

  return(synth_x)
}