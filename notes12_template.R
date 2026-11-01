# Notes 12 Code Template

# Load packages for this set of notes

library(infer) # generating null distributions for hypothesis tests
library(ggplot2) # graphing data


# Age discrimination data + graph

layoffs <- data.frame(age = c(25, 33, 35, 38, 48, 55, 55, 55, 56, 64),
                      laidoff = c("No", "No", "No", "No", "No", "Yes", "Yes",
                                  "No", "No", "Yes"))
ggplot(layoffs) +
  geom_boxplot(aes(x = laidoff, y = age, fill = laidoff), show.legend = FALSE,
               alpha = 0.5) +
  geom_jitter(aes(x = laidoff, y = age), size = 2, height = 0, width = 0.1,
              alpha = 0.5) +
  labs(title = "Layoffs at Westvaco Corp. in 1991",
       subtitle = "Were the layoffs discriminatory based on age?",
       x = "Was employee laid off?",
       y = "Age of employee") +
  scale_fill_viridis_d(option = "D") +
  theme_bw()


# Calculating a difference in means

obs_xbardiff <- layoffs |>
  specify(formula = age ~ laidoff) |>
  calculate(stat = "diff in means", order = c("Yes", "No"))
obs_xbardiff


# Calculating a t statistic

obs_t <- layoffs |>
  specify(formula = age ~ laidoff) |>
  calculate(stat = "t", order = c("Yes", "No"))
obs_t


# Making a null distribution and visualizing it with the p-value
# We should set a seed when we run this

# set.seed(__)
layoff_perm <- layoffs |>
  specify(formula = age ~ laidoff) |>
  hypothesize(null = "independence") |>
  generate(reps = 1000, type = "permute") |>
  calculate(stat = "diff in means", order = c("Yes", "No"))

visualize(layoff_perm) +
  shade_pvalue(obs_stat = obs_xbardiff, 
               direction = "right")


# Calculating the p-value

layoff_perm |>
  get_p_value(obs_stat = obs_xbardiff, 
              direction = "right")
