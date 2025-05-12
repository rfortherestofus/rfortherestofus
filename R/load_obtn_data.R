#' Download a file from a GitHub repository
#'
#' This function downloads a file from a specified GitHub repository and saves it to a local directory.
#'
#' @name download_file
#' @param file_path A character string specifying the path to the file in the GitHub repository.
#' @param dest_path A character string specifying the destination directory where the file will be saved.
#' @param verbose A logical value indicating whether to print messages during the download process. Default is `FALSE`.
#' @return A character string representing the path to the downloaded file, or `NULL` if the download fails.
#' @export
download_file <- function(file_path, dest_path, verbose = FALSE) {
    if (!dir.exists(dest_path)) {
        message("Creating temporary directory: ", dest_path)
        dir.create(dest_path, recursive = TRUE)
    }

    response <- tryCatch(
        {
            gh::gh(
                "GET /repos/{owner}/{repo}/contents/{path}",
                owner = "rfortherestofus",
                repo = "obtn_pipeline",
                path = file_path
            )
        },
        error = function(e) {
            warning("Error fetching file '", file_path, "': ", e$message)
            return(NULL)
        }
    )

    if (is.null(response)) return(NULL)

    file_content <- base64enc::base64decode(response$content)
    file_name <- basename(file_path)
    dest_file <- file.path(dest_path, file_name)
    writeBin(file_content, dest_file)

    if (verbose) {
        message("File saved to: ", dest_file)
    }

    return(dest_file)
}

#' Get a list of files matching a pattern from a GitHub repository
#'
#' This function retrieves a list of files from a specified GitHub repository that match a given pattern.
#'
#' @name get_files
#' @param pattern A character string specifying the pattern to match file names.
#' @param dir A character string specifying the directory in the GitHub repository to search. Default is `"data-clean/"`.
#' @return A character vector of file paths that match the pattern, or an error if the directory listing fails.
#' @export
get_files <- function(pattern, dir = "data-clean/") {
    pattern <- paste0(dir, pattern)

    dir_contents <- tryCatch(
        {
            gh::gh(
                "GET /repos/{owner}/{repo}/contents/{path}",
                owner = "rfortherestofus",
                repo = "obtn_pipeline",
                path = dirname(pattern)
            )
        },
        error = function(e) {
            stop("Error listing directory: ", e$message)
        }
    )

    file_pattern <- basename(pattern)
    matching_files <- sapply(dir_contents, function(x) {
        if (grepl(file_pattern, x$name) && x$type == "file") {
            return(x$path)
        } else {
            return(NULL)
        }
    })

    matching_files <- unlist(matching_files)
    return(matching_files)
}

#' Load data from a GitHub repository
#'
#' This function downloads files matching a specified pattern from a GitHub repository, loads them into a data frame, and optionally deletes the temporary directory used for downloading.
#'
#' @name load_obtn_data
#' @param pattern A character string specifying the pattern to match file names.
#' @param dest_path A character string specifying the destination directory for downloaded files. Default is `"temp/"`.
#' @param verbose A logical value indicating whether to print messages during the download process. Default is `FALSE`.
#' @param delete_temp_dir A logical value indicating whether to delete the temporary directory after loading the data. Default is `TRUE`.
#' @return A data frame containing the combined data from all matching files.
#' @examples
#' \dontrun{
#' df <- load_obtn_data("data_county_url")
#' df <- load_obtn_data("data_alice")
#' }
#' @export
load_obtn_data <- function(
    pattern,
    dest_path = "temp/",
    verbose = FALSE,
    delete_temp_dir = TRUE
) {
    all_files <- get_files(pattern = pattern)
    for (file in all_files) {
        download_file(
            file_path = file,
            dest_path = dest_path,
            verbose = verbose
        )
    }

    df <- purrr::map_dfr(
        list.files(dest_path, pattern = pattern, full.names = TRUE),
        function(file) {
            obj <- qs::qread(file)
            # If it's a list of one element (e.g., list(data_alice = <df>)), extract the first element
            if (is.list(obj) && length(obj) == 1 && is.data.frame(obj[[1]])) {
                return(obj[[1]])
            } else {
                return(obj)
            }
        }
    )

    if (delete_temp_dir) {
        unlink(dest_path, recursive = TRUE)
    }
    return(df)
}
