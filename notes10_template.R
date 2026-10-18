# Notes 10 Code Template

# Load packages for this set of notes

library(infer) # bootstrap confidence interval approaches
library(dplyr) # mutate(), slice_sample()
library(palmerpenguins) # data for intervals for mu


# Read in population from Notes 08

elon <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/elon_enrollment_f25.csv") |>
  mutate(NC = ifelse(Location == "North Carolina", "NC", "Other"))


# Take our sample from Notes 08 again

set.seed(82720)
elon_samp <- slice_sample(elon, n = 30)


# Create a bootstrap distribution using our sample

elon_boot <- elon_samp |>
  specify(NC ~ NULL, success = "NC") |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "prop")


# Use get_ci() from Notes 9 to get 90% CIs using SE method / percentile methods
# The sample proportion is needed for the SE method

elon_phat <- mean(elon_samp$NC == "NC")



# Use prop.test() to get 90% theory-based CI
# prop.test(x = __, n = __, conf.level = __)



# Calculate xbar for penguin bill lengths

bill_xbar <- mean(penguins$bill_length_mm, na.rm = TRUE)
bill_xbar


# Create bootstrap distribution of sample mean penguin bill lengths

set.seed(4392)
bill_boot <- penguins |>
  specify(formula = bill_length_mm ~ NULL) |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "mean")

visualize(bill_boot)


# Use get_ci() from Notes 9 to get 95% CIs using SE method or percentile method



# Use t.test() to get 95% theory-based CI
# t.test(x = __$__, conf.level = __)