#' RRU ggplot2 theme
#'
#' Remember to install and import the required fonts ("Inter") before using this!
#'
#' @param show_grid_lines Boolean to indicate whether to have grid_lines (TRUE by default)
#' @param show_legend Whether or not to show the legend (TRUE by default)
#' @param base_family Base font family (Inter by default). If you want to use a custom font, you need to register it first.
#' @param title_family Title font family (Inter by default). If you want to use a custom font, you need to register it first.
#' @param axis_family Axis text and title font family (Inter by default). If you want to use a custom font, you need to register it first.
#' @param void logical, use `TRUE` if you want the plot to use theme_void() as its starting point (i.e. when you don't want any axes)
#'
#' @return Ggplot2 theme
#' @export
theme_rru <- function(
  show_grid_lines = TRUE,
  show_legend = TRUE,
  base_family = "Inter",
  title_family = "Inter",
  axis_family = "Inter",
  void = FALSE
) {
  rru_theme <- ggplot2::theme_minimal(
    base_family = base_family,
    base_size = 13
  ) +
    ggplot2::theme(
      panel.grid.major = ggplot2::element_line(
        color = alpha(rru_colors("Pale Blue")),
        0.5
      ),
      panel.grid.minor = ggplot2::element_line(
        color = alpha(rru_colors("Pale Blue")),
        0.5
      ),
      plot.title.position = "plot",
      axis.ticks = ggplot2::element_blank(),
      axis.text = ggplot2::element_text(
        color = rru_colors("Light Text"),
        family = axis_family
      ),
      axis.title.x = ggplot2::element_text(
        margin = ggplot2::margin(15, 0, 0, 0),
        family = axis_family
      ),
      axis.title.y = ggplot2::element_blank()
    )

  if (void == TRUE) {
    show_legend <- FALSE
    rru_theme <- rru_theme +
      ggplot2::theme_void(base_family = base_family) +
      ggplot2::theme(
        plot.margin = ggplot2::margin(5.5, 5.5, 5.5, 5.5, unit = "points")
      )
  }

  # Adding formatting for text regardless of void or not
  rru_theme <- rru_theme +
    ggplot2::theme(
      text = ggplot2::element_text(color = rru_colors("Light Text"), size = 14),
      panel.grid.minor = ggplot2::element_blank(),
      plot.title = ggtext::element_markdown(
        family = title_family,
        face = "bold",
        color = rru_colors("Dark Text"),
        size = 20,
        margin = ggplot2::margin(0, 0, 8, 0)
      ),
      strip.text = ggplot2::element_text(
        family = base_family,
        color = rru_colors("Light Text")
      ),
      legend.title = ggtext::element_markdown(
        color = rru_colors("Dark Text"),
        family = base_family,
        size = 14
      ),
      plot.subtitle = ggtext::element_markdown(
        family = base_family,
        size = 16,
        lineheight = 1.3
      )
    )

  if (show_grid_lines == FALSE) {
    rru_theme <- rru_theme +
      ggplot2::theme(panel.grid.major = ggplot2::element_blank())
  }

  if (show_legend == FALSE) {
    rru_theme <- rru_theme +
      ggplot2::theme(legend.position = "none")
  }

  rru_theme
}
