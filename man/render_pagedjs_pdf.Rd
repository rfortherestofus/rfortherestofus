% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/pagedjs.R
\name{render_pagedjs_pdf}
\alias{render_pagedjs_pdf}
\title{Convert HTML to PDF with paged.js}
\usage{
render_pagedjs_pdf(file_path, dest_path = NULL, delete_html_if_quarto = TRUE)
}
\arguments{
\item{file_path}{A character string specifying the path to the HTML file or Quarto document}

\item{dest_path}{A character string specifying the destination directory where the file will be saved. Default to \code{file_path} (using \code{.pdf} instead of \code{.html})}

\item{delete_html_if_quarto}{Whether to delete the intermediate html file is \code{file_path} is a Quarto document. Default to \code{TRUE}.}
}
\description{
This function takes an html document and convert it to pdf using the paged.js CLI.
}
\details{
If the input file (\code{file_path}) is a Quarto document, it first generate the HTML and
then convert it to PDF. There also is an option to remove ot not the intermediate file.
}
\examples{
\dontrun{
render_pagedjs_pdf("file.html")
render_pagedjs_pdf("file.html", "output.pdf")
render_pagedjs_pdf("file.qmd")
render_pagedjs_pdf("file.qmd", "output.pdf")
render_pagedjs_pdf("file.qmd", "output.pdf", delete_html_if_quarto = FALSE)
}
}
