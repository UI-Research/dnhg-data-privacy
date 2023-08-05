# Code and Example Data for the "Do No Harm Guide: Applying Equity Awareness in Data Privacy Methods"

This repo/folder contains code used to generate the examples in the "Do No Harm Guide: Applying Equity Awareness in Data Privacy Methods", which can be found [here](https://www.urban.org/research/publication/do-no-harm-guide-applying-equity-awareness-data-privacy-methods).

**Disclaimer:** Please note that the analyses in this chapter are inspired by real data and public policy analytics but are not representative of them.

## Abstract
Researchers and organizations can increase privacy in datasets through methods such as aggregating, suppressing, or substituting random values. But these means of protecting individuals’ information do not always equally affect the groups of people represented in the data. A published dataset might ensure the privacy of people who make up the majority of the dataset but fail to ensure the privacy of those in smaller groups. Or, after undergoing alterations, the data may be more useful for learning about some groups more than others. Ultimately, how entities collect and share data can have varying effects on marginalized and underrepresented groups of people.

To understand the current state of ideas, we completed a literature review of equity-focused work in statistical data privacy (SDP) and conducted interviews with nine experts on privacy-preserving methods and data sharing. These experts include researchers and practitioners from academia, government, and industry sectors with diverse technical backgrounds. We asked about their experience implementing data privacy and confidentiality methods and how they define equity in the context of privacy, among other topics. We also created an illustrative example to highlight potential disparities that can result from applying SDP methods without an equitable workflow.

## Data
The data are from a Urban research report called, "[Mapping Student Needs during COVID-19](https://www.urban.org/research/publication/mapping-student-needs-during-covid-19)" and can be accessed at [Urban Data Catalog](https://datacatalog.urban.org/dataset/household-conditions-geographic-school-district).

## Code Information

### Recommended Libraries
- [tidyverse](https://www.tidyverse.org/) is a suite of R packages by RStudio that help with data structure, data analysis, and data visualization.
- [knitr](https://yihui.org/knitr/) is a transparent engine for dynamic report generation with R, and combine features in other add-on packages into one package.
- [readxl](https://readxl.tidyverse.org/) is a R package that makes it easy to get data out of Excel and into R.
- [smoothmest](https://cran.r-project.org/web/packages/smoothmest/index.html) is a R package that we use for sampling from a Laplace distribution.
- [tigris](https://cran.r-project.org/web/packages/tigris/index.html) is a R package that provides state and county shapefiles that are compatible to map with ggplot2.
- [urbnthemes](https://github.com/UrbanInstitute/urbnthemes) is a set of tools for creating Urban Institute-themed plots and maps in R. The package extends ggplot2 with print and map themes as well as tools that make plotting easier at the Urban Institute.
- [patchwork](https://patchwork.data-imaginist.com/) is a R package that simplifies combining separate ggplots into the same graphic.
- [doParallel](https://cran.r-project.org/web/packages/doParallel/doParallel.pdf) is a R package that provides parallel backend.
- [svglite](https://www.tidyverse.org/blog/2021/02/svglite-2-0-0/) is a R package that creates SVG files from R graphics.

### rcode Directory

This directory contains the `.R` scripts for the used in the paper except for some basic functions that we will list in the next section.

  - `broadband_fun.R` is the R script wrapper for generating the broadband/computer school district plots.
  - `dp_count.R` is the R script for smart rounded DP values for multiple counts.
  - `dp_fun.R` is the R script wrapper for generating DP data.
  - `helper_functions.R` is the R script for smartly round numbers to integers. This functions works accurately on grouped dataframes (ie applies the rounding within each group).
  - `k-suppression.R` is the R script for generating suppressed data.
  - `lap_san.R` is the R script wrapper for synth-count.R.
  - `parent_fun.R` is the R script wrapper for for generating the single parent school district plots.
  - `post_processing.R` is the R script for post-processing the values (i.e., factor counts cannot exceed total counts).
  - `synth.R` is the R script wrapper for generating the broadband/computer school district plots.
  - `synth_count.R` is the R script for generating synthetic data via a multinomial distribution.
  - `synth_fun.R` is the R script wrapper for generating synthetic data.

## Contact Information
- Claire McKay Bowen, PhD (cbowen@urban.org)
