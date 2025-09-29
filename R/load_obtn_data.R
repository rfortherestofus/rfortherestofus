#' Download a file from a GitHub repository
#'
#' This function downloads a file from a specified GitHub repository and saves it to a local directory.
#'
#' @name download_file
#' @param file_path A character string specifying the path to the file in the GitHub repository.
#' @param dest_path A character string specifying the destination directory where the file will be saved.
#' @param verbose A logical value indicating whether to print messages during the download process. Default is `FALSE`.
#' @return A character string representing the path to the downloaded file, or `NULL` if the download fails.
#' @export
download_file <- function(file_path, dest_path, verbose = FALSE) {
  stop(
    'load_obtn_data() and related functionality has been moved to the {tfff} package'
  )
}

#' Get a list of files matching a pattern from a GitHub repository
#'
#' This function retrieves a list of files from a specified GitHub repository that match a given pattern.
#'
#' @name get_files
#' @param pattern A character string specifying the pattern to match file names.
#' @param dir A character string specifying the directory in the GitHub repository to search. Default is `"data-clean/"`.
#' @return A character vector of file paths that match the pattern, or an error if the directory listing fails.
#' @export
get_files <- function(pattern, dir = "data-clean/") {
  stop(
    'load_obtn_data() and related functionality has been moved to the {tfff} package'
  )
}

#' Load data from a GitHub repository
#'
#' This function downloads files matching a specified pattern from a GitHub repository, loads them into a data frame, and optionally deletes the temporary directory used for downloading.
#'
#' @name load_obtn_data
#' @param pattern A character string specifying the pattern to match file names.
#' @param dest_path A character string specifying the destination directory for downloaded files. Default is `"temp/"`.
#' @param verbose A logical value indicating whether to print messages during the download process. Default is `FALSE`.
#' @param delete_temp_dir A logical value indicating whether to delete the temporary directory after loading the data. Default is `TRUE`.
#' @return A data frame containing the combined data from all matching files.
#' @examples
#' \dontrun{
#' df <- load_obtn_data("data_county_url")
#' df <- load_obtn_data("data_alice")
#' }
#' @export
load_obtn_data <- function(
  pattern,
  dest_path = "temp/",
  verbose = FALSE,
  delete_temp_dir = TRUE
) {
  stop(
    'load_obtn_data() and related functionality has been moved to the {tfff} package'
  )
}
