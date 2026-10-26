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

set.seed(112300)
dog_boot <- covid_dog |>
  specify(formula = correct ~ actual, success = "yes") |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "diff in props", order = c("positive", "negative"))

visualize(dog_boot)


# Use get_ci() from Notes 9 to get 99% CI using percentile method

dog_ci <- dog_boot |>
  get_ci(level = 0.99, type = "percentile")
dog_ci

visualize(dog_boot) +
  shade_ci(dog_ci)

# Note: We can use specify() and calculate() to get a sample diff. in proportions
# if we wanted to make an SE method interval

dog_diff <- covid_dog |>
  specify(formula = correct ~ actual, success = "yes") |>
  calculate(stat = "diff in props", order = c("positive", "negative"))


# Use prop.test() to get 99% theory-based CI
# prop.test(x = c(__, __), n = c(__, __))

table(covid_dog$correct, covid_dog$actual)
prop.test(x = c(157, 792), n = c(157 + 30, 792 + 33), conf.level = 0.99)

prop.test(x = c(157, 792), n = c(157 + 30, 792 + 33), conf.level = 0.99)$conf.int



# Subset penguins data to just Adelie penguins not missing sex data

adelie <- filter(penguins, species == "Adelie",
                 !is.na(sex))


# Fill in blanks for bootstrap distribution
# Use Ctrl (or Command) + Shift + C to un-comment

set.seed(112300)
adelie_boot <- adelie |>
  specify(formula = bill_length_mm ~ sex) |>
  generate(reps = 1000, type = "bootstrap") |>
  calculate(stat = "diff in means", order = c("male", "female"))

visualize(adelie_boot)


# Make 90% CI using the SE method
# First find difference in means (see COVID dog example)

adelie_diff <- adelie |>
  specify(formula = bill_length_mm ~ sex) |>
  calculate(stat = "diff in means", order = c("male", "female"))
adelie_diff

adelie_boot |>
  get_ci(level = 0.9, type = "se", point_estimate = adelie_diff)


# Make 90% theory-based interval using t.test()\

# Option 1
# t.test(__ ~ __, data = __)

t.test(bill_length_mm ~ sex, data = adelie, conf.level = 0.9)

# Option 2
# t.test(__$__ ~ __$__)

