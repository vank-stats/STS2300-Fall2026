# Notes 3 Code

# Importing data into R


# Set our working directory to the source file location
### Session --> Set Working Directory --> To Source File Location


# Example reading in csv data
# Import Dataset --> From text (readr)

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv")


# Example where we add missing values for the last two columns

library(readr)
NC_Bridges <- read_csv("NC Bridges.csv", 
                       na = "Not Posted")


# Example reading in Excel data
# Import Dataset --> From Excel

library(readxl)
majors <- read_excel("MTH_STS_Majors.xlsx")


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

# Create a subset of our NC Bridges data that only includes bridges 
# from Alamance County (call it alam_bridges)

alam_bridges <- filter(NC_Bridges, COUNTY == "ALAMANCE")

# Or, using piping

alam_bridges <- NC_Bridges |>
  filter(COUNTY == "ALAMANCE")


# Create a subset that includes bridges that are structurally deficient (“SD”) 
# and functionally obsolete (“FO”).

bad_bridges <- NC_Bridges |>
  filter(STRUCTURALLYDEFICIENT == "SD",
         FUNCTIONALLYOBSOLETE == "FO")

# Create a subset of Alamance bridges that includes bridges that are 
# structurally deficient (“SD”) OR functionally obsolete (“FO”).

bad_alam_bridges <- alam_bridges |>
  filter(STRUCTURALLYDEFICIENT == "SD" | FUNCTIONALLYOBSOLETE == "FO")


# Introducing select()

# Use select() to update alam_bridges to only include ROUTE, ACROSS, YEARBUILT,
#   and SR

alam_bridges <- select(alam_bridges, ROUTE, ACROSS, YEARBUILT, SR)



# Introducing mutate()

mycars <- mutate(mtcars, wt_lbs = wt * 1000)


# Practice: Using the NC Bridges data, create a new variable called AGE 
#   that takes 2026 minus YEARBUILT. 
#   Then print the year built and age for the last 10 bridges in the data.

NC_Bridges <- mutate(NC_Bridges, AGE = 2026 - YEARBUILT)

select(NC_Bridges, YEARBUILT, AGE) |>
  tail(n = 10)


# Long vs. wide data

# Read in examples of wide and long data from GitHub

birds_wide <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/nestbox_lands_wide.csv")
birds_long <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/nestbox_lands_long.csv")


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
