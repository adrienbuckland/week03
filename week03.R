#pacman::p_load(tidyverse)
disasters <- read.csv("EMDAT.csv")
view(disasters)
disastersfiltered <- disasters %>%
  select(Entity, Year, deaths_all_disasters, homeless_all_disasters, injured_all_disasters) %>%
  rename(total_deaths = deaths_all_disasters, total_homeless = homeless_all_disasters, total_injured = injured_all_disasters)
view(disastersfiltered)
