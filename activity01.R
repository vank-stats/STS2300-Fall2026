# Activity 1 Sample Code


# Code to read in the data

ai_productivity <- read.csv("https://raw.githubusercontent.com/vank-stats/STS2300-Fall2026/refs/heads/main/Data/AI_Productivity.csv")


# Code Chunk A: Overall mean and median productivity

mean(ai_productivity$Ratio)
median(ai_productivity$Ratio)


# Code Chunk B: Mean and median productivity by AI use

aggregate(Ratio ~ Type, data = ai_productivity, FUN = "mean")
aggregate(Ratio ~ Type, data = ai_productivity, FUN = "median")


# Code Chunk C: Boxplot comparing productivity by AI use

boxplot(Ratio ~ Type, data = ai_productivity)
abline(h = 1)


# Code Chunk D: 

table(ai_productivity$Coin)


# Code Chunk E: 

# set.seed(82626)
ai_productivity$new_coin <- sample(c("AI", "No AI"), size = 31, replace = TRUE)
aggregate(Ratio ~ Type, data = ai_productivity, FUN = "median")
aggregate(Ratio ~ new_coin, data = ai_productivity, FUN = "median")


# Code Chunk F: 

new_sample <- function(use = "mean") {
  new_coin <- sample(c("AI", "No AI"), size = 31, replace = TRUE)
  
  if(use == "mean") {
    ai_ratio <- mean(ai_productivity[new_coin == "AI",]$Ratio)
    noai_ratio <- mean(ai_productivity[new_coin == "No AI",]$Ratio)
  } else if(use == "median") {
    ai_ratio <- median(ai_productivity[new_coin == "AI",]$Ratio)
    noai_ratio <- media(ai_productivity[new_coin == "No AI",]$Ratio)
  } else {
    print("Choose mean or median for use argument")
  }

  ai_ratio - noai_ratio
}

new_sample()


# Code Chunk G: 

sim_values <- replicate(1000, new_sample())
hist(sim_values)
abline(v = 0.4272)


# Code Chunk H:

ai_productivity$Change <- ifelse(ai_productivity$Ratio >= 1, 
                                 ai_productivity$Ratio - 1, 
                                 ((1 / ai_productivity$Ratio) - 1) * -1)



# Original Source: https://mikelovesrobots.substack.com/p/wheres-the-shovelware-why-ai-coding