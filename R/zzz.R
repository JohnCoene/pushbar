.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "pushbar-assets",
    system.file("assets", package = "pushbar")
  )

  shiny::registerInputHandler("pushbarParse", function(data, ...) {
    data <- jsonlite::fromJSON(jsonlite::toJSON(data, auto_unbox = TRUE))

    if(is.null(data))
      return(FALSE)
    else
      return(data)
  }, force = TRUE)
}