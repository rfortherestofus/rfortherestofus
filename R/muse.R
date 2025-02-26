#' Upload video to muse.ai
#'
#' @param local_video Location of local video
#' @param video_title What to call video on muse
#'
#' @return
#' @export
#'
#' @examples
upload_muse_video <- function(local_video, video_title = NULL) {
  uploaded_video_info <- httr2::request("https://muse.ai/api/files/upload") |>
    httr2::req_headers("Key" = Sys.getenv("MUSE_API_KEY")) |>
    httr2::req_body_multipart(list(file = curl::form_file(local_video))) |>
    httr2::req_perform()

  latest_video_id <- uploaded_video_info |>
    httr2::resp_body_json() |>
    tibble::as_tibble() |>
    dplyr::mutate(
      video_id = stringr::str_glue("https://muse.ai/api/files/set/{fid}")
    ) |>
    dplyr::pull(video_id)

  if (is.null(video_title)) {
    httr2::request(latest_video_id) |>
      httr2::req_headers(
        "Key" = Sys.getenv("MUSE_API_KEY"),
        "Content-Type" = "application/json"
      ) |>
      httr2::req_body_json(list(visibility = "unlisted")) |>
      httr2::req_perform()
  } else {
    httr2::request(latest_video_id) |>
      httr2::req_headers(
        "Key" = Sys.getenv("MUSE_API_KEY"),
        "Content-Type" = "application/json"
      ) |>
      httr2::req_body_json(list(
        title = video_title,
        visibility = "unlisted"
      )) |>
      httr2::req_perform()
  }
}


#' Download Latest Zoom Recording
#'
#' @return Returns location of video
#' @export
#'
#' @examples
download_latest_zoom_video <- function() {
  video_details <- googledrive::drive_ls(
    "https://drive.google.com/drive/u/1/folders/17dal_vagUUwxDhl-f3gK4PZCHdViXLcN"
  ) |>
    dplyr::slice(1)

  video_size <- googledrive::drive_reveal(video_details$id, "size") |>
    dplyr::pull(size) |>
    as.numeric() |>
    utils:::format.object_size("auto")

  message(stringr::str_glue(
    "The most recent file has the name:\n '{video_details$name}' and is  {video_size}."
  ))

  check_download <- readline("Is this the correct file to download? ")

  if (check_download %in% c("n", "N", "no", "No", "NO")) {
    print("Download aborted")
  }

  if (check_download %in% c("y", "Y", "yes", "Yes", "YES")) {
    video_file_id <- video_details |>
      dplyr::pull(id)

    video_name <- googledrive::drive_ls(
      "https://drive.google.com/drive/u/1/folders/17dal_vagUUwxDhl-f3gK4PZCHdViXLcN"
    ) |>
      dplyr::slice(1) |>
      dplyr::pull(name)

    tmp_dir <- tempdir()

    video_location <- stringr::str_glue("{tmp_dir}{video_name}")

    done <- googledrive::as_id(video_file_id) |>
      googledrive::drive_download(path = video_location, overwrite = TRUE)

    video_location
  }
}
