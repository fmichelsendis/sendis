#' Imports all csv files
#' 
#' This function imports all csv format files inside specified directory in `path`. 
#' Returns a single data frame of 7 variables with all data, provided the resulting dataframe passes 
#' `check_format_errors()`. 
#'
#' 
#' @param path name of directory with csv files to import. 
#' Defaults to directory 'submissions'. 
#' @import data.table
#' @import dplyr
#' @export 
#'
import_submissions<- function(path="submissions"){
require(data.table)
require(dplyr)

  setwd(path)
  temp<-list.files(pattern = "*.csv")
  myfiles<-lapply(temp, data.table::fread)
  udf<-data.table::rbindlist(myfiles, use.names = TRUE)
  udf$V1<-NULL
  # sendis format eliminates problems of NA's in model by setting Model NA's to 'Only' :
  udf$MODEL[is.na(udf$MODEL)] <- "Only"
  
  udf<-udf%>%mutate_if(is.character,as.factor) #sets strigns to factors 
  sendis::check_format_errors(file = udf, type = "df")
  # reorders columns for easy reading
  udf<-udf%>%select(FULLID,MODEL,CODE,INST,LIBVER,CALCVAL,CALCERR)
  setwd("../")
  return(udf)
}
