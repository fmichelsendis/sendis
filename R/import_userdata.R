#' Import csv data file from user and returns a data frame 
#' columns CASETYPE, FISS, FORM, SPEC are reconstructed from column FULLID
#' 
#' @param filename filename in csv format to import.
#' @import data.table
#' @import dplyr
#' @export
#' @examples
#'
#'
#'
import_userdata<- function(filename){

  user_df<-fread(filename)
  user_df$V1<-NULL
  user_df[user_df==""]<-NA
  
  missing<-""
  
  if(!("INST" %in% names(user_df)))   {missing<-paste(missing, "INST")}
  if(!("FULLID" %in% names(user_df))) {missing<-paste(missing, "FULLID")}
  if(!("MODEL" %in% names(user_df)))  {missing<-paste(missing, "MODEL")}
  if(!("CODE" %in% names(user_df)))   {missing<-paste(missing, "CODE")}
  if(!("LIBVER" %in% names(user_df))) {missing<-paste(missing, "LIBVER")}
  if(!("CALCVAL" %in% names(user_df))) {missing<-paste(missing, "CALCVAL")}
  if(!("CALCERR" %in% names(user_df))) {missing<-paste(missing, "CALCERR")} 
  
  
  if(missing==""){
    # user_df$LIBVERA<-user_df$LIBVER
    # user_df<-cSplit(as.data.table(user_df), "LIBVERA", "-")
    # setnames(user_df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
    
    user_df$FULLIDA<-user_df$FULLID
    user_df<-cSplit(as.data.table(user_df), "FULLIDA", "-")
    setnames(user_df, old=c("FULLIDA_1","FULLIDA_2", "FULLIDA_3"), 
             new=c("FISS", "FORM", "SPEC"))
    user_df<-user_df%>%mutate(CASETYPE = paste0(.data$FISS,"-",.data$FORM,"-",
                                                .data$SPEC))
    
    return(
      user_df%>%select("FULLID", "CASETYPE", "FISS", "FORM", "SPEC", "MODEL", "CODE", "LIBVER", "CALCVAL", "CALCERR")
      )
    }
  if(missing!=""){
    error_msg<-paste0(missing, " columns not found")
    stop(error_msg)
  }
   
}
