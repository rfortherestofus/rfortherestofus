#' @title R for the Rest of Us GT table
#'
#' @description
#' A GT table theme with R for the Rest of Us branding.
#'
#' @param data A dataframe or tibble.
#' @param base_font Default font to use (e.g., "Inter").
#' @param base_font_size Base font size, default to 12 (px).
#' @param ... Additional arguments passed to [`gt::tab_options()`]
#'
#' @returns A gt table
#'
#' @examples
#' \dontrun{
#' data.frame(
#'   Item = c("R in 3 months with Group Discount"),
#'   Participants = c(100),
#'   CostPerParticipant = c(100),
#'   Total = c(100)
#' ) |>
#'   rename(`Cost Per Participant` = "CostPerParticipant") |>
#'   rfor_table() |>
#'   fmt_currency(columns = c("Cost Per Participant", "Total"))
#' }
#'
#' @export
rfortherestofus_table <- function(
  data,
  base_font = "Inter",
  base_font_size = 12,
  ...
) {
  data |>
    gt() |>
    tab_options(
      table.background.color = "white",
      table.font.names = base_font,
      table.font.size = px(base_font_size),
      table.font.color = "#404E6B",
      data_row.padding = px(6),
      table.border.top.style = "hidden",
      table.border.bottom.style = "hidden",
      column_labels.border.top.style = "hidden",
      column_labels.border.bottom.style = "hidden",
      row_group.border.top.style = "hidden",
      row_group.border.bottom.style = "hidden",
      ...
    ) |>
    tab_style(
      style = list(
        cell_fill(color = "#404E6B"),
        cell_text(weight = "bold", color = "white")
      ),
      locations = cells_column_labels()
    ) |>
    tab_style(
      style = list(
        cell_fill(color = "white"),
        cell_text(color = "#404E6B")
      ),
      locations = cells_body()
    ) |>
    tab_style(
      style = list(
        cell_text(color = "#404E6B")
      ),
      locations = cells_stub()
    )
}
