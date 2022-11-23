# Code and Example Data for the "Do No Harm Guide: Applying Equity Awareness in Data Privacy Methods"

This repo/folder contains code used to generate the examples in the "Do No Harm Guide: Applying Equity Awareness in Data Privacy Methods", which can be found [here](XXXX).

**Disclaimer:** Please note that the analyses in this chapter are inspired by real data and public policy analytics but are not representative of them.

## Abstract
President Biden signed an executive order directing federal agencies and White House offices to examine barriers to racial equity and initiated several efforts to address equity for people of color and underserved communities. Statistical data privacy (or statistical disclosure control) methods provide a possible solution for researchers or data policy makers with access to data or statistics while preserving participants’ privacy. These methods try to balance the need for accurate information (utility) against reducing the risk disclosure from what is released; however, standard data privacy methodologies do not explicitly consider racial equity. In this talk, I will introduce a guide that my colleague and I created that provides recommendations for what data privacy methods may be most useful when facing sample size issues that tend to greatly impact underrepresented communities. The report also includes interviews with leading researchers in the data privacy and confidentiality field, where we will seek to understand both how and to what extent they consider the questions of equity in their work. 

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
- [doParallel](https://cran.r-project.org/web/packages/doParallel/doParallel.pdf) is a R package that provides parallel backend

### rcode Directory

This directory contains the `.R` scripts for the used in the paper except for some basic functions that we will list in the next section.

  - `XXX.R` is the R script to XXXX.
  
### Commonly Used R Functions
The following is a list of R functions we used from other packages to generate our results.

  - `XXX.R` is the R script to XXXX.

## Contact Information
- Claire McKay Bowen, PhD (cbowen@urban.org)