#' @title Create a new proposal
#'
#' @description
#' Init a new directory for a proposal.
#'
#' @param dir Directory for the proposal
#'
#' @examples
#' /dontrun{
#' create_new_proposal("potential-client")
#' }
#'
#' @export
create_new_proposal <- function(dir) {
  download_files <- function(path_in_repo, files, dest_dir) {
    req <- gh::gh(
      "GET /repos/{owner}/{repo}/contents/{path}",
      owner = "rfortherestofus",
      repo = "proposal-template",
      path = path_in_repo,
      .token = gh::gh_token()
    )

    dir.create(dest_dir, showWarnings = FALSE, recursive = TRUE)

    for (file_name in files) {
      file_info <- Filter(function(x) x$name == file_name, req)
      if (length(file_info) == 1) {
        content <- gh::gh(
          "GET /repos/{owner}/{repo}/contents/{path}",
          owner = "rfortherestofus",
          repo = "proposal-template",
          path = file.path(path_in_repo, file_name),
          .token = gh::gh_token()
        )
        writeBin(
          jsonlite::base64_dec(content$content),
          file.path(dest_dir, file_name)
        )
        message("Saving: ", file.path(dest_dir, file_name))
      } else {
        warning("File not found in repo: ", file_name)
      }
    }
  }

  root_files <- c(
    "asset-background.svg",
    "asset-chart.png",
    "asset-dollar.png",
    "asset-workflow.png",
    "rfortherestofus-logo.png",
    "template.qmd"
  )
  download_files("", root_files, dir)

  extension_files <- c("typst-template.typ", "typst-show.typ", "_extension.yml")
  download_files(
    "_extensions/proposal-template",
    extension_files,
    file.path(dir, "_extensions/proposal-template")
  )
}
