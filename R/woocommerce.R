# consumer_key <- Sys.getenv("WOOCOMMERCE_KEY")
# consumer_secret <- Sys.getenv("WOOCOMMERCE_SECRET")
#
# req <- httr2::request("https://rfortherestofus.com/wp-json/wc/v3/orders")
#
# request_obj <- req %>%
#   httr2::req_auth_basic(consumer_key, consumer_secret) %>%
#   httr2::req_url_query(
#     per_page = 10
#   ) %>%
#   httr2::req_perform(verbosity = 0) %>%
#   httr2::resp_body_json()
#
# request_tibble <- request_obj %>%
#   jsonlite::toJSON() %>%
#   jsonlite::fromJSON() %>%
#   as_tibble()
#
# cols_flat <- c("id", "parent_id", "status", "currency", "version", "prices_include_tax",
#                "date_created", "date_modified", "discount_total", "discount_tax",
#                "shipping_total", "shipping_tax", "cart_tax", "total", "total_tax",
#                "customer_id", "order_key", "payment_method", "payment_method_title",
#                "transaction_id", "customer_ip_address", "customer_user_agent",
#                "created_via", "customer_note")
#
# cols_shipping_to_unnest <- c("shipping_first_name", "shipping_last_name",
#                              "shipping_company", "shipping_address_1", "shipping_address_2",
#                              "shipping_city", "shipping_state", "shipping_postcode", "shipping_country",
#                              "shipping_phone")
#
# order_data <- request_tibble %>%
#   tidyr::unnest(tidyselect::all_of(cols_flat)) %>%
#   tidyr::unnest_wider(date_completed) %>%
#   dplyr::rename(date_completed = ...1) %>%
#   tidyr::unnest(billing,
#          names_sep = "_") %>%
#   tidyr::unnest(tidyselect::starts_with("billing")) %>%
#   tidyr::unnest(shipping,
#          names_sep = "_") %>%
#   tidyr::unnest(tidyselect::all_of(cols_shipping_to_unnest))
#
# order_data$line_items
#
