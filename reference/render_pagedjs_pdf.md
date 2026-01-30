# Convert HTML to PDF with paged.js

This function takes an html document and convert it to pdf using the
paged.js CLI.

## Usage

``` r
render_pagedjs_pdf(file_path, dest_path = NULL, delete_html_if_quarto = TRUE)
```

## Arguments

- file_path:

  A character string specifying the path to the HTML file or Quarto
  document

- dest_path:

  A character string specifying the destination directory where the file
  will be saved. Default to `file_path` (using `.pdf` instead of
  `.html`)

- delete_html_if_quarto:

  Whether to delete the intermediate html file is `file_path` is a
  Quarto document. Default to `TRUE`.

## Details

If the input file (`file_path`) is a Quarto document, it first generate
the HTML and then convert it to PDF. There also is an option to remove
ot not the intermediate file.

## Examples

``` r
if (FALSE) { # \dontrun{
render_pagedjs_pdf("file.html")
render_pagedjs_pdf("file.html", "output.pdf")
render_pagedjs_pdf("file.qmd")
render_pagedjs_pdf("file.qmd", "output.pdf")
render_pagedjs_pdf("file.qmd", "output.pdf", delete_html_if_quarto = FALSE)
} # }
```
