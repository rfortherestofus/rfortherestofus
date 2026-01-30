# RRU ggplot2 theme

Remember to install and import the required fonts ("Inter") before using
this!

## Usage

``` r
theme_rru(
  show_grid_lines = TRUE,
  show_legend = TRUE,
  base_family = "Inter",
  title_family = "Inter",
  axis_family = "Inter",
  void = FALSE
)
```

## Arguments

- show_grid_lines:

  Boolean to indicate whether to have grid_lines (TRUE by default)

- show_legend:

  Whether or not to show the legend (TRUE by default)

- base_family:

  Base font family (Inter by default). If you want to use a custom font,
  you need to register it first.

- title_family:

  Title font family (Inter by default). If you want to use a custom
  font, you need to register it first.

- axis_family:

  Axis text and title font family (Inter by default). If you want to use
  a custom font, you need to register it first.

- void:

  logical, use `TRUE` if you want the plot to use theme_void() as its
  starting point (i.e. when you don't want any axes)

## Value

Ggplot2 theme
