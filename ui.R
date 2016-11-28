#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)


shinyUI(fluidPage(
  shinyjs::useShinyjs(),
  
  
  titlePanel("WDMP - Research Lab"),
  
  
  sidebarLayout(
    sidebarPanel(width = 3, tags$style(".well{background-color:#00ABC2; color:#FFF; font-weight:bold}"),
                 
                 textInput(inputId = 'page', label = 'Search a Page: ',width = '300px')
                 
                 ,sliderInput(inputId = 'n_page', label = 'Number of results:',value = 100,min = 10, max = 500, step = 20, width = '300px')
                 ,tags$style(".irs-grid-text{color:#FFF}
                             .irs-slider{background-color:#FFF}
                             .irs-bar{background:#FFF}
                             .irs-bar-edge{background:#FFF}
                             .irs-single{background:#424949}")
                 
                 ),

    
    mainPanel(
      dashboardPage(
        dashboardHeader(disable = T)
        ,dashboardSidebar(disable = T)
        ,dashboardBody(
          fluidRow(
            'CONTENT'
          )
        )
      )
    )
  )
))
