.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "pushbar-assets",
    system.file("assets", package = "pushbar")
  )

  shiny::registerInputHandler("pushbarParse", function(data, ...) {
    data <- jsonlite::fromJSON(jsonlite::toJSON(data, auto_unbox = TRUE))
  }, force = TRUE)
}