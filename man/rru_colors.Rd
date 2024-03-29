% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/colors.R
\name{rru_colors}
\alias{rru_colors}
\title{Function to extract RRU colors as hex codes}
\usage{
rru_colors(...)
}
\arguments{
\item{...}{color or colors you want to return}
}
\value{
A color vector
}
\description{
rru_colors() enables you to pull colors directly from the RRU palette.
Choose one of the following options:
\itemize{
\item primary colors: \code{Blue}, \verb{Dark Text}, \verb{Light Text}
\item additional color: \code{Orange}, \code{Yellow}, \code{Red}
}
}
\details{
\code{rru_colors("Dark Text", "Light Text")} returns the code for both of those
colors. \code{rru_colours()} returns a named vector of all the RRU hex codes
}
