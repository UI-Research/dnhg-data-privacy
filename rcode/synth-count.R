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
  #N <- x[1]
  
  ## Sample proportions from Dirichlet Prior
  sample_prop = rgamma(length(unlist(x)),
                       unlist(alpha + x))
  sample_prop = sample_prop / sum(sample_prop)
  # Proportion of counts
  #prop <- x / N
  
  # DrawsN from multinomial distribution
  synth_x <- rmultinom(N, 1, prob = sample_prop) %>% 
    rowSums()
  
  #synth_x = c(x[1], synth_x)
  #names(synth_x) = names(x)
  
  return(synth_x)
}
