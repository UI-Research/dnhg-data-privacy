################################################################################
# 	Broadband Wrapper
################################################################################
# Function that is a wrapper for generating the broadband/computer
# school district plots
# INPUTS:
#     synth_data: synthetic dataframe (df)
#     schools: school district shape files (sf)
#     prop_data: confidential data (df)
# OUTPUTS:
#     dp_data: dp data (df)

broadband_fun <- function(synth_data, schools, prop_data) {
  data_broadband <- synth_data %>%
    dplyr::select(
      geographic_school_district,
      no_computer_internet
    )
  
  temp <- schools %>%
    dplyr::select(
      geographic_school_district,
      INTPTLAT,
      INTPTLON,
      geometry
    ) %>%
    right_join(data_broadband, by = "geographic_school_district")
  
  bias <- data_broadband$no_computer_internet - prop_data$no_computer_internet
  
  bias <- bind_cols(temp$geographic_school_district, bias)
  colnames(bias) <- c("geographic_school_district", "no_computer_internet")
  
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