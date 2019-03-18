library(shiny)
library(pushbar)

ui <- fluidPage(
  theme = shinythemes::shinytheme("flatly"),
  pushbar_deps(),
  div(
    class = "container",
    div(
      style = "margin-top:3%;text-align:center;",
	    tags$img(
				src = "https://raw.githubusercontent.com/JohnCoene/pushbar/master/man/figures/logo.png",
				style = "max-height:200px;",
				id = "logo"
			),
      br(),
      br(),
      p("Sliders for shiny.")
    ),
    br(),
    fluidRow(
      column(2),
      column(
        2, 
        actionButton("left_button", "LEFT", icon = icon("arrow-left"), width = "100%")
      ),
      column(
        2,
        actionButton("top_button", "TOP", icon = icon("arrow-up"), width = "100%")
      ),
      column(
        2,
        actionButton("bottom_button", "BOTTOM", icon = icon("arrow-down"), width = "100%")
      ),
      column(
        2,
        actionButton("right_button", "RIGHT", icon = icon("arrow-right"), width = "100%")
      ),
      column(2)
    ),
    br(),
    br(),
    br(),
    div(
      style = "text-align:center;",
      tags$a(
        icon("code", class = "fa-3x"),
        target = "_blank",
        href = "https://github.com/JohnCoene/pushbar"
      ),
      br(),
      br(),
      br(),
      code(
        "install.packages('waiter')"
      )
    ),
    pushbar(
      h4("LEFT"),
      sliderInput("left_slider", "", min = 50, max = 100, value = 75),
      plotOutput("left_plot"),
      from = "left"
    ),
    pushbar(
      fluidRow(
        column(
          2, 
          h4("Top"),
          sliderInput("top_slider", "", min = 50, max = 100, value = 65),
          actionButton("top_close", "", icon = icon("times"), class = "btn-danger")
        ),
        column(10, plotOutput("top_plot"))
      ),
      from = "top"
    ),
    pushbar(
      fluidRow(
        column(
          4, 
          h4("Bottom"),
          sliderInput("bottom_slider", "", min = 50, max = 100, value = 95),
          actionButton("bottom_close", "", icon = icon("times"), class = "btn-danger")
        ),
        column(8, plotOutput("bottom_plot", height = 250))
      ),
      from = "bottom"
    ),
    pushbar(
      h4("RIGHT"),
      sliderInput("right_slider", "", min = 50, max = 100, value = 35),
      plotOutput("right_plot"),
      from = "right"
    )
  )
)

server <- function(input, output, session) {

  setup_pushbar(TRUE, TRUE)

  # triggers
  observeEvent(input$left_button, {
    pushbar_open("left")
  })

  observeEvent(input$top_button, {
    pushbar_open("top")
  })

  observeEvent(input$bottom_button, {
    pushbar_open("bottom")
  })

  observeEvent(input$right_button, {
    pushbar_open("right")
  })

  observeEvent(input$bottom_close, {
    pushbar_close()
  })

  observeEvent(input$top_close, {
    pushbar_close()
  })

  # outputs
  output$left_plot <- renderPlot({
    plot(1:input$left_slider, runif(input$left_slider), main = "Random")
  })

  output$right_plot <- renderPlot({
    hist(runif(input$right_slider), main = "Histogram")
  })

  output$top_plot <- renderPlot({
    plot(1:input$top_slider, runif(input$top_slider), type = "l", main = "Random")
  })

  output$bottom_plot <- renderPlot({
    y <- runif(input$bottom_slider)
    x <- 1:input$bottom_slider
    plot(x, y, main = "Random")
    abline(lm(y ~ x))
  })

}

shinyApp(ui, server)