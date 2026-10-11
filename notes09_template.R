# Notes 09 Code Template

# Load packages for this set of notes

library(ggplot2) # basic graphs
library(dplyr) # summarize(), mutate(), select(), slice_sample()
library(infer) # sampling functions
library(patchwork) # combining graphs


# Read in population from Notes 08

elon <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/elon_enrollment_f25.csv") |>
  mutate(NC = ifelse(Location == "North Carolina", "NC", "Other"))


# Take our sample from Notes 08 again

set.seed(82720)
mysamp <- slice_sample(elon, n = 30)
table(mysamp$NC)


# Create a bootstrap distribution using our sample

elon_boot <- mysamp |>
  specify(NC ~ NULL, success = "NC") |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "prop")

visualize(elon_boot)


# Method 1: Calculating a 90% theory-based interval (the long way)

phat <- mean(mysamp$NC == "NC")
phat

ci_theory <- c(phat - 1.645 * sqrt(phat * (1 - phat) / 30),
               phat + 1.645 * sqrt(phat * (1 - phat) / 30))
ci_theory


# Method 2: Calculating a 90% interval with SE method (manually)

boot_sd <- sd(elon_boot$stat)
c(phat - 1.645 * boot_sd, phat + 1.645 * boot_sd)

# Method 2: Calculating a 90% interval with SE method (using infer)

ci_se <- elon_boot |>
  get_ci(level = 0.9, type = "se", point_estimate = phat)
ci_se


# Method 3: Calculating a 90% interval with percentile method (using infer)

ci_perc <- elon_boot |>
  get_ci(level = 0.9, type = "percentile")
ci_perc


# Graphing Methods 2 and 3

visualize(elon_boot) +
  shade_ci(ci_se)

visualize(elon_boot) +
  shade_ci(ci_perc, fill = "violet", color = "lightpink")
