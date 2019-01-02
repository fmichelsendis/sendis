#' Splits into extra columns
#' 
#' This function is responsible for adding extra columns to the dataframe 
#' passed in argument. Extra columns are built from splitting hyphenated 
#' information from `LIBVER` and `FULLID` columns. If these columns do not 
#' exist in the dataframe passed as argument the function will return an error. 
#' 
#' 
#'  
#' Extra columns `LIB` and `VER`, are built by splitting `LIBVER`. 
#' Extra columns `SHORTID`, `CASETYPE`, `CASE`, `SUBCASE`, `FISS`, `FORM`, `SPEC` are built from `FULLID`.  
#' 
#' @section YAML config - home:
#' 
#' @param df dataframe
#' @import data.table
#' @import dplyr
#' @export
#'
build_splitcolumns<- function(df){
 
    check_format_errors(df)
  
    
    df$LIBVERA<-df$LIBVER
    df<-cSplit(as.data.table(df), "LIBVERA", "-")
    setnames(df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
    
    df$FULLIDA<-df$FULLID
    df<-cSplit(as.data.table(df), "FULLIDA", "-")
    setnames(df, old=c("FULLIDA_1","FULLIDA_2", "FULLIDA_3", "FULLIDA_4", "FULLIDA_5"), 
             new=c("FISS", "FORM", "SPEC", "CASE", "SUBCASE"))
    #df$FULLIDA_4<-df$FULLIDA_5<-NULL
    df<-df%>%mutate(CASETYPE = paste0(.data$FISS,"-",.data$FORM,"-",.data$SPEC),
                    SHORTID = paste0(substring(.data$FISS, 1, 1),
                                     substring(.data$FORM, 1, 1),
                                     substring(.data$SPEC, 1, 1),"-",
                                     .data$CASE,"-",.data$SUBCASE)
                      
                    )
  return(df)
}
