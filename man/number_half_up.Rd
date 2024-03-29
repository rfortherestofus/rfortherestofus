% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/percent_half_up.R
\name{number_half_up}
\alias{number_half_up}
\title{Title}
\usage{
number_half_up(
  x,
  accuracy = NULL,
  scale = 1,
  prefix = "",
  suffix = "",
  big.mark = " ",
  decimal.mark = ".",
  trim = TRUE,
  ...
)
}
\arguments{
\item{x}{A numeric vector to format.}

\item{accuracy}{A number to round to. Use (e.g.) \code{0.01} to show 2 decimal
places of precision. If \code{NULL}, the default, uses a heuristic that should
ensure breaks have the minimum number of digits needed to show the
difference between adjacent values.

Applied to rescaled data.}

\item{scale}{A scaling factor: \code{x} will be multiplied by \code{scale} before
formating. This is useful if the underlying data is very small or very
large.}

\item{prefix}{Symbols to display before and after value.}

\item{suffix}{Symbols to display before and after value.}

\item{big.mark}{Character used between every 3 digits to separate thousands.}

\item{decimal.mark}{The character to be used to indicate the numeric
decimal point.}

\item{trim}{Logical, if \code{FALSE}, values are right-justified to a common
width (see \code{\link[base:format]{base::format()}}).}

\item{...}{Other arguments passed on to \code{\link[base:format]{base::format()}}.}
}
\value{
A number function helper
}
\description{
Title
}
