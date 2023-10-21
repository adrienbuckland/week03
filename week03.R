#pacman::p_load(tidyverse)

disasters <- read.csv("EMDAT.csv")

#filtering to relevant variables
disastersfiltered <- disasters %>%
  select(Entity, Year, deaths_all_disasters, homeless_all_disasters, injured_all_disasters) %>%
  rename(total_deaths = deaths_all_disasters, total_homeless = homeless_all_disasters, total_injured = injured_all_disasters)

#finding per-year averages of relevant variables
disastersavg <- disastersfiltered %>%
  group_by(Entity) %>%
  summarise(avg_deaths = mean(total_deaths) %>% round(2), avg_homeless = mean(total_homeless) %>% round(2), avg_injured = mean(total_injured, na.rm = TRUE) %>% round(2)) %>%
  select(Entity, avg_deaths, avg_homeless, avg_injured)

#sorting top ten highest average countries to relevant variables. row 1 excluded as it is always world average
disasterstopdeaths <- disastersavg %>%
  select(Entity, avg_deaths) %>%
  arrange(desc(avg_deaths)) %>%
  slice(2:11)
disasterstophomeless <- disastersavg %>%
  select(Entity, avg_homeless) %>%
  arrange(desc(avg_homeless)) %>%
  slice(2:11)
disasterstopinjured <- disastersavg %>%
  select(Entity, avg_injured) %>%
  arrange(desc(avg_injured)) %>%
  slice(2:11)

#detect if a country has over 500 total deaths in a year
df <- disasters
df$over_500_deaths <- c(FALSE)
df$over_500_deaths[df$deaths_all_disasters > 500] <- TRUE
view(df)

#pivoted longer with separate entries for each condition
longdisastersfiltered <- disastersfiltered %>%
  pivot_longer(
    cols = c("total_deaths", "total_homeless", "total_injured"),
    names_to = "effect",
    values_to = "number_affected"
  )