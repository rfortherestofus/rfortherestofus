#' @keywords internal
agent_sections <- list(
  R = "
General coding rules to follow for the R programming language:
- Always use the tidyverse (dplyr, ggplot2, tibble...) unless explicitly asked not to.
- Always add a `library(<pkg_name>)` at the top of the file.
- Always use the native pipe operator: |>.
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
- Do not rewrite narrative text unless explicitly asked or grammatical errors.",
  Typst = "
Typst document coding rules:
- Minimize code dupplication by defining reusable functions. Usage is like this:

```typ
#let top-of-page(title, image-path, image-alt) = {
  stack(
    dir: ltr, // left to right
    spacing: 1.5cm,
    heading(title),
    place(dy: -1cm, image(image-path, width: 4cm, alt: image-alt))
  )
}

#top-of-page('Building a Clean Energy Future', 'images/logo-ipsum.svg', 'ipsum logo')
#top-of-page('The Future is Cleaner and Cheaper', 'outputs/town-map.png', 'Town map')
```
- If we're inside a Quarto document (.qmd files), you can use R values with the following syntax:
```typ
#top-of-page('`r params$town` consectetur adipiscing elit', 'outputs/map.png', 'map')
```
Where params is a named list with the town key.

- In Quarto, you can a typst code block like this:

```{=typst}
#top-of-page('Lorem', 'images/logo.svg', 'ipsum logo')
#box(width: 75%)[Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam.]
```

- For all common styling, use set and show rules, with the following syntax.
  - Set rules define default behavior(s) of a given Typst function:
```typ
#set text(font: 'Google Sans', lang: 'en', region: 'US', size: 13pt)
#set page(margin: (x: 2cm, y: 2cm))
```
  - Show rules let us define more complex set rules:
```typ
#show heading: it => {
  set text(size: 25pt, fill: rgb('#8FB070'))
  box(width: 75%)[#it.body]
}
```
This changes all heading to be green, 25pt size and inside a box that spans 75% of the current container.
- Remember that Typst has 2 modes: markup (default, what you see most of the time) and code mode (for scripting and logic).
You can find syntax information by reading this page (https://typst.app/docs/reference/styling/) and this page (https://typst.app/docs/reference/scripting/).
- Make sure pdf outputs are accessible. In Typst, accessibility is done by always adding an alternative text in images (using the `alt` argument). Also, reading order of assistive technology is defined by the order the typst document is written, so make sure this one is coherent. If not defined, use colors with enough color contrast.
"
)

#' @title Create or overwrite an AGENTS.md configuration file
#'
#' @description Generates an `AGENTS.md` file with common code practices
#' (R, Quarto) for LLMs. By default, writes a new file unless `overwrite = TRUE`
#' is specified.
#' You basically create the file with `rfortherestofus::use_agents_md()` and then
#' tell your favorite AI to read it. You can also copy paste the content to use in
#' other interface.
#'
#' @param sections Character vector with sections to add in the `AGENTS.md`. Possible
#' values are "R" and "Quarto".
#' @param overwrite Logical. Whether to overwrite an existing file. Default is `FALSE`.
#'
#' @examples
#' \dontrun{
#' rfortherestofus::use_agents_md("R")              # just R rules
#' rfortherestofus::use_agents_md("Quarto")         # just Quarto rules
#' rfortherestofus::use_agents_md("Typst")          # just Typst rules
#' rfortherestofus::use_agents_md(c("R", "Quarto")) # R and Quarto rules
#' }
#'
#' @export
use_agents_md <- function(sections, overwrite = FALSE) {
  file_name <- "AGENTS.md"
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
