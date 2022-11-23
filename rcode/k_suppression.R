################################################################################
# 	Suppression
################################################################################
# Function for generating suppressed data
# INPUTS:
#     data: dataframe
#     k: suppression value
# OUTPUTS:
#     supp_data: suppressed data

k_suppresion <- function(data, k) {
  supp_data <-data %>%
    replace(data < k, 0) %>%
    mutate(
      poverty = poverty / children_5_17,
      linguistically_isolated = linguistically_isolated / children_5_17,
      children_disability = children_disability / children_5_17,
      vulnerable_job = vulnerable_job / children_5_17,
      single_parent = single_parent / children_5_17,
      crowded_conditions = crowded_conditions / children_5_17, 
      no_computer_internet = no_computer_internet / children_5_17
    )
  
  return(supp_data)
}