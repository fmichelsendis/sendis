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
 
  
 
    user_df$LIBVERA<-user_df$LIBVER
    user_df<-cSplit(as.data.table(user_df), "LIBVERA", "-")
    setnames(user_df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
    
    user_df$FULLIDA<-user_df$FULLID
    user_df<-cSplit(as.data.table(user_df), "FULLIDA", "-")
    setnames(user_df, old=c("FULLIDA_1","FULLIDA_2", "FULLIDA_3"), 
             new=c("FISS", "FORM", "SPEC"))
    user_df<-user_df%>%mutate(CASETYPE = paste0(.data$FISS,"-",.data$FORM,"-",
                                                .data$SPEC))
    
    
    
    if(check_format_errors(filename)==0){
      user_df<-fread(filename)
      user_df$V1<-NULL
      user_df[user_df==""]<-NA
      return(user_df%>%
          select(INST, FULLID, MODEL, CODE, LIBVER, CALCVAL, CALCERR))
      }
    
 
}
