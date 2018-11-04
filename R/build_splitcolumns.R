#' Returns a data frame 
#' with extra columns : LIB, VER, CASETYPE, FISS, FORM, SPEC 
#' 
#' @param df dataframe
#' @import data.table
#' @import dplyr
#' @export
#' @examples
#'
#'
#'
build_splitcolumns<- function(df){
 
    check_format_errors(df)
  
    
    df$LIBVERA<-df$LIBVER
    df<-cSplit(as.data.table(df), "LIBVERA", "-")
    setnames(df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
    
    df$FULLIDA<-df$FULLID
    df<-cSplit(as.data.table(df), "FULLIDA", "-")
    setnames(df, old=c("FULLIDA_1","FULLIDA_2", "FULLIDA_3"), 
             new=c("FISS", "FORM", "SPEC"))
    df$FULLIDA_4<-df$FULLIDA_5<-NULL
    df<-df%>%mutate(CASETYPE = paste0(.data$FISS,"-",.data$FORM,"-",
                                                .data$SPEC))
    
  return(df)
 
}
