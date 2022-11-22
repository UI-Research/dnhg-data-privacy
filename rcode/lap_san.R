################################################################################
# 	Laplace sanitzer
################################################################################
# Function that is a wrapper for the synth-count.R
# INPUTS:
#     data: dataframe
# OUTPUTS:
#     dp_synth: differentially private synthetic data

lap_san <- function(data, eps) {
  dp_synth <- data[, -1] %>% 
    apply(2, function(x) dp_count(x, eps)) %>% 
    apply(1, post_processing) %>% 
    t() %>% as_tibble() %>%
    mutate(
      poverty = poverty / children_5_17,
      linguistically_isolated = linguistically_isolated / children_5_17,
      children_disability = children_disability / children_5_17,
      vulnerable_job = vulnerable_job / children_5_17,
      single_parent = single_parent / children_5_17,
      crowded_conditions = crowded_conditions / children_5_17, 
      no_computer_internet = no_computer_internet / children_5_17
    )
  
  dp_synth <- bind_cols(data[, 1], dp_synth)
  
  return(dp_synth)
}