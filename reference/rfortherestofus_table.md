# R for the Rest of Us GT table

A GT table theme with R for the Rest of Us branding.

## Usage

``` r
rfortherestofus_table(data, base_font = "Inter", base_font_size = 12, ...)
```

## Arguments

- data:

  A dataframe or tibble.

- base_font:

  Default font to use (e.g., "Inter").

- base_font_size:

  Base font size, default to 12 (px).

- ...:

  Additional arguments passed to `gt::tab_options()`

## Value

A gt table

## Examples

``` r
if (FALSE) { # \dontrun{
data.frame(
  Item = c("R in 3 months with Group Discount"),
  Participants = c(100),
  CostPerParticipant = c(100),
  Total = c(100)
) |>
  rename(`Cost Per Participant` = "CostPerParticipant") |>
  rfor_table() |>
  fmt_currency(columns = c("Cost Per Participant", "Total"))
} # }
```
