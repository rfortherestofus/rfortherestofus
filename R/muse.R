#' Upload video to muse.ai
#'
#' @param local_video Location of local video
#'
#' @return
#' @export
#'
#' @examples
upload_muse_video <- function(local_video) {

  httr2::request("https://muse.ai/api/files/upload") %>%
    httr2::req_headers("Key" = Sys.getenv("MUSE_API_KEY")) %>%
    httr2::req_body_multipart(list(file = curl::form_file(local_video))) %>%
    httr2::req_perform()

}
