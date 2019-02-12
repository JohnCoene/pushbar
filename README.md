[![Travis build status](https://travis-ci.org/JohnCoene/pushbar.svg?branch=master)](https://travis-ci.org/JohnCoene/pushbar)

# pushbar

Brings [pushbar.js](https://oncebot.github.io/pushbar.js/) to Shiny.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/pushbar")
```

## How to use

1. Include `pushbar_deps` anywhere in your ui.
2. Include `setup_pushbar` at the top of your server function.
3. Use `pushbar` to include content in pushbars. 
4. Use `pushbar_open` and `pushbar_close` to programatically open and close the pushbars.

Pass your Shiny session to 3) and 4).

Also includes an event (see example) to capture whether a pushbar is opened.

## Example

### [Demo](https://shiny.john-coene.com/pushbar)

``` r
library(shiny)
library(pushbar)

ui <- fluidPage(
  pushbar_deps(),
  fluidRow(
    column(6, actionButton("open", "Open pushbar")),
    column(6, verbatimTextOutput("isOpened"))
  ),
  pushbar(
    id = "myPushbar", # add id to capture event
    h4("HELLO"),
    actionButton("close", "Close pushbar")
  )
 )
 
 server <- function(input, output, session){

  setup_pushbar(session) # setup

  observeEvent(input$open, {
    pushbar_open(session)
  })  

  observeEvent(input$close, {
    pushbar_close(session)
  })

  output$isOpened <- renderPrint({
    input$myPushbar_pushbar_opened
  })  
 }
 
 if(interactive()) shinyApp(ui, server)
```

