#pacman::p_load(tidyverse)
disasters <- read.csv("EMDAT.csv")
view(disasters)
disastersfiltered <- disasters %>%
  select(Entity, Year, deaths_all_disasters, homeless_all_disasters, injured_all_disasters) %>%
  rename(total_deaths = deaths_all_disasters, total_homeless = homeless_all_disasters, total_injured = injured_all_disasters)
view(disastersfiltered)
disasterstopten <- disastersfiltered %>%
  group_by(Entity) %>%
  summarise(avg_deaths = mean(total_deaths, na.rm = TRUE) %>% round(2) #, avg_homeless = (mean(total_homeless, na.rm = TRUE) %>% round(2)), avg_injured = (mean(total_injured, na.rm = TRUE) %>% round(2))
view(disasterstopten)
summarise  
