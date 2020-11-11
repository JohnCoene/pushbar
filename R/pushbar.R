#' Setup Pushbar
#'
#' Set up pushbar.
#'
#' @param blur Whether to blur the background when pushbar is opened.
#' @param overlay Whether to darken the background when pushbar is opened.
#' @param esc_close Whether to enable pressing `ESC` key to close the pushbar
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
setup_pushbar <- function(blur = FALSE, overlay = TRUE, esc_close = TRUE){
  opts <- list(
    blur = blur,
    overlay = overlay,
    esc = esc_close
  )
  session <- shiny::getDefaultReactiveDomain()
  .check_session(session)
  session$sendCustomMessage("pushbar-setup", opts)
}

#' Pushbar
#'
#' Creates element containing pushbar content.
#'
#' @param id Id of pushbar.
#' @param from Wherefrom the pushbar should open.
#' @param class Additional class to pass to \code{div}.
#' @param style Valid css defaults to \code{\link{pushbar_style}}.
#' @param ... Any other valid \link[shiny]{tags}.
#'
#' @details Creates a \code{div}.
#'
#' @note You are advised to add \code{padding} inside your pushbar i.e.: \code{style="padding:20px;"}
#'
#' @export
pushbar <- function(..., id = from, from = c("left", "right", "top", "bottom"), class = NULL, style = pushbar_style()){

  from <- match.arg(from)

  cl <- paste0("pushbar from_", from, " ", class)

  shiny::div(
    id = id,
    `data-pushbar-id` = id,
    class = cl,
    style = style,
    ...
  )
}

#' Pushbar Buttons
#'
#' Open and close pushbar programatically.
#'
#' @param id Id of pushbar to open.
#'
#' @name pushbar-buttons
#' @export
pushbar_open <- function(id = c("left", "right", "top", "bottom")){
  session <- shiny::getDefaultReactiveDomain()
  .check_session(session)
  session$sendCustomMessage("pushbar-open", id[1])
}

#' @rdname pushbar-buttons
#' @export
pushbar_close <- function(){
  session <- shiny::getDefaultReactiveDomain()
  session$sendCustomMessage("pushbar-close", list())
}

#' Style
#'
#' Default pushbar CSS, used in \code{\link{pushbar}}.
#'
#' @export
pushbar_style <- function(){
  "background:#fff;padding:20px;"
}

.check_session <- function(x){
  if(is.null(x))
    stop("invalid session, run this function inside your Shiny server.")
}
