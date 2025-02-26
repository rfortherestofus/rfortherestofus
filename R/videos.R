# download_raw_videos <- function(folder_url) {
# googledrive::drive_download()
# }
#
# video_files <- googledrive::drive_ls("https://drive.google.com/drive/u/1/folders/1Hyp3-7H4FM5GI8AkrphnoNQK0wo0xqhV") |>
#   dplyr::filter(stringr::str_detect(name, ".screenflow")) |>
#   dplyr::pull(name)
#
# video_files[1]
#
# download_single_video <- function(file_url, download_folder = "/users/davidkeyes/Downloads/", overwrite = TRUE) {
#   file_url |>
#     googledrive::drive_download(path = stringr::str_glue("{download_folder}{file_url}"),
#                                 type = "zip",
#                                 overwrite = overwrite)
# }
#
#
#
# download_single_video(video_files[1])
