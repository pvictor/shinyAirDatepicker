

#  ------------------------------------------------------------------------
#
# Title : airDatepickerInput
#    By : Vic
#  Date : 2018-04-17
#    
#  ------------------------------------------------------------------------

library(shiny)


airDatepickerInput <- function(inputId, label = NULL, placeholder = NULL, language = "en", width = NULL) {
  
  paramsAir <- dropNulls(list(
    type = "text",
    class = "datepicker-here form-control",
    `data-language` = language,
    placeholder = placeholder
  ))
  
  tagAir <- do.call(tags$input, paramsAir)
  
  tagList(
    singleton(
      tagList(
        tags$link(href = "air-datepicker/datepicker.min.css", rel = "stylesheet", type = "text/css"),
        tags$script(src = "air-datepicker/datepicker.min.js"),
        tags$script(src = "air-datepicker/i18n/datepicker.en.js")
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

