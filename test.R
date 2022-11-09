The first dataset is the 2014 through 2018 single year microdata samples that create estimates for each public-use microdata area or PUMA.* PUMAs are "... non-overlapping, statistical geographic areas that partition each state or equivalent entity into geographic areas containing no fewer than 100,000 people each" ([U.S. Census Bureau](https://www.census.gov/programs-surveys/geography/guidance/geo-areas/pumas.html)).

* The authors explain in their report that they "...use[d] five one-year samples rather than the five-year file because of a slight change in the question about highspeed internet access between 2015 and 2016".

```{r}
#| label: load-data
#| code-summary: "data"
#| message: false
#| warning: false

# PUMA Data, select down and reorder the variables
data_puma <- read_csv("data/data/puma_level_kids_2.csv") %>%
  dplyr::select(
    in_poverty,
    linguistically_isolated,
    child_w_disability,
    vulnerable_sector_hh,
    single_parent,
    crowded_conditions, 
    no_comp_or_no_internet
  )

```













## Utility

### Correlation Matrix
Our first utility metric is replicating the correlation matrix from the original report, but for the New Mexico State data.

#### Original Data
The Urban report focused on what factors were highly correlated with poverty. Based on the correlation matrix, we see that "lack of computer or broadband access" is most correlated (0.53) with "single parents" is next (0.39). The other factors would be considered weak, where the values are under 0.15 (the next largest at 0.12).

We will see if the altered datasets preserve this relationship. 
```{r}
#| label: fig-nm-cor
#| fig-cap: "Correlations between Measures of Vulnerability across PUMAs in New Mexico"
#| warning: false

# Correlation values
cor_nm <- data %>%
  cor()
cor_nm[upper.tri(cor_nm)] <- NA

# Correlation matrix
cor_nm %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(cor_nm))),
    var2 = factor(var2, levels = colnames(cor_nm))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() + 
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)
```



Calculating the correlation values when k = 10.
```{r}
#| label: cor-suppressed-10
#| code-summary: "cor-suppressed-10"
#| message: false
#| warning: false

# Correlation values
cor_supp <- nm_supp_10[, -c(1:4)] %>%
  cor()
cor_supp[upper.tri(cor_supp)] <- NA

bias_supp <- cor_supp - cor_nm

bias_supp %>% abs() %>% sum(na.rm = TRUE) %>% round(digits = 2)
```

Generating the correlation matrix figures.

For the suppressed data, we see that "lack of computer or broadband access" is still the most correlated (0.61) with "single parents" is next (0.44). These values are higher than the original data, and we have "parents in vulnerable economic sectors" has a moderate signal at 0.24, which was much weaker in the original data.

Overall, the L1 difference on the correlation matrix is 1.33.

```{r}
#| label: fig-cor-suppressed-10
#| fig-cap: "Correlations between Measures of Vulnerability across PUMAs in New Mexico (Suppressed, k = 10)"
#| fig-subcap:
#|   - "Correlations (Suppressed, k = 10)"
#|   - "Correlations Bias" 
#| warning: false

# Correlation matrix for suppressed data
cor_supp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(cor_supp))),
    var2 = factor(var2, levels = colnames(cor_supp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() + 
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)

# Correlation matrix for suppressed data - original data
bias_supp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(bias_supp))),
    var2 = factor(var2, levels = colnames(bias_supp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)
```

#### Synthetic Data

Calculating the correlation values.
```{r}
#| label: cor-synthetic
#| code-summary: "cor-synthetic"
#| message: false
#| warning: false

# Correlation values
cor_synth <- nm_synth[, -c(1:4)] %>%
  cor()
cor_synth[upper.tri(cor_synth)] <- NA

bias_synth <- cor_synth - cor_nm

bias_synth %>% abs() %>% sum(na.rm = TRUE) %>% round(digits = 2)
```

Generating the correlation matrix figures.

For the synthetic data, we see that "lack of computer or broadband access" is still the most correlated (0.37) with "single parents" is next (0.31). These values are lower than the original data, but the other factors are still weak values.

Overall, the L1 difference on the correlation matrix is 1.01.

```{r}
#| label: fig-cor-synthetic
#| fig-cap: "Correlations between Measures of Vulnerability across PUMAs in New Mexico (Synthetic)"
#| fig-subcap:
#|   - "Correlations (Synthetic)"
#|   - "Correlations Bias" 
#| warning: false

# Correlation matrix for suppressed data
cor_synth %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(cor_synth))),
    var2 = factor(var2, levels = colnames(cor_synth))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() + 
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)

# Correlation matrix for suppressed data - original data
bias_synth %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(bias_synth))),
    var2 = factor(var2, levels = colnames(bias_synth))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)
```

#### DP Data

Calculating the correlation values for $\epsilon$ = 0.5.
```{r}
#| label: cor-dp-05
#| code-summary: "cor-dp-05"
#| message: false
#| warning: false

# Correlation values
cor_dp <- nm_dp05[, -c(1:4)] %>%
  cor()
cor_dp[upper.tri(cor_dp)] <- NA

bias_dp <- cor_dp - cor_nm

bias_dp %>% abs() %>% sum(na.rm = TRUE) %>% round(digits = 2)
```

Generating the correlation matrix figures.

For the synthetic data, we see that "lack of computer or broadband access" is still the most correlated (0.37) with "single parents" is next (0.31). These values are lower than the original data, but the other factors are still weak values.

Overall, the L1 difference on the correlation matrix is 1.15.

```{r}
#| label: fig-cor-dp-05
#| fig-cap: "Correlations between Measures of Vulnerability across PUMAs in New Mexico (Differentially Private, eps = 0.5)"
#| fig-subcap:
#|   - "Correlations (Differentially Private, eps = 0.5)"
#|   - "Correlations Bias" 
#| warning: false

# Correlation matrix for suppressed data
cor_dp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(cor_dp))),
    var2 = factor(var2, levels = colnames(cor_dp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() + 
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)

# Correlation matrix for suppressed data - original data
bias_dp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(bias_dp))),
    var2 = factor(var2, levels = colnames(bias_dp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)
```


Calculating the correlation values for $\epsilon$ = 1.
```{r}
#| label: cor-dp-1
#| code-summary: "cor-dp-1"
#| message: false
#| warning: false

# Correlation values
cor_dp <- nm_dp1[, -c(1:4)] %>%
  cor()
cor_dp[upper.tri(cor_dp)] <- NA

bias_dp <- cor_dp - cor_nm

bias_dp %>% abs() %>% sum(na.rm = TRUE) %>% round(digits = 2)
```

Generating the correlation matrix figures.

For the synthetic data, we see that "lack of computer or broadband access" is still the most correlated (0.51) with "single parents" is next (0.41). These values are lower than the original data, and the other factors are still weak values.

Overall, the L1 difference on the correlation matrix is 0.53.

```{r}
#| label: fig-cor-dp-1
#| fig-cap: "Correlations between Measures of Vulnerability across PUMAs in New Mexico (Differentially Private, eps = 1)"
#| fig-subcap:
#|   - "Correlations (Differentially Private, eps = 1)"
#|   - "Correlations Bias" 
#| warning: false

# Correlation matrix for suppressed data
cor_dp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(cor_dp))),
    var2 = factor(var2, levels = colnames(cor_dp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() + 
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)

# Correlation matrix for suppressed data - original data
bias_dp %>%
  as_tibble(rownames = "var1") %>%
  pivot_longer(cols = -var1, names_to = "var2", values_to = "correlation") %>%
  mutate(
    var1 = factor(var1, levels = rev(colnames(bias_dp))),
    var2 = factor(var2, levels = colnames(bias_dp))
  ) %>%
  ggplot(aes(var1, var2, fill = correlation)) +
  geom_tile() +
  geom_text(aes(label = round(correlation, 2))) +
  scale_fill_gradientn(colours = palette_urbn_diverging, na.value = "white", limits = c(-1, 1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(x = NULL, y = NULL)
```