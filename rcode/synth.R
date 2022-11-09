################################################################################
# 	Synthetic Data Wrapper
################################################################################
# Function that is a wrapper for the synth-count.R
# INPUTS:
#     data: dataframe
# OUTPUTS:
#     synth: synthetic data

synth <- function(data) {
  synth <- data[, -1] %>% 
    apply(2, synth_count) %>% 
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
  
  synth <- bind_cols(data[, 1], synth)
  
  return(synth)
}