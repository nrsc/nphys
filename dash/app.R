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


    titlePanel("Examining a field excitatory post synaptic potential"),

    navbarPage("My Application",
               tabPanel("Component 1"),
               tabPanel("Component 2"),
               tabPanel("Component 3")
    ),



    sidebarPanel(

        selectInput("fieldSlice", label = "Select slice:", choices = tst)


    ),

    dashboardBody(
         plotlyOutput("p", width = "100%")
    ),

)

# Define server logic required to draw a histogram
server <- function(input, output, session) {


    output$p <- renderPlotly({


        load(lf[grep(input$fieldSlice, lf)],envir = .GlobalEnv)
        traces = data.frame(DGDev$traces)
        x = traces$ms
        y = traces$blTrace

        d <- event_data("plotly_relayout", source = "trajectory")

        selected_point <- if (!is.null(d[["shapes[0].x0"]])) {
             xint <- d[["shapes[0].x0"]]
             xpt <- x[which.min(abs(x - xint))]
             list(x = xpt, y = y[which(x == xpt)])
         } else {
             list(x = 1, y = y[which(x == 1)])
         }




    plot_ly(color = I("red"), source = "trajectory") %>%
        add_lines(x = x, y = y) %>%
        add_markers(x = selected_point$x, y = selected_point$y) %>%
         layout(
             shapes = list(
                 type = "line",
                 line = list(color = "gray", dash = "dot"),
                 x0 = selected_point$x,
                 x1 = selected_point$x,
                 y0 = 0,
                 y1 = 1,
                 yref = "paper"
             )
         ) %>%
        config(editable = TRUE)

    event_register(p, 'plotly_relayout')
})


}

# Run the application
shinyApp(ui = ui, server = server)
