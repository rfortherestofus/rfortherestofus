# Get a list of files matching a pattern from a GitHub repository

This function retrieves a list of files from a specified GitHub
repository that match a given pattern.

## Usage

``` r
get_files(pattern, dir = "data-clean/")
```

## Arguments

- pattern:

  A character string specifying the pattern to match file names.

- dir:

  A character string specifying the directory in the GitHub repository
  to search. Default is `"data-clean/"`.

## Value

A character vector of file paths that match the pattern, or an error if
the directory listing fails.
