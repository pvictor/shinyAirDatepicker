

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
  
  tags$style(".-disabled- {cursor: not-allowed !important;}"),
  
  fluidRow(
    
    column(
      width = 6,
      
      airDatepickerInput(
        inputId = "disable",
        label = "Disable some dates:",
        value = Sys.Date(), position = "bottom left",
        disabledDates = Sys.Date() + c(-9, -5, 2, 5, 8)
      ),
      verbatimTextOutput(outputId = "res_disable")
      
    ),
    
    column(
      width = 6,
      
      ""
      
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
  output$res_minmax <- renderPrint({ str(input$minmax) })
  output$res_close <- renderPrint({ str(input$close) })
  output$res_inline <- renderPrint({ str(input$inline) })
  output$res_french <- renderPrint({ str(input$french) })
  output$res_disable <- renderPrint({ str(input$disable) })
  
}

# app ----

shinyApp(ui = ui, server = server)
