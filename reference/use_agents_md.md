# Create or overwrite an AGENTS.md configuration file

Generates an `AGENTS.md` file with common code practices (R, Quarto) for
LLMs. By default, writes a new file unless `overwrite = TRUE` is
specified. You basically create the file with
`rfortherestofus::use_agents_md()` and then tell your favorite AI to
read it. You can also copy paste the content to use in other interface.

## Usage

``` r
use_agents_md(sections, overwrite = FALSE)
```

## Arguments

- sections:

  Character vector with sections to add in the `AGENTS.md`. Possible
  values are "R", "Quarto", "Typst".

- overwrite:

  Logical. Whether to overwrite an existing file. Default is `FALSE`.

## Examples

``` r
if (FALSE) { # \dontrun{
rfortherestofus::use_agents_md("R")              # just R rules
rfortherestofus::use_agents_md("Quarto")         # just Quarto rules
rfortherestofus::use_agents_md("Typst")          # just Typst rules
rfortherestofus::use_agents_md(c("R", "Quarto")) # R and Quarto rules
} # }
```
