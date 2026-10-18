# Notes 11 Code Template

# Load packages for this set of notes

library(infer) # bootstrap confidence interval approaches
library(dplyr) # mutate(), filter()
library(palmerpenguins) # penguins data


# Read in COVID sniffing dog data

covid_dog <- data.frame(ID = c(rep("positive", 157), rep("negative", 792),
                               rep("positive", 33), rep("negative", 30)),
                        actual = c(rep("positive", 157), rep("negative", 792),
                                   rep("negative", 33), rep("positive", 30))) |>
  mutate(correct = ifelse(ID == actual, "yes", "no"))


# Bootstrap distribution template
# boot_dist <- data |>
#   specify(formula = response ~ explanatory, success = "level") |>
#   generate(reps = 1000, type = "bootstrap") |>
#   calculate(stat = "diff in props", order = c("group 1", "group 2"))


# COVID sniffing dog boostrap template
# Use Ctrl (or Command) + Shift + C to un-comment

# set.seed(___)
# dog_boot <- ___ |>
#   specify(formula = ___ ~ ___, success = "___") |>
#   generate(reps = 1000, type = "bootstrap") |>
#   calculate(stat = "___", order = c("___", "___"))
# 
# visualize(___)


# Use get_ci() from Notes 9 to get 99% CI using percentile method




# Note: We can use specify() and calculate() to get a sample diff. in proportions
# if we wanted to make an SE method interval

dog_diff <- covid_dog |>
  specify(formula = correct ~ actual, success = "yes") |>
  calculate(stat = "diff in props", order = c("positive", "negative"))


# Use prop.test() to get 99% theory-based CI
# prop.test(x = c(__, __), n = c(__, __))

table(covid_dog$correct, covid_dog$actual)



# Subset penguins data to just Adelie penguins not missing sex data

adelie <- filter(penguins, species == "Adelie",
                 !is.na(sex))


# Fill in blanks for bootstrap distribution
# Use Ctrl (or Command) + Shift + C to un-comment

# set.seed(___)
# adelie_boot <- ___ |>
#   specify(formula = ___ ~ ___) |>
#   generate(reps = 1000, type = "bootstrap") |>
#   calculate(stat = "___", order = c("___", "___"))
# 
# visualize(___)


# Make 90% CI using the SE method
# First find difference in means (see COVID dog example)




# Make 90% theory-based interval using t.test()\

# Option 1
# t.test(__ ~ __, data = __)

# Option 2
# t.test(__$__ ~ __$__)