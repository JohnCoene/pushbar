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

## Example

``` r
library(shiny)

ui <- fluidPage(
   pushbar_deps(),
   actionButton("open", "Open pushbar"),
   pushbar(
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
 }
 
 if(interactive()) shinyApp(ui, server)
```

