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
  
  output_data$poverty = rbinom(sum(input_data$children_5_17), 
                              1, 
                              prob = rep(input_data$poverty, times = input_data$children_5_17))
  prev_var = c('poverty')
  for(temp_var in colnames(output_data)[-c(1:2)]){
    sample_lm = lm(formula(paste(temp_var, '~', paste(prev_var, collapse = ' + '))),
                   data = input_data)
    new_prob = predict(sample_lm, 
                       newdata = output_data %>% select(all_of(prev_var)))
    new_prob[new_prob > 1] = 1
    new_prob[new_prob < 0] = 0
    output_data[, temp_var] = rbinom(sum(input_data$children_5_17), 
                                    1, 
                                    prob = new_prob)
    prev_var = c(prev_var, temp_var)
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




