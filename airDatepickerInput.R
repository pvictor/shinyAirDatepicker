

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
                               dateFormat = "yyyy-mm-dd",
                               minDate = NULL, maxDate = NULL,
                               disabledDates = NULL,
                               view = c("days", "months", "years"),
                               minView = c("days", "months", "years"),
                               monthsField = c("monthsShort", "months"),
                               clearButton = FALSE, todayButton = FALSE, autoClose = FALSE, 
                               timepickerOpts = timepickerOptions(),
                               position = NULL, update_on = c("change", "close"),
                               addon = c("right", "left", "none"),
                               language = "en", inline = FALSE, width = NULL) {
  addon <- match.arg(addon)
  language <- match.arg(
    arg = language,
    choices = c("cs", "da", "de", "en", "es", "fi", "fr", "hu", "nl", "pl", 
                "pt-BR", "pt", "ro", "sk", "zh"),
    several.ok = TRUE
  )
  if (inherits(value, "POSIXt")) {
    value <- format(lubridate::with_tz(value, tzone = "UTC"), format = "%Y-%m-%dT%H:%M:00")
  }
  if (!is.null(disabledDates)) {
    disabledDates <- jsonlite::toJSON(x = disabledDates, auto_unbox = FALSE)
  }
  paramsAir <- dropNulls(list(
    id = inputId,
    class = "sw-air-picker",
    `data-language` = language, 
    `data-timepicker` = tolower(timepicker),
    `data-start-date` = if (!is.null(value)) jsonlite::toJSON(x = value, auto_unbox = FALSE),
    `data-range` = tolower(range),
    `data-date-format` = dateFormat,
    `data-min-date` = minDate, `data-max-date` = maxDate,
    `data-multiple-dates` = tolower(multiple),
    `data-multiple-dates-separator` = separator,
    `data-view` = match.arg(view),
    `data-min-view` = match.arg(minView),
    `data-clear-button` = tolower(clearButton),
    `data-auto-close` = tolower(autoClose),
    `data-today-button` = tolower(todayButton),
    `data-months-field` = match.arg(monthsField),
    `data-update-on` = match.arg(update_on),
    `data-position` = position,
    `data-disabled-dates` = disabledDates
  ))
  paramsAir <- c(paramsAir, timepickerOpts)
  
  if (!inline) {
    addArgs <- dropNulls(list(
      type = "text", 
      class = " form-control", 
      placeholder = placeholder
    ))
    tagAir <- do.call(tags$input, c(paramsAir, addArgs))
    tagAir <- tags$div(
      class = "input-group",
      if (addon == "left") tags$div(class = "input-group-addon", icon("calendar")),
      tagAir,
      if (addon == "right") tags$div(class = "input-group-addon", icon("calendar"))
    )
  } else {
    tagAir <- do.call(tags$div, paramsAir)
  }
  
  tagList(
    singleton(
      tags$head(
        tags$link(href = "air-datepicker/datepicker.min.css", rel = "stylesheet", type = "text/css"),
        tags$script(src = "air-datepicker/datepicker.min.js"),
        tags$script(src = "air-datepicker/datepicker-bindings.js")
      )
    ),
    singleton(
      tags$head(
        lapply(
          X = language,
          FUN = function(x) {
            tags$script(src = sprintf("air-datepicker/i18n/datepicker.%s.js", x))
          }
        )
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

timepickerOptions <- function(dateTimeSeparator = NULL, timeFormat = NULL,
                           minHours = NULL, maxHours = NULL, 
                           minMinutes = NULL, maxMinutes = NULL,
                           hoursStep = NULL, minutesStep = NULL) {
  dropNulls(list(
    `data-date-time-separator` = dateTimeSeparator,
    `data-time-format` = timeFormat,
    `data-min-hours` = minHours,
    `data-max-hours` = maxHours,
    `data-min-minutes` = minMinutes,
    `data-max-minutes` = maxMinutes,
    `data-hours-step` = hoursStep,
    `data-minutes-step` = minutesStep
  ))
}



dropNulls <- function (x) {
  x[!vapply(x, is.null, FUN.VALUE = logical(1))]
}


shiny::registerInputHandler("air.date", function(data, ...) {
  if (is.null(data)) {
    NULL
  } else {
    res <- try(as.Date(unlist(data)), silent = TRUE)
    if ("try-error" %in% class(res)) {
      warning("Failed to parse dates!")
      # as.Date(NA)
      data
    } else {
      res
    }
  }
}, force = TRUE)

shiny::registerInputHandler("air.datetime", function(data, ...) {
  parse_datetime <- function(x) {
    lubridate::with_tz(as.POSIXct(x = x, format = "%Y-%m-%dT%H:%M:%S", tz = "UTC"))
  }
  if (is.null(data)) {
    NULL
  } else {
    res <- try(parse_datetime(unlist(data)), silent = TRUE)
    if ("try-error" %in% class(res)) {
      warning("Failed to parse dates!")
      # as.Date(NA)
      data
    } else {
      res
    }
  }
}, force = TRUE)




updateAirDateInput <- function(session, inputId, label = NULL, value = NULL, clear = FALSE) {
  stopifnot(is.logical(clear))
  formatDate <- function(x) {
    if (is.null(x)) 
      return(NULL)
    format(as.Date(x), "%Y-%m-%d")
  }
  value <- formatDate(value)
  if (!is.null(value)) {
    value <- as.character(jsonlite::toJSON(x = value, auto_unbox = FALSE))
  }
  message <- dropNulls(list(
    label = label,
    value = value,
    clear = clear
  ))
  session$sendInputMessage(inputId, message)
}


