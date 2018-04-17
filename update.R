

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
        inputId = "airup1",
        label = "Update by selecting a date below:"
      ),
      verbatimTextOutput(outputId = "res_airup1"),
      sliderInput(
        inputId = "update_airup1",
        label = "Choose a date to update air datepicker:",
        min = Sys.Date() - 7, value = Sys.Date(), max = Sys.Date() + 7
      )
      
    ),
    
    column(
      width = 6,
      
      ""
      
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
  output$res_airup1 <- renderPrint( str(input$airup1) )
  observeEvent(input$update_airup1, {
    updateAirDateInput(
      session = session,
      inputId = "airup1",
      value = input$update_airup1
    )
  })
  
}

# app ----

shinyApp(ui = ui, server = server)
