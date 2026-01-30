# Create or overwrite an AGENT.md configuration file

Generates an `AGENT.md` file with common code practices (R, Quarto) for
LLMs. By default, writes a new file unless `overwrite = TRUE` is
specified. You basically create the file with
`rfortherestofus::use_agent_md()` and then tell your favorite AI to read
it. You can also copy paste the content to use in other interface.

## Usage

``` r
use_agent_md(sections, overwrite = FALSE)
```

## Arguments

- sections:

  Character vector with sections to add in the `AGENT.md`. Possible
  values are "R" and "Quarto".

- overwrite:

  Logical. Whether to overwrite an existing file. Default is `FALSE`.

## Examples

``` r
if (FALSE) { # \dontrun{
rfortherestofus::use_agent_md("R")              # just R rules
rfortherestofus::use_agent_md("Quarto")         # just Quarto rules
rfortherestofus::use_agent_md(c("R", "Quarto")) # R and Quarto rules
} # }
```
