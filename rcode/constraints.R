#################################################################################
# 	Constraints Code
#################################################################################

# Function to enforce physical constraints on the synthetic data
### NOTE: This is not a robust function. Very specific for this project.

# INPUTS:
#   dat: data (df) in the format of "naics_code", "tract_geoid", "num_employee",
#        and "num_firms"
# OUTPUTS:
#   mod_dat: synthetic data with corrected values based on constraints

constraint <- function(dat) {
    ## Record how many jobs will be added/subtracted due to constraints in each
    # industry-county combination
    added <- dat %>%
        filter(num_employee < num_firms) %>%
        mutate(added_empl = num_firms - num_employee) %>%
        group_by(county_geoid, naics_code) %>%
        summarize(added_empl = sum(added_empl))
    subtracted <- dat %>%
        filter(num_employee != 0 & num_firms == 0) %>%
        mutate(subtracted_empl = num_employee) %>%
        group_by(county_geoid, naics_code) %>%
        summarize(subtracted_empl = sum(subtracted_empl))
    employee_change <- full_join(added, subtracted, by = c("county_geoid", "naics_code")) %>%
        # replace NA's with 0 as full join returns NA if there are no
        # subtracted/added jobs for the given industry/county combo.
        mutate(across(ends_with("_empl"), ~ if_else(is.na(.x), 0, .x))) %>%
        mutate(employee_change = added_empl - subtracted_empl) %>%
        select(county_geoid, naics_code, employee_change)
    print(employee_change)

    ## Apply constraints
    mod_dat <- dat %>%
        # # Ensuring number of employees equal to the number of firms
        # # This adds fake employees to ensure constraint is met.
        # mutate(
        #     num_employee = if_else(
        #         (num_employee < num_firms),
        #         as.double(num_firms),
        #         as.double(num_employee)
        #     )
        # ) %>%
        # Ensuring there are no employees if firm count is 0
        # This subtracts fake employees to ensure contraint is met.
        mutate(
            num_employee = if_else(
                (num_employee != 0 & num_firms == 0),
                # Need as.integer as if_else is type stable and requires same type for
                # TRUE and FALSE conditions
                as.double(0),
                num_employee
            )
        )

    # TODO: Decide with BLS whether we should randomly subtract/add the inflated
    # TODO: counts from the tracts to ensure counts add up with county total

    return(mod_dat)
}