[![Travis build status](https://travis-ci.org/JohnCoene/pushbar.svg?branch=master)](https://travis-ci.org/JohnCoene/pushbar)

<img src="man/figures/logo.png" align = "right" height = "170px" />

# pushbar

> See [bsutils](github.com/JohnCoene/bsutils) for a Bootstrap 5 built-in.

Brings [pushbar.js](https://oncebot.github.io/pushbar.js/) to Shiny; create off-canvas sliders for inputs, outputs or any other content.

## Installation

Install the stable version (recommended) from CRAN:

```r
install.packages("pushbar")
```

Install the development version with `remotes`

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/pushbar")
```

## How to use

1. Include `pushbar_deps` anywhere in your ui.
2. Include `setup_pushbar` at the top of your server function, it'll also let you determine whether to use `blur` and `overlay` when pushbars are opened.
3. Use `pushbar` in your ui to include content in pushbars. 
4. Use `pushbar_open` and `pushbar_close` to programatically (server-side) open and close the pushbars.

Also includes an event (see example) to capture whether a pushbar is opened (`input$pushbarID_pushbar_opened`).

## Example

[Live Demo](https://shiny.john-coene.com/pushbar)

``` r
library(shiny)
library(pushbar)

ui <- fluidPage(
   pushbar_deps(),
   br(),
   actionButton("open", "Open pushbar"),
   pushbar(
     h4("HELLO"),
     id = "myPushbar", # add id to get event
     actionButton("close", "Close pushbar")
   ),
   fluidRow(
     column(5),
     column(5, span("Is a pushbar opened?"), verbatimTextOutput("ev"))
   )
 )
 
 server <- function(input, output, session){

   setup_pushbar() # setup

   observeEvent(input$open, {
     pushbar_open(id = "myPushbar")
   })  

   observeEvent(input$close, {
     pushbar_close()
   })  

   output$ev <- renderPrint({
     input$myPushbar_pushbar_opened
   })
 }
 
 if(interactive()) shinyApp(ui, server)
```

![](pushbar.gif)

