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

#data(field)

lf <- list.files("~/nphys/dir/DGDev", pattern = "DGDev.rda", recursive = TRUE, full.names = TRUE)
tst <- unlist(fileD(lf))
tst <- gsub("-DGDev.rda", "", tst)
names(tst) = NULL

# Define UI for LTD
ui <- fluidPage(

    #titlePanel("Examining a field excitatory post synaptic potential"),

    dashboardPage(
        dashboardHeader(disable = TRUE),#Title = "Examining a field excitatory post synaptic potential"),

        dashboardSidebar(
            selectInput("fieldSlice", label = "Select slice:", choices = tst)#,
            # sliderInput("ymin",
            #              label = "ymin",
            #              min = -10, max = 1, value = c(-10, 1))
            #sliderInput("ymax", label = "ymax", min = 0, max = 1, value = 1)
        ),

        dashboardBody(
             plotlyOutput("p", width = "100%")
        )
    ),

    uiOutput("data")

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {

    #ranges <- reactiveValues(x = NULL, y = NULL)

    output$data <- renderUI(
    load(lf[grep(input$fieldSlice, lf)], envir = parent.frame()),
    )

    traces = as.data.frame(DGDev$traces)


    # observeEvent(input$ymin, {
    #      min = min(traces$blTrace)
    #      max = max(traces$blTrace)
    #      updateSliderInput(session, "ymin", min = min, max = max)
    # })


    output$p <- renderPlotly({

    # ymin = min(traces$blTrace)
    # ymax = max(traces$blTrace)

    ggplot(traces, aes(ms, blTrace))+
        geom_line()+
        #coord_cartesian(xlim = ranges$x, ylim = ranges$y)+
        theme_void()
})




}

# Run the application
shinyApp(ui = ui, server = server)
