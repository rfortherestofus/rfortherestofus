#' @keywords internal
agent_sections <- list(
  R = "
General coding rules to follow for the R programming language:
- Always use the tidyverse (dplyr, ggplot2, tibble...) unless explicitly asked not to.
- Always add a `library(<pkg_name>)` at the top of the file.
- For less common packages, give installation instructions using `pak`: `pak::pkg_install()`.
- Make the code as consistent as possible
- Avoid as much as reasonnable code dupplications
- Warn users when code would benefit from a refactoring, without blocking them.
- Always use the `<-` operator when assigning a variable/functions.
- Never use absolute paths nor use `setwd()`. Use `here::here()` instead.

R package development coding rules:
- Always document code using roxygen2 tags and separe tag sections with a linebreak. Avoid too long lines.
- Use `devtools::load_all()` to load latest package functions
- Document functions with `devtools::document()` for documenting functions
- Never use `library(<pkg_name>)` but rather the `@import` and `@importFrom` tag. Also update dependencies with `usethis::use_package(<pkg_name>)`.
- Never use `library(<pkg_name>)` in unit tests.",
  Quarto = "
Quarto document coding rules:
- Use descriptive YAML headers with title, author, date, and format specifications
- Prefer `#| label:` chunk labels over unnamed chunks for better debugging and cross-referencing
- Use `#|` hash-pipe syntax for chunk options (modern Quarto style)
- Set global chunk options in the YAML header under `execute:`
- Test rendering with `quarto render`
- For pdf rendering, always use Typst with `format: typst`.
- Do not rewrite narrative text unless explicitly asked or grammatical errors."
)

#' @title Create or overwrite an AGENT.md configuration file
#'
#' @description Generates an `AGENT.md` file with common code practices
#' (R, Quarto) for LLMs. By default, writes a new file unless `overwrite = TRUE`
#' is specified.
#' You basically create the file with `rfortherestofus::use_agent_md()` and then
#' tell your favorite AI to read it. You can also copy paste the content to use in
#' other interface.
#'
#' @param sections Character vector with sections to add in the `AGENT.md`. Possible
#' values are "R" and "Quarto".
#' @param overwrite Logical. Whether to overwrite an existing file. Default is `FALSE`.
#'
#' @examples
#' \dontrun{
#' rfortherestofus::use_agent_md("R")              # just R rules
#' rfortherestofus::use_agent_md("Quarto")         # just Quarto rules
#' rfortherestofus::use_agent_md(c("R", "Quarto")) # R and Quarto rules
#' }
#'
#' @export
use_agent_md <- function(sections, overwrite = FALSE) {
  file_name <- "AGENT.md"
  if (file.exists(file_name) && !overwrite) {
    stop(paste0(
      file_name,
      " already exists. Use overwrite = TRUE to replace it."
    ))
  }

  unknown <- setdiff(sections, names(agent_sections))
  if (length(unknown) > 0) {
    stop("Unknown sections: ", paste(unknown, collapse = ", "))
  }

  preamble <- paste0(
    "# Agent Project Context\n",
    "You are an expert developer assisting with this project.\n",
    "Strictly adhere to the following technical standards and coding conventions defined below.\n",
    "If instructions conflict with these rules, prioritize these rules unless explicitly overridden.\n\n",
    "---"
  )

  content <- c(
    preamble,
    unlist(agent_sections[sections])
  )

  writeLines(paste(content, collapse = "\n"), file_name)
  message(paste("✓ Created", file_name))
}
