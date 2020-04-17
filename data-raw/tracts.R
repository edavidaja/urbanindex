library(tidycensus)
library(sf)
library(dplyr)
library(stringr)
library(areal)
library(here)
options(tigris_use_cache = TRUE)

five_miles_in_meters <- 8046.72

  tract_population <- get_acs(
    geography = "tract",
    variables = "B01003_001",
    state = c(state.abb, "DC", "PR"),
    geometry = TRUE
  )

tract_population <-
  st_transform(
    tract_population,
    crs = "+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
    ) %>%
  mutate(
    five_mile_buffer = st_buffer(geometry, five_miles_in_meters),
    state = str_extract(NAME, ", [A-Za-z ]+$"),
    state = str_remove(state, "^, ")
  )

five_mi_buffers <- select(tract_population, GEOID, five_mile_buffer) %>%
  st_drop_geometry() %>%
  st_as_sf()

pop_within_5_mi <- aw_interpolate(
  five_mi_buffers, tid = GEOID, source = tract_population, sid = GEOID,
  weight = "sum", output = "tibble", extensive = "estimate"
  ) %>%
  rename(pop_within_5_mi = estimate)

usethis::use_data(pop_within_5_mi, overwrite = TRUE)
