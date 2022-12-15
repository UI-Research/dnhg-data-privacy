################################################################################
# 	Generate Ground Truth Counts
################################################################################
# Function that takes the ground truth micro data and creates tabular data
# INPUTS:
#     micro: microlevel ground truth dataframe
# OUTPUTS:
#     tabular: tabular

tabular_data <- function(micro) {

  # Tabulating the values
  tabular <- micro %>%
    group_by(geographic_school_district) %>%
    summarize(
      children_5_17 = n(),
      poverty = sum(poverty),
      linguistically_isolated = sum(linguistically_isolated),
      children_disability = sum(children_disability),
      vulnerable_job = sum(vulnerable_job),
      single_parent = sum(single_parent),
      crowded_conditions = sum(crowded_conditions),
      no_computer_internet = sum(no_computer_internet)
    )
  
  return(tabular)
}

