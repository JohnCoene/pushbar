# pushbar

Brings [pushbar.js](https://oncebot.github.io/pushbar.js/) to Shiny.

## Installation

``` r
# install.packages("remotes")
remotes::install_github("JohnCoene/pushbar")
```

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
   setup_pushbar(session)
   observeEvent(input$open, {
     pushbar_open(session)
   })  
   observeEvent(input$close, {
     pushbar_close(session)
   })  
 }
 
 if(interactive()) shinyApp(ui, server)
```

