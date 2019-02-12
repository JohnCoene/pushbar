#' Setup Pushbar
#'
#' Set up pushbar.
#'
#' @param blur Whether to blur the background when pushbar is opened.
#' @param overlay Whether to darken the background when pushbar is opened.
#' @param session A valid Shiny session.
#' 
#' @examples
#' library(shiny)
#'
#' ui <- fluidPage(
#'   pushbar_deps(),
#'   actionButton("open", "Open pushbar"),
#'   pushbar(
#'     h4("HELLO")
#'   )
#' )
#' 
#' server <- function(input, output, session){
#'
#'   setup_pushbar()
#'  
#'   observeEvent(input$open, {
#'     pushbar_open()
#'   })  
#' }
#' 
#' if(interactive()) shinyApp(ui, server)
#' 
#' @importFrom shiny tags
#' @name pushbar
#' @export
pushbar_deps <- function() {

  shiny::singleton(
    tags$head(
      tags$link(
        href = "pushbar-assets/pushbar.css",
        rel="stylesheet",
        type="text/css"
      ),
      tags$script(
        src = "pushbar-assets/pushbar.js"
      ),
      tags$script(
        src = "pushbar-assets/custom.js"
      )
    )
  )
}

#' @rdname pushbar
#' @export
setup_pushbar <- function(session, blur = FALSE, overlay = TRUE){
  opts <- list(
    blur = blur,
    overlay = overlay
  )
  session$sendCustomMessage("pushbar-setup", opts)
}

#' Pushbar
#' 
#' Creates element containing pushbar content.
#' 
#' @param from Wherefrom the pushbar should open.
#' @param class Additional class to pass to \code{div}.
#' @param ... Any other valid \link[shiny]{tags}.
#' 
#' @details Creates a \code{div} with id \code{pushbar} + \code{from}, i.e.: \code{pushbarLeft} (default).
#' 
#' @export
pushbar <- function(..., from = c("left", "right", "top", "bottom"), class = NULL){

  from <- match.arg(from)

  cl <- paste0("pushbar from_", from, " ", class)
  id <- .make_id(from)

  shiny::div(
    `data-pushbar-id` = id,
    class = cl,
    ...
  )
}

#' Pushbar Buttons
#' 
#' Open and close pushbar programatically.
#' 
#' @param from The pushbar side to open.
#' @param session A valid Shiny session.
#' 
#' @name pushbar-buttons
#' @export
pushbar_open <- function(session, from = c("left", "right", "top", "bottom")){
  from <- match.arg(from)
  id <- .make_id(from)
  session$sendCustomMessage("pushbar-open", id)
}

#' @rdname pushbar-buttons
#' @export
pushbar_close <- function(session){
  session$sendCustomMessage("pushbar-close", list())
}