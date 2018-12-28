#' A dataset of benchmark calculations.
#' 
#' The structure of this dataset (7 features per observation) 
#' is the minimal template for calculated results 
#' to be imported into the sendis package.
#' 
#' @name calcs
#' @docType data
#' @usage data(calcs)
#' @format A dataset of calculated results with 13282 observations of 7 variables
#' 
#' \describe{
#'   \item{FULLID}{Full Identifier of Benchmark case and subcase}
#'   \item{MODEL}{Model in case different models exist for same benchmark}
#'   \item{CODE}{Code used for the calculation, can include version number}
#'   \item{INST}{Institute (can also be used to include author of calculations)}
#'   \item{LIBVER}{Library used in calculations, including version number, e.g.: JEFF-3.3}
#'   \item{CALCVAL}{Calculated value of Keff}
#'   \item{CALCERR}{Uncertainty of calculated value (statistical for Monte Carlo)}
#' }
#' @source \url{www.sendis.org}
"calcs"

