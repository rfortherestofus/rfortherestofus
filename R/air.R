use_air_toml <- function(
    line_width = 80,
    indent_width = 2,
    indent_style = "space",
    line_ending = "auto",
    persistent_line_breaks = "true",
    exclude = "[]",
    default_exclude = "true",
    skip = "[]",
    file_name = "air.toml",
    overwrite = FALSE
) {
    if (is.character(indent_width)) {
        indent_width <- paste0('"', indent_width, '"')
    }

    if (!(file_name %in% c("air.toml", ".air.toml"))) {
        stop(paste0(
            "Invalid file name: ",
            file_name,
            ". It must be either air.toml or .air.toml"
        ))
    }

    air_toml <- c(
        "[format]",
        paste0('line-width = ', line_width),
        paste0('indent-width = ', indent_width),
        paste0('indent-style = "', indent_style, '"'),
        paste0('line-ending = "', line_ending, '"'),
        paste0('persistent-line-breaks = ', persistent_line_breaks),
        paste0('exclude = ', exclude),
        paste0('default-exclude = ', default_exclude),
        paste0('skip = ', skip)
    )

    if (file.exists(file_name) && !overwrite) {
        stop(paste0(
            file_name,
            " already exists. Use overwrite = TRUE to replace it."
        ))
    }

    writeLines(text = air_toml, con = file_name)
}
