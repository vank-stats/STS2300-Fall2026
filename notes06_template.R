# Notes 06 Code Template

# Load packages for this set of notes

library(ggplot2)


# Read in data from GitHub page

fastfood <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/FastFoodAccuracy.csv")


# Scatterplot of fast food data

ggplot(fastfood, aes(x = SecPerOrder, 
                     y = PctWithErrors)) +
  geom_point() +
  labs(x = "Average Seconds Per Drive-Thru Order",
       y = "Percentage of Orders with Errors",
       title = "Fast Food Drive Thru Accuracy") +
  theme_classic()


# Simple linear regression - predicting PctWithErrors using SecPerOrder

lm(PctWithErrors ~ SecPerOrder, 
   data = fastfood)


# Example using piping

fastfood |>
  lm(PctWithErrors ~ SecPerOrder, 
     data = _)


# Using predict() to find predicted values

fastfood.lm <- lm(PctWithErrors ~ SecPerOrder, 
                  data = fastfood)
predict(fastfood.lm, 
        newdata = data.frame(SecPerOrder = 500))


# Finding R^2 (coefficient of determination)

summary(fastfood.lm)
