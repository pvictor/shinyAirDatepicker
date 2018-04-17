

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
        placeholder = "You can pick 3 dates",
        multiple = 3, clearButton = TRUE
      ),
      verbatimTextOutput(outputId = "res_multiple"),

      airDatepickerInput(
        inputId = "range",
        label = "Select range of dates:",
        range = TRUE, value = c(Sys.Date()-7, Sys.Date())
      ),
      verbatimTextOutput(outputId = "res_range")
      
    ),
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "defaultValue",
        label = "With a default date:",
        value = Sys.Date()-7
      ),
      verbatimTextOutput(outputId = "res_defaultValue"),
      
      airDatepickerInput(
        inputId = "month",
        label = "Select months:",
        view = "months", minView = "months",
        dateFormat = "MM yyyy"
      ),
      verbatimTextOutput(outputId = "res_month")
      
    )
    
  )
)

# server ----

server <- function(input, output, session) {
  
  output$res_default <- renderPrint( str(input$default) )
  output$res_defaultValue <- renderPrint( str(input$defaultValue) )
  output$res_multiple <- renderPrint( str(input$multiple) )
  output$res_month <- renderPrint( str(input$month) )
  output$res_range <- renderPrint( str(input$range) )
  
}

# app ----

shinyApp(ui = ui, server = server)
