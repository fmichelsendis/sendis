% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sens-data.R
\docType{data}
\name{sens}
\alias{sens}
\title{A dataset containing grouped sensitivity data}
\format{A data frame with 236128 observations of 7 featuress:
\describe{
  \item{FULLID}{Benchmark case identification}
  \item{ISOTOPE}{Target isotope in reaction concerned}
  \item{REACTION}{Reaction or observable}
  \item{KSENS1}{1 group sensitivity}
  \item{KSENS2}{1 group sensitivity}
  \item{KSENS3}{1 group sensitivity}
  \item{KSENSTOT}{1 group total sensitivity}
}}
\source{
The original data from DICE is publicly available online at \url{www.oecd-nea.org/dice}
}
\usage{
sens
}
\description{
The sens dataset contains public data exported from 
the online DICE database (2017 edition) of the NEA.
}
\details{
The data in this package is re-formatted as an R dataframe 
to suit our analyses purposes. For consistency, observation containing NA's 
or missing values have been dropped.
}
\keyword{datasets}
