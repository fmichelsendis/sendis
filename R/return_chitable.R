#' Returns dataframe with total chi-square values
#'
#' @param df dataframe to consider (no default),
#' @import data.table
#' @import tidyr
#' @import dplyr
#' @export
return_chitable<- function(df){

  chis<-unique(df%>%select(INST, LIBVER, NCASES, CHISQ))%>%
    spread(.data$LIBVER, .data$CHISQ)
  
  return(chis)
}
