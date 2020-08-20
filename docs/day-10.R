library(sf)
library(tidyverse)
library(units)
usacities = readr::read_csv("D:/LifeInUCSB/Study/GEOG176A/lab-01-materials/lab-01-materials/uscities.csv") %>%
st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  filter(city %in% c("Santa Barbara", "Seattle"))
st_distance(usacities)
st_distance(st_transform(sfcities, 5070))
st_distance(st_transform(usacities,'+proj=eqdc +lat_0=40 +lon_0=-96 +lat_1=20 +lat_2=60 +x_0=0 +y_0=0 +datum=NAD83 +units=m +no_defs'))
st_distance(usacities)  %>%
  units::set_units("km") %>%
  units::drop_units()

