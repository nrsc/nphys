#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(nphys)
library(shinydashboard)
library(dplyr)

data(field)


# Define UI for LTD
ui <- fluidPage(

    titlePanel("Examining a field excitatory post synaptic potential"),


    navbarPage("My Application",
               tabPanel("Component 1"),
               tabPanel("Component 2"),
               tabPanel("Component 3")
    ),



    sidebarPanel(
        sidebarLayout(
            checkboxInput('p1', 'P1'),
            #checkboxInput('p2', 'P2'),
            checkboxInput('p3', 'P3')
            ),

    ),

    dashboardBody(
         plotlyOutput("tracePlot",
                      width = "100%")
    )



)

# Define server logic required to draw a histogram
server <- function(input, output) {

    xA = list(
        title = "Time (ms)"
    )
    yA = list(
        range = c(-1.2,0.1),
        title = "mV"
    )


    output$tracePlot <- renderPlotly({
    plotly::plot_ly(
            data = data.frame(field$traces),
            x = ~ ms,
            y = ~ Bl_Avg,
            type = "scatter",
            mode = "lines"
        ) %>%  plotly::layout(xaxis = xA,yaxis = yA)
    })



    # output$tracePlot <- render
    #     input$cond
    #     #plot = plotly::add_trace(p = plot,x = ~ms, y = ~Decay_Avg)
    #     #plot = plotly::add_trace(p = plot,x = ~ms, y = ~Cond_Avg)

}

# Run the application
shinyApp(ui = ui, server = server)
