# Notes 02 Code

# Checking the structure of the mtcars data frame
# ? is used to see what variable names mean

str(mtcars)
?mtcars


# Practice summarizing quantitative data with mtcars



# Bonus: What if I wanted 20th and 80th percentile?




# Load dplyr package to use summarize() function
# Calculate multiple statistics that will be outputted as a data frame

library(dplyr)
summarize(mtcars,
          min_mpg = min(mpg),
          max_mpg = max(mpg),
          avg_hp = mean(hp),
          sd_hp = sd(hp))


# Practice: Store above output in car_sum. Then reference avg_hp from object.





# Install the moderndive package using install.packages("moderndive") if needed
# Load moderndive package to access MA_schools data frame
# Use str() to see the structure of MA_schools

library(moderndive)
str(MA_schools)


# School size tables (counts and then proportions)

table(MA_schools$size)
prop.table(table(MA_schools$size))



# Summaries by groups (use .by argument in summarize())

summarize(MA_schools,
          count = n(),
          .by = size)


# Practice: Update earlier code to get separate summary for each transmission type
# Bonus: Add count variable too



# Get counts for each combination of am and cyl

summarize(mtcars,
          count = n(),
          .by = c(am, cyl))


# Combine code above to get summary stats for each am / cyl combination



