# DB connection -----------------------------------------------------------

#' Connect to Statamic Database
#'
#' @returns
#'
#' @examples
connect_to_statamic_db <- function() {
  con <-
    DBI::dbConnect(
      RMySQL::MySQL(),
      dbname = Sys.getenv("R4_DB_NAME"),
      host = Sys.getenv("R4_DB_HOST"),
      port = Sys.getenv("R4_DB_PORT") |> as.numeric(),
      user = Sys.getenv("R4_DB_USER"),
      password = Sys.getenv("R4_DB_PASSWORD")
    )
}


#' Get all users from DB
#'
#' @returns
#'
#' @examples
get_all_users <- function() {
  dplyr::tbl(connect_to_statamic_db(), "users") |>
    dplyr::collect()
}

#' Get course ids
#'
#' @param course_title Title of course (or string to find multiple courses such as "R in 3 Months")
#'
#' @returns
#'
#' @examples
get_course_ids <- function(course_title) {
  statamicr::get_collection_list(
    "https://rfortherestofus.com",
    "courses",
    token = Sys.getenv("STATAMIC_TOKEN")
  ) |>
    dplyr::filter(stringr::str_detect(title, stringr::str_escape(course_title))) |>
    dplyr::pull(id)
}

#' Get all participants in a course or courses
#'
#' @param course_title Title of course (or string to find multiple courses such as "R in 3 Months")
#'
#' @returns
#' @export
#'
#' @examples
get_course_participants <- function(course_title) {
  get_all_users() |>
    dplyr::filter(stringr::str_detect(email, "rfortherestofus.com", negate = TRUE)) |>
    dplyr::mutate(courses = stringr::str_replace_all(courses, "[^a-zA-Z0-9\\-,]", "")) |>
    dplyr::filter(courses %in% get_course_ids(course_title)) |>
    dplyr::mutate(last_loggedin = lubridate::as_date(last_login)) |>
    tidyr::separate_wider_delim(state, names = c("country2", "state"), delim = "-") |>
    dplyr::select(-country2) |>
    dplyr::mutate(state = stringr::str_to_upper(state)) |>
    dplyr::mutate(city = stringr::str_to_title(city)) |>
    dplyr::mutate(first_name = stringr::str_to_title(first_name)) |>
    dplyr::mutate(last_name = stringr::str_to_title(last_name)) |>
    tidyr::separate_longer_delim(viewed_lessons, delim = ", ") |>
    dplyr::add_count(email, name = "number_of_lessons_viewed") |>
    dplyr::distinct(email, .keep_all = TRUE)
}

# Post Participants to Google Sheet --------------------------------------

#' Title
#'
#' @param course_title Title of course (or string to find multiple courses such as "R in 3 Months")
#' @param google_sheets_url URL of Google Sheet to post to
#' @param sheet_name Name of sheet to post to
#' @param view_sheet Whether to open sheet in browser (TRUE by default)
#'
#' @returns
#' @export
#'
#' @examples
post_participant_info <- function(course_title, google_sheets_url, sheet_name, view_sheet = TRUE) {
  googlesheets4::gs4_auth(email = Sys.getenv("GOOGLE_SHEETS_EMAIL"))

  get_course_participants(course_title) |>
    dplyr::select(
      first_name,
      last_name,
      email,
      city,
      state,
      country,
      company_name,
      last_loggedin,
      number_of_lessons_viewed
    ) |>
    dplyr::arrange(last_name) |>
    googlesheets4::range_write(
      ss = google_sheets_url
    )

  cli::cli_alert_success(stringr::str_glue("Participant info posted at {google_sheets_url}"))

  if (view_sheet == TRUE) {
    browseURL(google_sheets_url)
  }
}


