# Create or overwrite an air.toml configuration file

Generates an `air.toml` or `.air.toml` configuration file with
formatting options for the `air` code formatter. By default, writes a
new file unless `overwrite = TRUE` is specified.

Install R for your editor
[here](https://posit-dev.github.io/air/editors.html).

## Usage

``` r
use_air_toml(
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
)
```

## Arguments

- line_width:

  Integer. Maximum line width. Default is `80`.

- indent_width:

  Integer or character. Indentation width. If character, it will be
  wrapped in quotes. Default is `2`.

- indent_style:

  Character. Indentation style, either `"space"` or `"tab"`. Default is
  `"space"`.

- line_ending:

  Character. Line ending style. Can be `"auto"`, `"lf"`, `"crlf"`, or
  `"cr"`. Default is `"auto"`.

- persistent_line_breaks:

  Character (`"true"` or `"false"`). Whether to preserve existing line
  breaks. Default is `"true"`.

- exclude:

  Character. TOML array of paths/patterns to exclude. Default is `"[]"`.

- default_exclude:

  Character (`"true"` or `"false"`). Whether to use default exclusion
  rules. Default is `"true"`.

- skip:

  Character. TOML array of paths/patterns to skip. Default is `"[]"`.

- file_name:

  Character. Name of the configuration file. Must be `"air.toml"` or
  `".air.toml"`. Default is `"air.toml"`.

- overwrite:

  Logical. Whether to overwrite an existing file. Default is `FALSE`.

## Examples

``` r
if (FALSE) { # \dontrun{
use_air_toml()

use_air_toml(overwrite=TRUE)
} # }
```
