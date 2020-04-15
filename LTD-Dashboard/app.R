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

# Define UI for LTD
ui <- fluidPage(

    dashboardPage(
        # Header
        dashboardHeader(),

        # Sidebar
        dashboardSidebar(
            sidebarMenu(
                menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
                menuItem("Widgets", tabName = "widgets", icon = icon("th"))
            )
        ),
        # Body
        dashboardBody(
            traces    <- field$LTDtraces,
            plotly::plot_ly(data = traces, x = ~Time, y = ~Bl_Avg, type = "scatter", mode = "markers") %>%
                add_trace(x = ~Time, y = ~Decay_Avg) %>%
                add_trace(x = ~Time, y = ~Cond_Avg) %>%
                layout(
                    xaxis = list(
                        title = "Time (ms)"
                    ),
                    yaxis = list(
                        range = c(-1.2,0.1),
                        title = "mV"
                    )
                )
        )
    )

)

# Define server logic required to draw a histogram
server <- function(input, output) {

    output$distPlot <- renderPlot({
        # generate bins based on input$bins from ui.R
        x    <- field$LTDtraces
        bins <- seq(min(x), max(x), length.out = input$bins + 1)

        # draw the histogram with the specified number of bins
        hist(x, breaks = bins, col = 'darkgray', border = 'white')
    })
}

# Run the application
shinyApp(ui = ui, server = server)
