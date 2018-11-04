#' Returns dataframe df with only common cases specified by inst
#'
#' @param df dataframe to consider (no default),
#' @import data.table
#' @import tidyr
#' @import dplyr
#' @export
return_common_suite<- function(df, inst){
  
  base<-unique(ungroup(df)%>%
    filter(.data$INST==inst)%>%
    select(FULLID, MODEL))
  
  df<-ungroup(df)%>%
    select(-NCASES, -CUMUL, -CHISQ)
 
  d<-merge(
    base,
    df,
    by = c("FULLID", "MODEL"),
    all = FALSE
           )
  return(unique(d))
}
  
  
