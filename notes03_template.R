# Notes 3 Code

# Importing data into R


# Set our working directory to the source file location
### Session --> Set Working Directory --> To Source File Location


# Example reading in csv data
# Import Dataset --> From text (readr)





# Example where we add missing values for the last two columns





# Example reading in Excel data
# Import Dataset --> From Excel






# Functions in this set of notes are in dplyr package

library(dplyr)


# Example without pipe operator

auto <- filter(mtcars, am == 0)
auto <- mutate(mtcars, wt_lbs = 1000 * wt)
mean_wt_by_cyl <- summarize(auto, mean_wt = mean(wt_lbs), .by = cyl)
mean_wt_by_cyl <- arrange(mean_wt_by_cyl, cyl)
mean_wt_by_cyl


# Example combining functions all in one line

mean_wt_by_cyl <- arrange(summarize(mutate(filter(mtcars,
                                                  am == 0),
                                           wt_lb = 1000 * wt),
                                    mean_wt = mean(wt_lbs),
                                    .by = cyl),
                          cyl)


# Example using pipe operator

mean_wt_by_cyl <- mtcars |>
  filter(am == 0) |>
  mutate(wt_lbs = 1000 * wt) |>
  summarize(mean_wt = mean(wt_lbs), .by = cyl) |>
  arrange(cyl)
mean_wt_by_cyl
  

# Introducing filter()

auto <- filter(mtcars, am == 0)

# Practice with NC Bridges data



# Introducing select()


# Practice with alam_bridges data



# Introducing mutate()

mycars <- mutate(mtcars, wt_lbs = wt * 1000)


# Practice using NC Bridges data





# Long vs. wide data

# Read in examples of wide and long data from GitHub



# Explore the data

birds_wide
head(birds_long, n = 3)
tail(birds_long, n = 3)



# Load tidyr package for pivot_longer() and pivot_wider() functions

library(tidyr)


# Convert wide data to long data

birds_wide |>
  pivot_longer(cols = -Species,
               names_to = "Year",
               values_to = "Fledged")


birds_long |>
  pivot_wider (names_from = Year,
               values_from = Fledged)
