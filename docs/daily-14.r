library(sf)
library(tidyverse)
library(units)
library(USAboundaries)

get_conus = function(data, var){
  conus = filter(data, !get(var) %in% c("Hawaii", "Puerto Rico", "Alaska"))
  return(conus)
}

cities = readr::read_csv("D:/LifeInUCSB/Study/GEOG176A/week3/assignment10/data/uscities.csv") %>%
  st_as_sf(coords = c("lng", "lat"), crs = 4326) %>%
  select(city) %>%
  get_conus(us_states(),"state_name")


polygon = get_conus(us_states(), "name") %>%
  select(name)

point_in_polygon3 = function(points, polygon, group){
  st_join(polygon, points) %>%
    st_drop_geometry() %>%
    count(get(group)) %>%
    setNames(c(group, "n")) %>%
    left_join(polygon, by = group) %>%
    st_as_sf()}

counties = get_conus(us_counties(), "state_name") %>%
  st_transform(st_crs(cities))
city_pip = point_in_polygon3(cities, counties, "geoid")
