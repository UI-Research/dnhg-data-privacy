################################################################################
#	Exploratory
################################################################################

# Claire: Exploring the data to see if it will work as microlevel data for the 
# project. Also, verifying the end impact (resource allocation decisions).

# Libraries
library(tidyverse)
library(urbnthemes)
library(readxl)
library(reshape2)
library(smoothmest)

# Load Data
data <- read_excel("data/data-raw/nhgis_district_data_var.xlsx") %>%
  dplyr::select(state, geographic_school_district, children_5_17, poverty, 
                single_parent, vulnerable_job, crowded_conditions, 
                no_computer_internet, children_disability,
                linguistically_isolated)

data_nm <- data %>%
  filter(state == "New Mexico") %>%
  mutate(poverty = round(children_5_17 * poverty),
         single_parent = round(children_5_17 * single_parent),
         vulnerable_job = round(children_5_17 * vulnerable_job),
         crowded_conditions = round(children_5_17 * crowded_conditions),
         no_computer_internet = round(children_5_17 * no_computer_internet),
         children_disability = round(children_5_17 * children_disability),
         linguistically_isolated = round(children_5_17 * linguistically_isolated)
  )

data_pa <- data %>%
  filter(state == "Pennsylvania") %>%
  mutate(poverty = round(children_5_17 * poverty),
         single_parent = round(children_5_17 * single_parent),
         vulnerable_job = round(children_5_17 * vulnerable_job),
         crowded_conditions = round(children_5_17 * crowded_conditions),
         no_computer_internet = round(children_5_17 * no_computer_internet),
         children_disability = round(children_5_17 * children_disability),
         linguistically_isolated = round(children_5_17 * linguistically_isolated)
  )

# Suppression, synthetic, DP synthetic, DP query



data_cor <- cor(data[, -c(1:3)])


nm_cor <- cor(data_nm[, -c(1:3)])


ggplot(data = data[, -c(1:3)], aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile()
