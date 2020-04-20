library(tidycensus)
library(sf)
library(dplyr)
library(stringr)
options(tigris_use_cache = TRUE)

five_miles_in_meters <- 8046.72

tract_population <- get_acs(
  geography = "tract",
  variables = "B01003_001",
  state = c(state.abb, "DC", "PR"),
  geometry = TRUE
) %>%
  mutate(
    state = str_extract(NAME, ", [A-Za-z ]+$"),
    state = str_remove(state, "^, ")
  )

states <- select(tract_population, GEOID, state) %>% st_drop_geometry()

tract_population <-
  st_transform(
    tract_population,
    crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
  ) %>%
  mutate(
    tract_centroid = st_centroid(geometry),
    five_mile_buffer = st_buffer(tract_centroid, five_miles_in_meters),
  )

tract_pop <- select(tract_population, population = estimate)

five_mi_buffers <- select(tract_population, GEOID, five_mile_buffer) %>%
  st_drop_geometry() %>%
  st_as_sf()

intersection <- st_join(
  tract_pop, five_mi_buffers
)

pop_within_5_mi <- intersection %>% 
  st_drop_geometry() %>% 
  group_by(GEOID) %>% 
  summarise(pop_within_five = sum(population, na.rm = TRUE)) %>% 
  ungroup() %>% 
  inner_join(
    st_drop_geometry(select(tract_population, GEOID, population = estimate))
    )

inner_join(pop_within_5_mi, states) %>% 
  filter(pop_within_five != 0) %>% 
  mutate(log_pop_within_five = log(pop_within_five)) %>% 
  group_by(state) %>% 
  summarise(avg_log_pop_within_five = mean(log_pop_within_five, na.rm = TRUE)) %>% 
  arrange(desc(avg_log_pop_within_five))

usethis::use_data(pop_within_5_mi, overwrite = TRUE)
