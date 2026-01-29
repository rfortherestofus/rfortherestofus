#' @title Create or overwrite an air.toml configuration file
#'
#' @description Generates an `air.toml` or `.air.toml` configuration file with formatting
#' options for the `air` code formatter. By default, writes a new file unless
#' `overwrite = TRUE` is specified.
#'
#' Install R for your editor [here](https://posit-dev.github.io/air/editors.html).
#'
#' @param line_width Integer. Maximum line width. Default is `80`.
#' @param indent_width Integer or character. Indentation width. If character, it
#'   will be wrapped in quotes. Default is `2`.
#' @param indent_style Character. Indentation style, either `"space"` or `"tab"`.
#'   Default is `"space"`.
#' @param line_ending Character. Line ending style. Can be `"auto"`, `"lf"`,
#'   `"crlf"`, or `"cr"`. Default is `"auto"`.
#' @param persistent_line_breaks Character (`"true"` or `"false"`). Whether to
#'   preserve existing line breaks. Default is `"true"`.
#' @param exclude Character. TOML array of paths/patterns to exclude. Default is `"[]"`.
#' @param default_exclude Character (`"true"` or `"false"`). Whether to use
#'   default exclusion rules. Default is `"true"`.
#' @param skip Character. TOML array of paths/patterns to skip. Default is `"[]"`.
#' @param file_name Character. Name of the configuration file. Must be
#'   `"air.toml"` or `".air.toml"`. Default is `"air.toml"`.
#' @param overwrite Logical. Whether to overwrite an existing file. Default is `FALSE`.
#'
#' @examples
#' \dontrun{
#' use_air_toml()
#'
#' use_air_toml(overwrite=TRUE)
#' }
#'
#' @export
use_air_toml <- function(
  line_width = 80,
  indent_width = 2,
  indent_style = "space",
  line_ending = "auto",
  persistent_line_breaks = "true",
  exclude = "[]",
  default_exclude = "true",
  skip = "[]",
  file_name = "air.toml",
  overwrite = FALSE
) {
  if (is.character(indent_width)) {
    indent_width <- paste0('"', indent_width, '"')
  }

  if (!(file_name %in% c("air.toml", ".air.toml"))) {
    stop(paste0(
      "Invalid file name: ",
      file_name,
      ". It must be either air.toml or .air.toml"
    ))
  }

  air_toml <- c(
    "[format]",
    paste0('line-width = ', line_width),
    paste0('indent-width = ', indent_width),
    paste0('indent-style = "', indent_style, '"'),
    paste0('line-ending = "', line_ending, '"'),
    paste0('persistent-line-breaks = ', persistent_line_breaks),
    paste0('exclude = ', exclude),
    paste0('default-exclude = ', default_exclude),
    paste0('skip = ', skip)
  )

  if (file.exists(file_name) && !overwrite) {
    stop(paste0(
      file_name,
      " already exists. Use overwrite = TRUE to replace it."
    ))
  }

  writeLines(text = air_toml, con = file_name)
}
