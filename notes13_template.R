# Notes 13 Code Template

# Load packages for this set of notes

library(infer) # for simulation-based hypothesis tests
library(dplyr) # for mutate()
library(ggplot2) # to visualize data


# Hypothesis test for p


# Load in tree cover data and create variable

tree_sample <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/treecover_sample.csv") |>
  mutate(increase = ifelse(Change_5years > 0, "yes", "no"))


# Create a null distribution (template below)

# set.seed(___)
# null_dist <- data |>
#   specify(formula = response ~ NULL, success = "level") |>
#   hypothesize(null = "point", p = nullvalue) |>
#   generate(reps = 1000, type = "draw") |>
#   calculate(stat = "prop")


# Calculate a p-value

cover_pval <- cover_null |>
  get_pvalue(obs_stat = cover_phat, direction = "right")
cover_pval



# Hypothesis test for mu


# Read in body temperature data

bodytemps <- data.frame(temperature = c(97.39, 97.45, 97.96, 97.35, 96.74,
                                        99.66, 98.21, 99.02, 96.78, 97.70, 
                                        96.90, 97.29, 97.99, 97.73, 98.18, 
                                        97.78, 97.17, 97.34, 97.56, 98.13, 
                                        97.77, 97.07, 97.13, 96.74, 99.10, 
                                        96.76, 96.19, 97.84, 96.80, 98.09))


# Calculate x-bar and generate a graph of the data



# Create a null distribution (template below)

# set.seed(___)
# null_dist <- data |>
#   specify(formula = response ~ NULL) |>
#   hypothesize(null = "point", mu = nullvalue) |>
#   generate(reps = 1000, type = "bootstrap") |>
#   calculate(stat = "mean")




# Theory-based hypothesis test code

# Test for p

table(tree_sample$increase) # to find values for x and n

# prop.test(x = __, n = __, p = __, alternative = __)


# Test for mu

# t.test(variable$data, mu = __, alternative = __)