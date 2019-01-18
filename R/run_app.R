#' Wrapper to launch the sendis Shiny app
#' 
#' @export
runSendis<- function() {
  appDir <- system.file("shiny", "app", package = "sendis")
  if (appDir == "") {
    stop("Could not find app directory. Try re-installing `sendis`.", call. = FALSE)
  }
  
  shiny::runApp(appDir, display.mode = "normal", launch.browser = TRUE)
}