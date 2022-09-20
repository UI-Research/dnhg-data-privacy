# Smartly round numbers to integers. This functions works
# accurately on grouped dataframes (ie applies the rounding within each group)
smart_round <- function(x) {
  y <- floor(x)
  indices <- tail(order(x - y), round(sum(x)) - sum(y))
  y[indices] <- y[indices] + 1

  return(y)
}

# Safely divide
safe_divide <- function(num, denom) {
  if (num == 0) {
    return(0)
  } else {
    return(num / denom)
  }
}