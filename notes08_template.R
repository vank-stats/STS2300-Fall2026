# Notes 08 Code Template

# Load required packages

library(ggplot2) # basic graphs
library(dplyr) # summarize(), mutate(), select(), slice_sample()
library(infer) # sampling functions
library(patchwork) # combining graphs


# Read in data for population
# set.seed(82720)

elon <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/elon_enrollment_f25.csv") |>
  mutate(NC = ifelse(Location == "North Carolina", "NC", "Other"))


# Graph population

pop_dist <- ggplot(elon) +
  geom_bar(aes(x = NC, fill = NC), 
           show.legend = FALSE) +
  theme_classic() +
  scale_fill_manual(values = c("#73000a", "#b59a57")) 

pop_dist + labs(title = "Elon Students (Our Population)",
                subtitle = "Fall 2025",
                x = "Where students come from")


# Taking a sample of 30 students

mysamp <- slice_sample(elon, n = 30)
table(mysamp$NC)

sample_dist <- ggplot(mysamp) +
  geom_bar(aes(x = NC, fill = NC), 
           show.legend = FALSE) +
  theme_classic() +
  scale_fill_manual(values = c("#73000a", "#b59a57")) 

sample_dist + labs(title = "Sample of 30 Elon students",
                   subtitle = "Fall 2025")


# Creating a sampling distribution (1,000 samples of 30 students)

true_p <- mean(elon$NC == "NC")

my_samples_n30 <- elon |>
  rep_sample_n(size = 30,
               reps = 1000)

my_phats_n30 <- my_samples_n30 |>
  summarize(prop_nc = mean(NC == "NC"))

sampling_dist <- ggplot(my_phats_n30) +
  geom_histogram(aes(x = prop_nc),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  scale_x_continuous(breaks = seq(0, 1, .1), limits = c(0.05, 0.65))

sampling_dist + 
  labs(title = "Sampling Distribution for Proportion from NC",
       subtitle = "Estimated from 1,000 random samples of 30 students",
       caption = "Blue line is the pop. proportion from NC",
       x = "Sample proportions from NC") +
  geom_vline(xintercept = true_p,
             color = "blue", linewidth = 2)


# Standard error for samples of 30 students

sd(my_phats_n30$prop_nc)



# Sampling distributions of 100 students or 300 students

my_phats_n100 <- elon |>
  rep_sample_n(size = 100,
               reps = 1000) |>
  summarize(prop_nc = mean(NC == "NC"))

my_phats_n300 <- elon |>
  rep_sample_n(size = 300,
               reps = 1000) |>
  summarize(prop_nc = mean(NC == "NC"))

sampling_dist100 <- ggplot(my_phats_n100) +
  geom_histogram(aes(x = prop_nc),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  geom_vline(xintercept = true_p,
             color = "blue", linewidth = 2) +
  scale_x_continuous(breaks = seq(0, 1, .1), limits = c(0.05, 0.65))

sampling_dist300 <- ggplot(my_phats_n300) +
  geom_histogram(aes(x = prop_nc),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  geom_vline(xintercept = true_p,
             color = "blue", linewidth = 2) +
  scale_x_continuous(breaks = seq(0, 1, .1), limits = c(0.05, 0.65))


# Comparing three sampling distributions by sample size

(sampling_dist + 
    labs(subtitle = "Sampling Distribution (n = 30)") +
    geom_vline(xintercept = true_p, color = "blue", linewidth = 2)) / 
  (sampling_dist100 +
     labs(subtitle = "Sampling Distribution (n = 100)")) / 
  (sampling_dist300 +
     labs(subtitle = "Sampling Distribution (n = 300)",
          caption = "Blue line is population proportion"))


# Sampling errors for each sample size

se30 <- sd(my_phats_n30$prop_nc)
se100 <- sd(my_phats_n100$prop_nc)
se300 <- sd(my_phats_n300$prop_nc)

data.frame(n = c(30, 100, 300), 
           SE = round(c(se30, se100, se300), 3))


# Creating a bootstrap resampling distribution from original sample

phat <- mean(mysamp$NC == "NC")

myboot <- mysamp |>
  rep_sample_n(size = 30,
               reps = 1000,
               replace = TRUE) |>
  summarize(prop_nc = mean(NC == "NC"))

boot_dist <- ggplot(myboot) +
  geom_histogram(aes(x = prop_nc),
                 binwidth = 1/30,
                 color = "white") +
  theme_classic() +
  geom_vline(xintercept = true_p,
             color = "blue", linewidth = 2) +
  geom_vline(xintercept = phat,
             color = "orange", linewidth = 2)

boot_dist +
  labs(title = "Bootstrap Distribution for Proportion of Students from NC",
       subtitle = "Estimated from 1,000 bootstrap re-samples (n = 30)",
       caption = "Blue line is the pop. proportion, Orange line is samp. prop.")


# Graphing our four types of distributions

((pop_dist +
    labs(subtitle = "Distribution of Population")) + 
    (sampling_dist +
       labs(subtitle = "Sampling Distribution") +
       geom_vline(xintercept = true_p, color = "blue", linewidth = 2))) / 
  ((sample_dist +
      labs(subtitle = "Distribution of Sample")) + 
     (boot_dist +
        labs(subtitle = "Bootstrap Resampling Distribution")))
