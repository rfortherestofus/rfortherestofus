#' Function to extract RRU colors as hex codes
#'
#' rru_colors() enables you to pull colors directly from the RRU palette.
#' Choose one of the following options:
#' - primary colors: `Blue`, `Dark Text`, `Light Text`
#'
#' `rru_colors("Dark Text", "Light Text")` returns the code for both of those
#' colors. `rru_colours()` returns a named vector of all the RRU hex codes
#'
#' @param ... color or colors you want to return
#'
#' @return A color vector
#'
#' @export
#'
rru_colors <- function(...) {
  # @ Cara - please change colors here
  ivac_colors_vector <- c(
    `Blue` = "#6caadd",
    `Dark Text` = "#314D63",
    `Light Text` = "#8394A1",
    `Pale Blue` = "#E1EEF8"
  )

  cols <- c(...)

  if (is.null(cols)) {
    return(ivac_colors_vector)
  } else {
    cols <- stringr::str_to_title(cols)

    ivac_colors_vector[cols] %>%
      as.vector()
  }

}
