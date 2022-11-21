################################################################################
# 	Generate Ground Truth
################################################################################
# Function that takes the original data and creates micro-level (one row per student) data
# INPUTS:
#     input_data: original dataframe
# OUTPUTS:
#     output_data: microdata

library(tidyverse)  # for data wrangling and visualization
library(readxl)     # for importing excel (data)


generate_micro_data = function(input_data){

  output_data = tibble(geographic_school_district = rep(input_data$geographic_school_district, times = input_data$children_5_17),
                       poverty = rep(NA, (sum(input_data$children_5_17))),
                       linguistically_isolated = rep(NA, (sum(input_data$children_5_17))),
                       children_disability = rep(NA, (sum(input_data$children_5_17))),
                       vulnerable_job = rep(NA, (sum(input_data$children_5_17))),
                       single_parent = rep(NA, (sum(input_data$children_5_17))),
                       crowded_conditions = rep(NA, (sum(input_data$children_5_17))),
                       no_computer_internet = rep(NA, (sum(input_data$children_5_17))))
  
  for(a in unique(output_data$geographic_school_district)){
    output_data[output_data$geographic_school_district == a, -c(1)] = 
      t(rmultinom(input_data$children_5_17[input_data$geographic_school_district == a],
                  1,
                  unlist(input_data[input_data$geographic_school_district == a, -c(1:2)])))
  }
  
  return(output_data)
}

## load in data

# New Mexico Data
data_nm <- read_excel("data/data/nhgis_district_data_var.xlsx") %>%
  filter(state == "New Mexico") %>%
  dplyr::select(
    geographic_school_district,
    children_5_17,
    poverty,
    linguistically_isolated,
    children_disability,
    vulnerable_job,
    single_parent,
    crowded_conditions, 
    no_computer_internet
  )

# Pennsylvania Data
data_pa <- read_excel("data/data/nhgis_district_data_var.xlsx") %>%
  filter(state == "Pennsylvania") %>%
  dplyr::select(
    geographic_school_district,
    children_5_17,
    poverty,
    linguistically_isolated,
    children_disability,
    vulnerable_job,
    single_parent,
    crowded_conditions, 
    no_computer_internet
  ) %>%
  head(-1) # Empty district


## generate microdata (one row per child)
nm_simulated_ground_truth = generate_micro_data(data_nm)

pa_simulated_ground_truth = generate_micro_data(data_pa)

## generate proportion data (same original format)
nm_simulated_ground_truth_tabular = nm_simulated_ground_truth %>%
  group_by(geographic_school_district) %>%
  mutate(children_5_17 = n(), .before = poverty) %>%
  summarize_all(mean)

pa_simulated_ground_truth_tabular = pa_simulated_ground_truth %>%
  group_by(geographic_school_district) %>%
  mutate(children_5_17 = n(), .before = poverty) %>%
  summarize_all(mean)

## save
write_csv(nm_simulated_ground_truth, 'data/simulated_ground_truth/nm_simulated_ground_truth.csv')

write_csv(pa_simulated_ground_truth, 'data/simulated_ground_truth/pa_simulated_ground_truth.csv')

write_csv(nm_simulated_ground_truth_tabular, 'data/simulated_ground_truth/nm_simulated_ground_truth_tabular.csv')

write_csv(pa_simulated_ground_truth_tabular, 'data/simulated_ground_truth/pa_simulated_ground_truth_tabular.csv')




