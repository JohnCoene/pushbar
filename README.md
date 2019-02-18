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
   actionButton("open", "Open pushbar"),
   pushbar(
     h4("HELLO"),
     id = "myPushbar",
     actionButton("close", "Close pushbar")
   ),
   fluidRow(
     column(5),
     column(5, verbatimTextOutput("ev"))
   )
 )
 
 server <- function(input, output, session){

   setup_pushbar(session) # setup

   observeEvent(input$open, {
     pushbar_open(session, id = "myPushbar")
   })  

   observeEvent(input$close, {
     pushbar_close(session)
   })  

   output$ev <- renderPrint({
     input$myPushbar_pushbar_opened
   })
 }
 
 if(interactive()) shinyApp(ui, server)
```

