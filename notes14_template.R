# Notes 14 Code Template

# Load packages for this set of notes

library(infer) # for simulation-based hypothesis tests
library(ggplot2) # for stacked bar graph
library(dplyr) # for mutate()


# Hypothesis test for p1 - p2

# Read in Pew Research data

library(readr)
ACA_survey <- read_delim("https://www.openintro.org/data/tab-delimited/healthcare_law_survey.txt", "\t", 
                         escape_double = FALSE, 
                         trim_ws = TRUE) |>
  mutate(response = ifelse(response == "approve", "approve", "dont"))


# Recreate the graph of the data
# Hint: geom_bar(position) + labs(title, subtitle, x, y)


# Calculate sample difference in proportions

ACA_obsphatdiff <- ACA_survey |>
  specify(formula = response ~ order, success = "approve") |>
  calculate(stat = "diff in props", order = c("cannot_afford_second", "penalty_second"))
ACA_obsphatdiff


# Generate a null distribution

set.seed(100731)
ACA_null <- ACA_survey |>
  specify(formula = response ~ order, success = "approve") |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in props", order = c("cannot_afford_second", "penalty_second"))



# Visualize with p-value shaded and calculate the p-value





# Hypothesis test for mu1 - mu2

# Read in ESP data

esp <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/esp.csv")


# Calculate the difference in sample means (Hint: use infer)


# Generate a null distribution (template below)
# Shade the p-value on it and calculate the p-value

# null_dist <- data |>
#   specify(formula = response ~ explanatory) |>
#   hypothesize(null = "independence") |>
#   generate(reps = 1000, type = "permute") |>
#   calculate(stat = "diff in means", order = c("first", "second"))



# Theory-based test for difference in proportions

table(ACA_survey$order, ACA_survey$response)

# prop.test(x = __, n = __, alternative = __)



# Theory-based test for difference in means

# t.test(response ~ explanatory, data = data, alternative = __)