

# function from https://github.com/r-lib/scales/blob/main/R/label-number.r#L220
#' Title
#'
#' @inheritParams scales::number
#'
#' @return A number function helper
#' @export
#'
#' @importFrom rlang %||%
number_half_up <-
  function(x,
           accuracy = NULL,
           scale = 1,
           prefix = "",
           suffix = "",
           big.mark = " ",
           decimal.mark = ".",
           trim = TRUE,
           ...)
  {
    if (length(x) == 0)
      return(character())
    accuracy <- accuracy %||% precision(x * scale)
    # change here
    x <- round_any(x, accuracy / scale, f = janitor::round_half_up)
    nsmall <- -floor(log10(accuracy))
    nsmall <- min(max(nsmall, 0), 20)
    ret <-
      format(
        scale * x,
        big.mark = big.mark,
        decimal.mark = decimal.mark,
        trim = trim,
        nsmall = nsmall,
        scientific = FALSE,
        ...
      )
    ret <- paste0(prefix, ret, suffix)
    ret[is.infinite(x)] <- as.character(x[is.infinite(x)])
    ret[is.na(x)] <- NA
    names(ret) <- names(x)
    ret
  }

# function from https://github.com/r-lib/scales/blob/main/R/round-any.r
round_any <- function(x, accuracy, f) {
  f(x / accuracy) * accuracy
}

#' Percent Half_up function
#'
#' @inheritParams scales::percent
#'
#' @return A percent function which doesn't display 12% like scales::percent(125/1000, accuracy = 1) but 13%
#' @export
#'
percent_half_up <-
  function (x,
            accuracy = NULL,
            scale = 100,
            prefix = "",
            suffix = "%",
            big.mark = " ",
            decimal.mark = ".",
            trim = TRUE,
            ...)
  {
    number_half_up(
      x = x,
      accuracy = accuracy,
      scale = scale,
      prefix = prefix,
      suffix = suffix,
      big.mark = big.mark,
      decimal.mark = decimal.mark,
      trim = trim,
      ...
    )
  }
