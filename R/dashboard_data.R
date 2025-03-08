#' Get Blog Posts
#'
#' @param statamic_token defaults to `Sys.getenv("STATAMIC_TOKEN")`
#'
#' @returns data frame with all blog posts
#' @export
get_blog_posts <- function(statamic_token = Sys.getenv("STATAMIC_TOKEN")) {
  statamicr::get_collection(
    url = "https://rfortherestofus.com",
    collection = "blog",
    token = statamic_token
  ) |>
    tidyr::unnest(blog_categories) |>
    tidyr::unnest_wider(blog_categories, names_sep = "_") |>
    dplyr::select(title, blog_categories_title, url, date) |>
    dplyr::rename("category" = "blog_categories_title") |>
    dplyr::mutate(url = stringr::str_glue("{url}/")) |>
    dplyr::mutate(date = lubridate::ymd_hms(date)) |>
    dplyr::mutate(date = lubridate::as_date(date)) |>
    dplyr::arrange(dplyr::desc(date))
}

#' Get all orders
#'
#' @param statamic_token defaults to `Sys.getenv("STATAMIC_TOKEN")`
#'
#' @returns data frame with all orders
#' @export
get_orders <- function(statamic_token = Sys.getenv("STATAMIC_TOKEN")) {
  statamicr::get_orders(
    url = "https://rfortherestofus.com",
    token = statamic_token
  ) |>
    tidyr::unnest_wider("data") |>
    tidyr::unnest_wider("where_did_you_hear_about_r_for_the_rest_of_us") |>
    dplyr::mutate(
      where_hear = dplyr::case_when(
        label == "Other" ~ where_did_you_hear_about_r_for_the_rest_of_us_other,
        .default = label
      )
    ) |>
    dplyr::mutate(where_hear = stringr::str_to_title(where_hear)) |>
    dplyr::select(
      order_number,
      customer_id,
      items,
      coupon_total,
      status_log,
      where_hear
    ) |>
    tidyr::unnest_wider(customer_id, names_sep = "_") |>
    dplyr::rename("customer_email" = "customer_id_email") |>
    dplyr::rename("customer_id" = "customer_id_id") |>
    tidyr::unnest(status_log) |>
    tidyr::unnest_wider(status_log) |>
    dplyr::mutate(order_date = lubridate::as_datetime(timestamp)) |>
    dplyr::mutate(order_date = lubridate::as_date(order_date)) |>
    dplyr::filter(status == "paid") |>
    tidyr::unnest(items) |>
    tidyr::unnest_wider(items) |>
    tidyr::unnest_wider(product, names_sep = "_") |>
    dplyr::add_count(order_number, name = "items_in_order") |>
    dplyr::mutate(coupon_total = readr::parse_number(coupon_total)) |>
    dplyr::mutate(total = readr::parse_number(total)) |>
    dplyr::arrange(dplyr::desc(order_date)) |>
    dplyr::select(
      order_number,
      order_date,
      items_in_order,
      customer_id,
      customer_email,
      product_title,
      total,
      coupon_total,
      where_hear
    )
}
