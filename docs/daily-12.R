library(sf)
library(tidyverse)
library(units)

mapdata = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))


stateboundaries = st_combine(usa_bound) %>%
    st_cast("MULTILINESTRING")

Colo_data = mapdata %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(state_name== "Colorado")

touchCO = st_filter(mapdata, Colo_data,  .predicate = st_touches) %>%
  st_cast("MULTILINESTRING")

Coloborder=
  ggplot() +
  geom_sf(data = mapdata, fill = NA, size = 1) +
  geom_sf(data = touchCO, col = 'red', fill = 'red', alpha = .5) +
  geom_sf(data = Colo_data, col = "blue") +
  theme_linedraw()+
  labs(title = "States that touch Colorado",
       subtitle = "Daily Assignment 12",
       caption = "GEOG 176A Summer B")

ggsave(Coloborder, file = "D:/LifeInUCSB/Study/GEOG176A/week3/assignment10/img/coloborder.png")

