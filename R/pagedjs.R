#' Convert HTML to PDF with paged.js
#'
#' This function takes an html document and convert it to pdf using the paged.js CLI.
#'
#' If the input file (`file_path`) is a Quarto document, it first generate the HTML and
#' then convert it to PDF. There also is an option to remove ot not the intermediate file.
#'
#' @name html_to_pdf
#' @param file_path A character string specifying the path to the file in the GitHub repository.
#' @param dest_path A character string specifying the destination directory where the file will be saved. Default to `file_path` (using `.pdf` instead of `.html`)
#' @param delete_html_if_quarto Whether to delete the intermediate html file is `file_path` is a Quarto document. Default to `TRUE`.
#' @export
#' @examples
#' \dontrun{
#' html_to_pdf("file.html")
#' html_to_pdf("file.html", "output.pdf")
#' html_to_pdf("file.qmd")
#' html_to_pdf("file.qmd", "output.pdf")
#' html_to_pdf("file.qmd", "output.pdf", delete_html_if_quarto = FALSE)
#' }
html_to_pdf <- function(
    file_path,
    dest_path = NULL,
    delete_html_if_quarto = TRUE
) {
    if (!nzchar(file_path) || !file.exists(file_path)) {
        stop("The file_path must be a valid, existing file.")
    }

    file_ext <- tools::file_ext(file_path)

    if (tolower(file_ext) == "qmd") {
        if (!requireNamespace("quarto", quietly = TRUE)) {
            stop("The 'quarto' package is required to render .qmd files.")
        }
        quarto::quarto_render(file_path)
        file_path <- sub("\\.qmd$", ".html", file_path)
        if (!file.exists(file_path)) {
            stop("Rendered HTML file not found after rendering the .qmd file.")
        }
    } else if (tolower(file_ext) != "html") {
        stop("file_path must be a .html or .qmd file.")
    }

    if (is.null(dest_path)) {
        dest_path <- sub("\\.html$", ".pdf", file_path)
    }

    res <- system2(
        "pagedjs-cli",
        args = c(file_path, "-o", dest_path),
        stdout = TRUE,
        stderr = TRUE
    )

    if (!file.exists(dest_path)) {
        stop(
            "PDF generation failed. Check if pagedjs-cli is installed and accessible from PATH."
        )
    }

    if (
        tolower(file_ext) == "qmd" &&
            file.exists(file_path) &&
            delete_html_if_quarto
    ) {
        file.remove(file_path)
    }

    invisible(dest_path)
}
