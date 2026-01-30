# Function to extract RRU colors as hex codes

rru_colors() enables you to pull colors directly from the RRU palette.
Choose one of the following options:

- primary colors: `Blue`, `Dark Text`, `Light Text`

- additional color: `Orange`, `Yellow`, `Red`

## Usage

``` r
rru_colors(...)
```

## Arguments

- ...:

  color or colors you want to return

## Value

A color vector

## Details

`rru_colors("Dark Text", "Light Text")` returns the code for both of
those colors. `rru_colours()` returns a named vector of all the RRU hex
codes
