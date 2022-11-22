################################################################################
# 	Generate Ground Truth
################################################################################
# Function that takes the original data and creates micro-level (one row per student) data
# INPUTS:
#     input_data: original dataframe
# OUTPUTS:
#     output_data: microdata

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
                       newdata = output_data %>% dplyr::select(all_of(prev_var)))
    new_prob[new_prob > 1] = 1
    new_prob[new_prob < 0] = 0
    output_data[, temp_var] = rbinom(sum(input_data$children_5_17), 
                                     1, 
                                     prob = new_prob)
    prev_var = c(prev_var, temp_var)
  }
  return(output_data)
}

