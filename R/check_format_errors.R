#' Checks that csv data is in expected format  
#' 
#' @param file name of csv or dataframe to check
#' @param type type of file to check either 'csv' or 'df'
#' @import data.table
#' @import dplyr
#' @export
#' @examples
#'
#'
#'
check_format_errors<- function(file, type="df"){
  
  user_df<-file

  if(type=="csv"){
  user_df<-fread(file)
  user_df$V1<-NULL
  user_df[user_df==""]<-NA
  }
  if(type=="df") user_df<-file
  
  
  missing<-""
  
  if(!("INST" %in% names(user_df)))   {missing<-paste(missing, "INST")}
  if(!("FULLID" %in% names(user_df))) {missing<-paste(missing, "FULLID")}
  if(!("MODEL" %in% names(user_df)))  {missing<-paste(missing, "MODEL")}
  if(!("CODE" %in% names(user_df)))   {missing<-paste(missing, "CODE")}
  if(!("LIBVER" %in% names(user_df))) {missing<-paste(missing, "LIBVER")}
  if(!("CALCVAL" %in% names(user_df))) {missing<-paste(missing, "CALCVAL")}
  if(!("CALCERR" %in% names(user_df))) {missing<-paste(missing, "CALCERR")} 
  
  if(missing!=""){
    error_msg<-paste0(missing, " columns not found")
    stop(error_msg)
  }
  
  if(missing=="") return(0)
  
}
