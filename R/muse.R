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

  uploaded_video_info <- httr2::request("https://muse.ai/api/files/upload") %>%
    httr2::req_headers("Key" = Sys.getenv("MUSE_API_KEY")) %>%
    httr2::req_body_multipart(list(file = curl::form_file(local_video))) %>%
    httr2::req_perform()

  latest_video_id <- uploaded_video_info %>%
    httr2::resp_body_json() %>%
    tibble::as_tibble() %>%
    dplyr::mutate(video_id = stringr::str_glue("https://muse.ai/api/files/set/{fid}")) %>%
    dplyr::pull(video_id)

  if (is.null(video_title)) {

    httr2::request(latest_video_id) %>%
      httr2::req_headers("Key" = Sys.getenv("MUSE_API_KEY"),
                         "Content-Type" = "application/json") %>%
      httr2::req_body_json(list(visibility = "unlisted")) %>%
      httr2::req_perform()


  } else {

    httr2::request(latest_video_id) %>%
      httr2::req_headers("Key" = Sys.getenv("MUSE_API_KEY"),
                         "Content-Type" = "application/json") %>%
      httr2::req_body_json(list(title = video_title,
                                visibility = "unlisted")) %>%
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

  video_file_id <- googledrive::drive_ls("https://drive.google.com/drive/u/1/folders/17dal_vagUUwxDhl-f3gK4PZCHdViXLcN") %>%
    dplyr::slice(1) %>%
    dplyr::pull(id)

  video_name <- googledrive::drive_ls("https://drive.google.com/drive/u/1/folders/17dal_vagUUwxDhl-f3gK4PZCHdViXLcN") %>%
    dplyr::slice(1) %>%
    dplyr::pull(name)

  video_location <- stringr::str_glue("{tempdir()}{video_name}")

  googledrive::as_id(video_file_id) %>%
    googledrive::drive_download(path = video_location,
                                overwrite = TRUE)

  video_location

}

#' Download video from Cleanshot
#'
#' @param cleanshot_url
#' @param file_name
#'
#' @return Location of where video is downloaded
#' @export
#'
#' @examples
download_cleanshot_video <- function(cleanshot_url) {

  video_location <- stringr::str_glue("{tempdir()}video.mp4")

  download.file(stringr::str_glue("{cleanshot_url}/download"),
                destfile = video_location)

  video_location

}


