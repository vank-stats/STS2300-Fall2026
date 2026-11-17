# Notes 15 Code Template

# Load packages for this set of notes

library(infer) # for simulation-based tests
library(ggplot2) # for box plot
library(dplyr) # for mutate()


# Chi-Squared Tests

# Read in Elon Poll data on if college is "worth it"

college <- data.frame(
  worthit = factor(c(rep("def_yes", 263), rep("prob_yes", 197), 
                     rep("prob_no", 90), rep("def_no", 47),
                     rep("def_yes", 527), rep("prob_yes", 331),
                     rep("prob_no", 88), rep("def_no", 29)),
                   levels = c("def_yes", "prob_yes", "prob_no", "def_no")),
  firstgen = c(rep("yes", 263 + 197 + 90 + 47), 
               rep("no", 527 + 331 + 88 + 29)))

table(college$worthit, college$firstgen)



# Create an appropriate graph





# Calculate a chi-squared statistic (two options)

# Using infer

# data |>
#   specify(var1 ~ var2) |>
#   calculate(stat = "Chisq")

# Using chisq.test()

# chisq.test(data$var1, data$var2)





# Generate a null distribution and visualize with p-value

# null_dist <- data |>
#   specify(formula = var1 ~ var2) |>
#   hypothesize(null = "independence") |>
#   generate(reps = 1000, type = "permute") |>
#   calculate(stat = "Chisq")









# ANOVA Tests

# Read in tennis data and graph it

tennis <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/atp_matches_2023_analysis.csv") |>
  mutate(ace_rate = total_aces / total_ServiceGames)

ggplot(tennis, aes(x = surface, y = ace_rate, fill = surface)) +
  geom_boxplot(outliers = FALSE, alpha = 0.5) +
  geom_jitter(height = 0, width = 0.3, size = 1, alpha = 0.3) +
  theme_classic()






# Calculate an ANOVA F statistic (two options)

# Using infer

# data |>
#   specify(response ~ explanatory) |>
#   calculate(stat = "F")

# Using chisq.test()

# aov(response ~ explanatory, data = data) |>
#   summary()





# Generate a null distribution and visualize with p-value

# null_dist <- data |>
#   specify(formula = response ~ explanatory) |>
#   hypothesize(null = "independence") |>
#   generate(reps = 1000, type = "permute") |>
#   calculate(stat = "F")