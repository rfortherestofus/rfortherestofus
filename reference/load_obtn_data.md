# Load data from a GitHub repository

This function downloads files matching a specified pattern from a GitHub
repository, loads them into a data frame, and optionally deletes the
temporary directory used for downloading.

## Usage

``` r
load_obtn_data(
  pattern,
  dest_path = "temp/",
  verbose = FALSE,
  delete_temp_dir = TRUE
)
```

## Arguments

- pattern:

  A character string specifying the pattern to match file names.

- dest_path:

  A character string specifying the destination directory for downloaded
  files. Default is `"temp/"`.

- verbose:

  A logical value indicating whether to print messages during the
  download process. Default is `FALSE`.

- delete_temp_dir:

  A logical value indicating whether to delete the temporary directory
  after loading the data. Default is `TRUE`.

## Value

A data frame containing the combined data from all matching files.

## Examples

``` r
if (FALSE) { # \dontrun{
df <- load_obtn_data("data_county_url")
df <- load_obtn_data("data_alice")
} # }
```
