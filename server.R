#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  
  #---------------------------------------------------------------------
  # run search on word in input text box 
  #---------------------------------------------------------------------
 
  observeEvent(input$Go,{

 output$results <- renderTable({
   
       page_results <- searchPages(input$page, token = auth , n = input$n_page)
       page_results <- page_results[,c(15,7,2)]
   
   }, spacing = 'xs', align = 'c', na = '-', striped = T , bordered = T) 
   
  })
 
 
  
  
})
