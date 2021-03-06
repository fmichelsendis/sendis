#' A dataset of benchmark results and much more
#' @name sendis
#' @docType data
#' @usage data(sendis)
#' @format A data frame with 12869 observations of 25 variables:
#' \describe{
#'   \item{FULLID}{Full ICSBEP identifier of benchmark evaluation, case and subcase, e.g.: PU-MET-FAST-001-001}
#'   \item{SHORTID}{Abbreviated ICESBEP identifier of benchmark evaluation, case and subcase, e.g.: PMF-1-1}
#'   \item{MODEL}{Model description in case different models exist for same benchmark}
#'   \item{CASETYPE}{Type or family of benchmark case, e.g. : PU-MET-FAST}
#'   \item{FISS}{ICSBEP identifier of fissile material in benchmark, e.g.: HEU, LEU, U233}
#'   \item{FORM}{ICSBEP identifier of material form in benchmark, e.g.: MET, SOL, COMP}
#'   \item{SPEC}{ICSBEP identifier of neutron spectrum category in benchmark, e.g.: THERM, INTER, FAST}
#'   \item{EXPVAL}{Experimental value of benchmark Keff, as reported by DICE}
#'   \item{EXPERR}{Uncertainty associated to the experimental value of benchmark Keff, as reported by DICE}
#'   \item{EALF}{Energy corresponding to the average neutron lethargy causing fission}
#'   \item{AFGE}{Average neutron energy causing fission}
#'   \item{CODE}{Code used for the calculation, can include version number}
#'   \item{INST}{Name of institute (can also be used to include author of calculations) - Important : this field is also used to distinguish different benchmarking suites}
#'   \item{LIBVER}{Library used in calculations, including version number, e.g.: JEFF-3.3}
#'   \item{LIB}{Library used in calculations, e.g.: JEFF, ENDFB}
#'   \item{VER}{Version of library used in calculations, e.g.: 3.1.1, 3.3, 7.1, 8.0}
#'   \item{CALCVAL}{Calculated value of Keff}
#'   \item{CALCERR}{Uncertainty of calculated value (statistical for Monte Carlo)} 
#'   \item{NCASES}{Number of cases in a benchmarking suite } 
#'   \item{COVERE}{CALCVAL / EXPVAL} 
#'   \item{TOTERR}{sqrt(CALCERR^2 + EXPERR^2)} 
#'   \item{RESIDUAL}{(CALCVAL - EXPVAL)/TOTERR}
#'   \item{CUMUL}{Used for cumulative chi-square plots}
#'   \item{CHISQ}{Chi-square value for benchmark suite for a specific INST, e.g. for INST=="NEA", NCASES==123}
#' }
#' @source \url{www.sendis.org}
#' @examples
#' data(sendis)
#' head(sendis)
"sendis"
NULL
