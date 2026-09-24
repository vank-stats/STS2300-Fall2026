# Code for Notes 04

### 2. The ggplot2 package

# Example scatterplot

library(ggplot2)
ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg))

# Practice

# Scatterplot of hp vs. mpg

ggplot(data = mtcars) +
  geom_point(aes(x = hp,
                 y = mpg))

# Bar graph of am

ggplot(data = mtcars) +
  geom_bar(aes(x = am))

# We can use as.factor() to tell R to treat the am variable as categorical
# (before this it was treating it as quantitative)

ggplot(data = mtcars) +
  geom_bar(aes(x = as.factor(am)))



### 3. Types of graphs

## Scatterplots

# Practice: Take the scatterplot we made above and see if you can 
#  - make the points purple,
#  - bigger than they were before, 
#  - slightly transparent, 
#  - and triangles instead of circles.

ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg),
             color = "purple",
             size = 5,
             alpha = 0.5,
             shape = 17)


## Histograms

# Practice: Recreate histogram using airquality data.
#  - Temp is on x axis
#  - bars are yellow with white borders
#  - each bar is 5 degrees wide and start/end on 0s and 5s

ggplot(data = airquality) +
  geom_histogram(aes(x = Temp),
                 binwidth = 5,
                 fill = "orange",
                 color = "white",
                 boundary = 80)

# Note: You could also use bins = 9 instead of binwidth = 5


## Boxplots

# Example graph to illustrate

ggplot(data = mtcars) +
  geom_boxplot(aes(x = as.factor(am),
                   y = mpg))


# Practice: Recreate boxplot using Toothgrowth data.
#  - supp is on x axis and len is on y axis
#  - boxes are black with pink borders

ggplot(data = ToothGrowth) +
  geom_boxplot(aes(x = supp, 
                   y = len),
               fill = "black",
               color = "pink")


## Bar graphs

# Practice: Recreate bar graph using diamonds data.
#  - diamonds is raw data, so we use geom_bar()
#  - cut is on the x axis and is also mapped to the fill inside the bars
#  - the border of the bars is black

ggplot(data = diamonds) +
  geom_bar(aes(x = cut, 
               fill = cut),
           color = "black")

# Example that creates a summarized version to illustrate geom_col()

diamonds_summarized <- diamonds |>
  dplyr::summarize(n = n(),
                   .by = cut)

ggplot(data = diamonds_summarized) +
  geom_col(aes(x = cut, 
               y = n,
               fill = cut),
           color = "black")


### 4. Adding additional variables to our graphs

ggplot(mtcars) +
  geom_point(aes(x = wt,
                 y = mpg,
                 color = drat,
                 shape = as.factor(am)))

ggplot(mtcars) +
  geom_point(aes(x = wt,
                 y = mpg,
                 color = as.factor(am),
                 alpha = drat))



### Revisiting learning goals

ggplot(midwest) +
  geom_histogram(aes(x = popdensity),
                 fill = "red",
                 color = "black",
                 boundary = 0,
                 binwidth = 5000)

ggplot(midwest) +
  geom_bar(aes(x = state,
               fill = state),
           color = "orange")

ggplot(midwest) +
  geom_point(aes(x = percollege,
                 y = percbelowpoverty,
                 color = poptotal),
             shape = "diamond",
             size = 5,
             alpha = 0.5)

ggplot(midwest) +
  geom_boxplot(aes(x = percollege,
                   y = state),
               fill = "yellow",
               color = "blue")
