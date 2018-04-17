

#  ------------------------------------------------------------------------
#
# Title : Air datepicker
#    By : Vic
#  Date : 2018-04-17
#    
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library("shiny")




# Funs --------------------------------------------------------------------

source("airDatepickerInput.R")




# app ---------------------------------------------------------------------



# ui ----

ui <- fluidPage(
  tags$h2("Air datepicker example"),
  tags$br(),
  
  fluidRow(
    
    column(
      width = 6,
      airDatepickerInput(
        inputId = "air1",
        label = "First example:"
      )
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
}

# app ----

shinyApp(ui = ui, server = server)
