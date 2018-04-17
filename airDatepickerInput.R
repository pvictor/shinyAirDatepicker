

#  ------------------------------------------------------------------------
#
# Title : airDatepickerInput
#    By : Vic
#  Date : 2018-04-17
#    
#  ------------------------------------------------------------------------

library(shiny)


airDatepickerInput <- function(inputId, label = NULL, value = NULL, multiple = FALSE,
                               range = FALSE, timepicker = FALSE,
                               separator = " - ", placeholder = NULL, 
                               inline = FALSE, dateFormat = "yyyy-mm-dd",
                               view = c("days", "months", "years"),
                               minView = c("days", "months", "years"),
                               language = "en", width = NULL) {
  
  paramsAir <- dropNulls(list(
    id = inputId,
    type = "text",
    class = "sw-air-picker form-control",
    `data-language` = language, 
    # `data-timepicker` = tolower(timepicker),
    `data-start-date` = if (!is.null(value)) jsonlite::toJSON(x = value, auto_unbox = FALSE),
    `data-range` = if (!is.null(value) && length(value) > 1) "true" else tolower(range),
    `data-date-format` = dateFormat,
    placeholder = placeholder,
    `data-multiple-dates` = tolower(multiple),
    `data-multiple-dates-separator` = separator,
    `data-inline` = tolower(inline),
    `data-view` = match.arg(view),
    `data-min-view` = match.arg(minView)
  ))
  
  tagAir <- do.call(tags$input, paramsAir)
  
  tagList(
    singleton(
      tagList(
        tags$link(href = "air-datepicker/datepicker.min.css", rel = "stylesheet", type = "text/css"),
        tags$script(src = "air-datepicker/datepicker.min.js"),
        tags$script(src = "air-datepicker/i18n/datepicker.en.js"),
        tags$script(src = "air-datepicker/datepicker-bindings.js")
      )
    ),
    tags$div(
      class = "form-group shiny-input-container",
      style = if (!is.null(width)) 
        paste0("width: ", htmltools::validateCssUnit(width), ";"),
      if (!is.null(label)) tags$label(label, `for` = inputId),
      tagAir
    )
  )
}



dropNulls <- function (x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


shiny::registerInputHandler("air.datepicker", function(data, ...) {
  if (is.null(data)) {
    NULL
  } else {
    res <- try(as.Date(unlist(data)), silent = TRUE)
    if ("try-error" %in% class(res)) {
      warning("Failed to parse dates!")
      as.Date(NA)
    } else {
      res
    }
  }
}, force = TRUE)
