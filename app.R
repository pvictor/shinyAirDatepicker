

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
        inputId = "default",
        label = "First example:"
      ),
      verbatimTextOutput(outputId = "res_default"),
      
      airDatepickerInput(
        inputId = "multiple",
        label = "Select multiple dates:", 
        multiple = TRUE
      ),
      verbatimTextOutput(outputId = "res_multiple")
      
    ),
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "defaultValue",
        label = "With a default date:",
        value = Sys.Date()-7
      ),
      verbatimTextOutput(outputId = "res_defaultValue")
      
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
  output$res_default <- renderPrint( str(input$default) )
  output$res_defaultValue <- renderPrint( str(input$defaultValue) )
  output$res_multiple <- renderPrint( str(input$multiple) )
  
}

# app ----

shinyApp(ui = ui, server = server)
