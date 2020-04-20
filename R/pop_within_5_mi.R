#' population within five miles of each census tract
#' 
#' A dataset containing the population within five miles of each census
#' tract, based on the latest American Community Survey Data
#' 
#' @format a data frame with 74001 rows and three columns
#' \describe{
#'   \item{GEOID}{an 11-character identifier for the tract}
#'   \item{pop_within_5_mi}{the population within five miles of the tract}
#'   \item{population}{population of the tract}
#' }
#' @source \url{https://www.census.gov/programs-surveys/acs/news/data-releases.2018.html}
"pop_within_5_mi"
