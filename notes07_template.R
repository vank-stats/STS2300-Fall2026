# Notes 07 Code Template

# Load packages for this set of notes

library(ggplot2) # for graphs
library(dplyr) # for select() to subset data
library(patchwork) # to combine graphs
library(Lock5Data) # for a dataset


# Grab data from Lock5Data package and subset

cars <- Cars2015 |>
  select(HwyMPG, Length, Height, Acc060, Weight)


# Create grid of four graphs comparing variables to HwyMPG

g <- ggplot(cars, aes(y = HwyMPG)) + theme_classic()
g1 <- g + geom_point(aes(x = Length))
g2 <- g + geom_point(aes(x = Height))
g3 <- g + geom_point(aes(x = Acc060))
g4 <- g + geom_point(aes(x = Weight))

(g1 + g2) / (g3 + g4) 


# Mutliple linear regression predicting HwyMPG with other variables

lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)


# Making predictions with predict()

cars.lm <- lm(HwyMPG ~ Length + Height + Acc060 + Weight, data = cars)

predict(cars.lm, newdata = data.frame(Length = 192, 
                                      Height = 72, 
                                      Acc060 = 7.7,
                                      Weight = 4505))


# Graphing actual HwyMPG against predictions from our model

cars$predictedHwyMPG <- predict(cars.lm)

ggplot(cars) +
  geom_point(aes(x = HwyMPG, y = predictedHwyMPG)) +
  geom_abline(slope = 1) +
  labs(title = "Actual vs. Predicted MPG", x = "Actual Highway MPG", 
       y = "Predicted Highway MPG")



# Bigger multiple linear regression model

Cars2015 |>
  lm(HwyMPG ~ Length + Width + Height + Weight + Acc030 + Acc060, data = _) |>
  summary()


# Refitting model with least significant variable removed

Cars2015 |>
  lm(HwyMPG ~ Length + Width + Height + Weight + Acc060, data = _) |>
  summary()
