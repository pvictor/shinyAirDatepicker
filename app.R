

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
      
    ),
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "defaultvalue",
        label = "With a default date:",
        value = Sys.Date()-7
      )
      
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
}

# app ----

shinyApp(ui = ui, server = server)
