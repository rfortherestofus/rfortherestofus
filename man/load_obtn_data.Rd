% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/load_obtn_data.R
\name{load_obtn_data}
\alias{load_obtn_data}
\title{Load data from a GitHub repository}
\usage{
load_obtn_data(
  pattern,
  dest_path = "temp/",
  verbose = FALSE,
  delete_temp_dir = TRUE
)
}
\arguments{
\item{pattern}{A character string specifying the pattern to match file names.}

\item{dest_path}{A character string specifying the destination directory for downloaded files. Default is \code{"temp/"}.}

\item{verbose}{A logical value indicating whether to print messages during the download process. Default is \code{FALSE}.}

\item{delete_temp_dir}{A logical value indicating whether to delete the temporary directory after loading the data. Default is \code{TRUE}.}
}
\value{
A data frame containing the combined data from all matching files.
}
\description{
This function downloads files matching a specified pattern from a GitHub repository, loads them into a data frame, and optionally deletes the temporary directory used for downloading.
}
\examples{
\dontrun{
df <- load_obtn_data("data_county_url")
df <- load_obtn_data("data_alice")
}
}
