.onLoad <- function(libname, pkgname) {
  shiny::addResourcePath(
    "pushbar-assets",
    system.file("assets", package = "pushbar")
  )
}