collected <- read.csv("collect_data.csv")
collected
str(collected)
head(collected)
library(tidyverse)

# data wrangling
# add a row 
# new_row <- data.frame('004', 'gov', 'Another question', 14, 42, NA, "research")
# write.table(new_row, file = "collect_data.csv", sep = ",", append = TRUE, quote = FALSE,
#             col.names = FALSE, row.names = FALSE)

# create table for ploting
collected_for_plot <- collected %>%
  select(question, lower.bound, upper.bound)

# TODO answer ranges filled with distributions
dis_answer001 <- rnorm(100); dis_answer001 <- dis_answer001[x > collected$lower.bound & x < collected$upper.bound]
collected[1,] %>% 
  rnorm(1)
  
# TODO plot 
collected_for_plot %>% 
  ggplot() +
  geom_boxplot(aes(question)) # False 
