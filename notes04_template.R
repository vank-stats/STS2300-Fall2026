# Code for Notes 04

### 2. The ggplot2 package

# Example scatterplot

library(ggplot2)
ggplot(data = mtcars) +
  geom_point(aes(x = wt,
                 y = mpg))


# Practice

# Scatterplot of hp vs. mpg



# Bar graph of am





### 3. Types of graphs

## Scatterplots

# Practice: Take the scatterplot we made above and see if you can 
#  - make the points purple,
#  - bigger than they were before, 
#  - slightly transparent, 
#  - and triangles instead of circles.






## Histograms

# Practice: Recreate histogram using airquality data.
#  - Temp is on x axis
#  - bars are orange with white borders
#  - each bar is 5 degrees wide and start/end on 0s and 5s







## Boxplots

# Example graph in the notes

ggplot(data = mtcars) +
  geom_boxplot(aes(x = as.factor(am),
                   y = mpg))


# Practice: Recreate boxplot using Toothgrowth data.
#  - supp is on x axis and len is on y axis
#  - boxes are black with pink borders






## Bar graphs

# Practice: Recreate bar graph using diamonds data.
#  - check if diamonds is raw or summarized data
#  - cut is on the x axis and is also mapped to the fill inside the bars
#  - the border of the bars is black








### 4. Adding additional variables to our graphs

# Example bar graph changing fill by cut variable and border color

ggplot(data = diamonds) +
  geom_bar(aes(x = cut,
               fill = cut),
           color = "black")


# Example scatterplot changing color by drat variable and shape by am variable

ggplot(mtcars) +
  geom_point(aes(x = wt,
                 y = mpg,
                 color = drat,
                 shape = as.factor(am)))

# Example scatterplot changing color by am variable and transparency by drat

ggplot(mtcars) +
  geom_point(aes(x = wt,
                 y = mpg,
                 color = as.factor(am),
                 alpha = drat))



### Revisiting learning goals - four graphs to recreate

