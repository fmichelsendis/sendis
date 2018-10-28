#' import csv data in sendis format
#'
#' @param file filename of csv file to import (no default). This csv file should follow the sendis format.
#' @export
#' @examples
#' import_csv()


import_csv<- function(file){

  # source data
  df_calcs<-fread(file)
  df_calcs$V1<-NULL
  df_calcs[df_calcs==""]<-NA
  #merging with expdata
  expdata<-fread('data-raw/expdata.csv')
  expdata$V1<-NULL
  df<-merge(expdata, df_calcs, all=FALSE)
  #RE-CREATE missing columns
  df<- df %>% mutate(
    COVERE=CALCVAL/EXPVAL,
    RESIDUAL = (CALCVAL-EXPVAL)/sqrt(EXPERR^2 + CALCERR^2))
  df$LIBVERA<-df$LIBVER
  df<-cSplit(as.data.table(df), "LIBVERA", "-")
  setnames(df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
  #tidy up
  df<-df%>%arrange(INST, LIBVER, CASETYPE)

  return(df)
}

