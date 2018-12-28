#' A dataset of benchmark experimental information 
#' 
#' The exps dataset contains public data exported from 
#' the online DICE database (2017 edition) of the NEA. 
#' 
#' The data in this package is re-formatted as an R dataframe 
#' to suit our analyses purposes. For consistency, observation containing NA's 
#' or missing values have been dropped.
#' 
#' @format A data frame with 2527 observations of 36 variables:
#' \describe{
#'   \item{FULLID}{price, in US dollars}
#'   \item{MODEL}{weight of the diamond, in carats}
#'   \item{CASETYPE}{weight of the diamond, in carats}
#'   \item{FISS}{weight of the diamond, in carats}
#'   \item{FORM}{weight of the diamond, in carats}
#'   \item{SPEC}{weight of the diamond, in carats}
#'   \item{EXPVAL}{weight of the diamond, in carats}
#'   \item{EXPERR}{weight of the diamond, in carats}
#'   \item{EALF}{weight of the diamond, in carats}
#'   \item{AFGE}{weight of the diamond, in carats} 
#' }
#' @source The original data from DICE is publicly available online at \url{www.oecd-nea.org/dice}
"exps"

