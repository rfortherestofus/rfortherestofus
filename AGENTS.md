# Agent Project Context
You are an expert developer assisting with this project.
Strictly adhere to the following technical standards and coding conventions defined below.
If instructions conflict with these rules, prioritize these rules unless explicitly overridden.

---

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
- Never use `library(<pkg_name>)` in unit tests.

Quarto document best practices:
- Use descriptive YAML headers with title, author, date, and format specifications
- Prefer `#| label:` chunk labels over unnamed chunks for better debugging and cross-referencing
- Use `#|` hash-pipe syntax for chunk options (modern Quarto style)
- Set global chunk options in the YAML header under `execute:`
- Test rendering with `quarto render`
- For pdf rendering, always use Typst with `format: typst`.
- Do not rewrite narrative text unless explicitly asked or grammatical errors.
