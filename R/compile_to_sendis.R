#' Compiles dataframe to sendis format
#' 
#' This function is responsible for adding extra columns to the original 7 variable 
#' dataframe of calculations passed in argument so that it is in the sendis format (24 variables). 
#' 
#' 
#' Warning : using this function will modify the global variable sendis for the session.
#' 
#' @param df dataframe
#' @import data.table
#' @import dplyr
#' @export
#'
compile_to_sendis<- function(df){

#df must be in format of calcs 
err=check_format_errors(df)
  
# build_derived_calcs will merge exps and calcs and compute other columns : 
df<-build_derived_calcs(df)%>%build_splitcolumns()

# Replacing Model "NA" by "Only" if necessary :
df$MODEL[is.na(df$MODEL)] <- "Only"

#Getting rid of all other rows containing NA values
df<-df%>%na.omit()

#Use select to rearrange order of columns, put character columns first
df<-df%>%
  select(
    FULLID,
    SHORTID,
    MODEL,
    CASETYPE,
    FISS,
    FORM,
    SPEC,
    LIBVER,
    LIB,
    VER,
    CODE,
    INST,
    NCASES,
    EALF,
    AFGE,
    EXPVAL,
    EXPERR,
    CALCVAL,
    CALCERR,
    COVERE,
    TOTERR,
    RESIDUAL,
    CUMUL,
    CHISQ
    )

# rbind both sendis and df and modify global sendis : 
rdf<-rbind(sendis, df)%>%unique() 
# return merged df 
return(rdf)
}

