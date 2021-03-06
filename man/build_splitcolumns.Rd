% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/build_splitcolumns.R
\name{build_splitcolumns}
\alias{build_splitcolumns}
\title{Splits into extra columns}
\usage{
build_splitcolumns(df)
}
\arguments{
\item{df}{dataframe}
}
\description{
This function is responsible for adding extra columns to the dataframe 
passed in argument. Extra columns are built from splitting hyphenated 
information from `LIBVER` and `FULLID` columns. If these columns do not 
exist in the dataframe passed as argument the function will return an error.
}
\details{
Extra columns `LIB` and `VER`, are built by splitting `LIBVER`. 
Extra columns `SHORTID`, `CASETYPE`, `CASE`, `SUBCASE`, `FISS`, `FORM`, `SPEC` are built from `FULLID`.
}
