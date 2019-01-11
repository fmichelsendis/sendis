#' A dataset containing grouped sensitivity data
#' 
#' The sens dataset contains public data exported from 
#' the online DICE database (2017 edition) of the NEA. 
#' 
#' The data in this package is re-formatted as an R dataframe 
#' to suit our analyses purposes. For consistency, observation containing NA's 
#' or missing values have been dropped.
#'
#' @format A data frame with 236128 observations of 7 featuress:
#' \describe{
#'   \item{FULLID}{Benchmark case identification}
#'   \item{ISOTOPE}{Target isotope in reaction concerned}
#'   \item{REACTION}{Reaction or observable}
#'   \item{KSENS1}{1 group sensitivity}
#'   \item{KSENS2}{1 group sensitivity}
#'   \item{KSENS3}{1 group sensitivity}
#'   \item{KSENSTOT}{1 group total sensitivity}
#' }
#' @source The original data from DICE is publicly available online at \url{www.oecd-nea.org/dice}
"sens"
