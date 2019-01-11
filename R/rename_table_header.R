#' Restyle header for sendis-report
#'
#' @param df dataframe to consider (no default),
#' @import dplyr
#' @import data.table  
#' @export
rename_table_header<-function(df){
df<-df%>%
  setnames(old="NCASES",       new="$N_c$")%>%
  setnames(old="ENDFB-VII.1",  new="7.1")%>%
  setnames(old="ENDFB-VIII.b4",new="8.0")%>%
  setnames(old="JEFF-2.2",     new="2.2")%>%
  setnames(old="JEFF-3.0",     new="3.0")%>%
  setnames(old="JEFF-3.1",     new="3.1")%>%
  setnames(old="JEFF-3.1.1",   new="3.1.1")%>%
  setnames(old="JEFF-3.1.2",   new="3.1.2")%>%
  setnames(old="JEFF-3.2",     new="3.2")%>%
  setnames(old="JEFF-3.3",     new="3.3")%>%
  setnames(old="JENDL-4.0",    new="4.0")
  
return(df)
}