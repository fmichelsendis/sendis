#' Wrapper to launch the sendis Shiny app
#' 
#' @export
runApp<- function() {
  appDir <- system.file("shiny", "app", package = "sendis")
  if (appDir == "") {
    stop("Could not find example directory. Try re-installing `mypackage`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}