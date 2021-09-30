#' Convert PDF to Animated GIF
#'
#' @param pdf_location Location of PDF file
#' @param gif_file_path Starts at here::here()
#' @param gif_file_name You must include .gif at end
#' @param density Affects file size of GIF that is outputted
#'
#' @return
#' @export
#'
#' @examples
pdf_to_gif <- function(pdf_location,
                       gif_file_path = here::here(),
                       gif_file_name,
                       density = 50) {

  pdf_doc <- magick::image_read_pdf(pdf_location,
                                    density = 50)

  gif_file_name_and_path <- stringr::str_glue("{gif_file_path}/{gif_file_name}")

  pdf_doc %>%
    magick::image_animate(fps = 0.5) %>%
    magick::image_write(path = gif_file_name_and_path)

}

