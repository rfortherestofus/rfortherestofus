#' Get race/ethnicity data from ACS
#'
#' @param ...
#'
#' @return data frame with race/ethnicity data
#' @export
#'
#' @examples
get_acs_race_ethnicity <- function(...) {

  tidycensus::get_acs(...,
                      variables = c("White" = "B03002_003",
                                    "Black/African American" = "B03002_004",
                                    "American Indian/Alaska Native" = "B03002_005",
                                    "Asian" = "B03002_006",
                                    "Native Hawaiian/Pacific Islander" = "B03002_007",
                                    "Other race" = "B03002_008",
                                    "Multi-Race" = "B03002_009",
                                    "Hispanic/Latino" = "B03002_012")) %>%
    janitor::clean_names() %>%
    purrr::set_names(c("geoid", "geography", "population_group", "estimate", "moe"))

}


#' View all ACS variables
#'
#' @param year
#'
#' @return
#' @export
#'
#' @examples
view_acs_variables <- function(year = 2019) {
  tidycensus::load_variables(year, "acs5", cache = TRUE) %>%
    tibble::view()
}


#' View all Census variables
#'
#' @param year
#'
#' @return
#' @export
#'
#' @examples
view_census_variables <- function(year = 2010) {
  tidycensus::load_variables(year, "sf1", cache = TRUE) %>%
    tibble::view()
}
