################################################################################
#	Gaussian Mechanism
################################################################################

# Function for adding approximate or (epsilon, delta)-DP noise to a statistic or
# query.
#
# INPUTS:
#   n: number of draws (int)
#   eps: epsilon, privacy loss (num)
#   delta: delta tuning parameter that is a non-zero probability (num)
#   GS: L2 global sensitivity of the specific query (num)
# OUTPUTS:
#   x: n number of draws from a normal distribution that satisifies approx-DP
gauss_mech <- function (n, eps, delta, GS) {
  
  # Standard Deviation for the Gaussian Mechanism
  gauss_sd <- (GS / eps) * sqrt(2 * log(1.25 / delta))
  
  # Draw from a normal distribution
  x <- rnorm(n, mean = 0, sd = gauss_sd)
  
  return(x)
}