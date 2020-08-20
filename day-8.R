library(sf)
library(tidyverse)

mapdata = USAboundaries::us_states() %>%
  filter(!state_name %in% c("Puerto Rico", "Alaska", "Hawaii"))
#plot 1 with boundaries
usa_bound = mapdata$geometry
(stateboundaries = st_combine(usa_bound) %>%
    st_cast("MULTILINESTRING"))
jpeg('usplot.jpg')
plot(stateboundaries)
dev.off()


#plot 2 without boundaries
usa_b2 = data$geometry
(noboundaries = st_union(usa_b2)  %>%
    st_cast("MULTILINESTRING"))
jpeg('usplot2.jpg')
plot(noboundaries)
dev.off()

