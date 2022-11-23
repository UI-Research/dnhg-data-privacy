################################################################################
# 	Single Parent Wrapper
################################################################################
# Function that is a wrapper for generating the single parent
# school district plots
# INPUTS:
#     synth_data: synthetic dataframe (df)
#     schools: school district shape files (sf)
#     prop_data: confidential data (df)
# OUTPUTS:
#     dp_data: dp data (df)

parent_fun <- function(synth_data, schools, prop_data) {
  data_single <- synth_data %>%
    dplyr::select(
      geographic_school_district,
      single_parent
    )
  
  temp <- schools %>%
    dplyr::select(
      geographic_school_district,
      INTPTLAT,
      INTPTLON,
      geometry
    ) %>%
    right_join(data_single, by = "geographic_school_district")
  
  bias <- data_single$single_parent - prop_data$single_parent
  
  bias <- bind_cols(temp$geographic_school_district, bias)
  colnames(bias) <- c("geographic_school_district", "single_parent")
  
  bias <- schools %>%
    dplyr::select(
      geographic_school_district,
      INTPTLAT,
      INTPTLON,
      geometry
    ) %>%
    right_join(bias, by = "geographic_school_district")
  
  return(bias)
}