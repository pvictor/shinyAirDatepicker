

#  ------------------------------------------------------------------------
#
# Title : Air datepicker with timepicker
#    By : Vic
#  Date : 2018-04-18
#    
#  ------------------------------------------------------------------------



# Packages ----------------------------------------------------------------

library("shiny")




# Funs --------------------------------------------------------------------

source("airDatepickerInput.R")


# app ---------------------------------------------------------------------



# ui ----

ui <- fluidPage(
  tags$h2("Air datepicker with timepicker example"),
  tags$br(),
  
  fluidRow(
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "datedefault",
        label = "Date default:"
      ),
      verbatimTextOutput(outputId = "res_datedefault")
      
    ),
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "datetime",
        label = "Pick date and time:",
        timepicker = TRUE
      ),
      verbatimTextOutput(outputId = "res_datetime"),
      
      airDatepickerInput(
        inputId = "options",
        label = "With some options:",
        multiple = TRUE, value = Sys.time(),
        timepicker = TRUE,
        timepickerOpts = timepickerOpts(
          dateTimeSeparator = ":", 
          minutesStep = 10, 
          hoursStep = 2
        )
      ),
      verbatimTextOutput(outputId = "res_options")
      
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
  output$res_datedefault <- renderPrint( str(input$datedefault) )
  output$res_datetime <- renderPrint( str(input$datetime) )
  output$res_options <- renderPrint( str(input$options) )
  
}

# app ----

shinyApp(ui = ui, server = server)
