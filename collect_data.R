collected <- read.csv("collect_data.csv")
collected
str(collected)
head(collected)
library(tidyverse)

# data wrangling
collected_for_plot <- collected %>%
  select(question, lower.bound, upper.bound)


# TODO plot 
collected_for_plot %>% 
  ggplot() +
  geom_boxplot(aes(question)) # False 
