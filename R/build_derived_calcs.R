#' Computes and adds columns :
#' 
#' Columnds added are : 
#'             
#        * EALF
#'       * EXPVAL
#'       * EXPERR
#'       * COVERE
#'       * RESIDUAL
#'       * CUMUL
#'       * CHISQ 
#'
#' 
#' @param df dataframe to consider (no default),
#' @import data.table
#' @import dplyr
#' @import plotly
#' @import splitstackshape
#' @examples
#' \dontrun{
#' library(sendis)
#' 
#' build_derived_calcs(calcs)
#' 
#' }
#' 
#' @export
build_derived_calcs<- function(df=calcs){
  
 
  if("NCASES" %in% names(df)) {df<-df%>%select(-NCASES)} 
  
  #create a vector for number of cases calculated for each LIBVER
  d<-dplyr::count(ungroup(df), .data$INST, .data$LIBVER)  # d has 3 columns : INST, LIBVER and n
  d$NCASES<-d$n  #change name of computed n to NCASES
  d$n<-NULL
  df2<-merge(df, d, by = c("INST", "LIBVER"))
   
  e<-exps%>%select(.data$FULLID, .data$MODEL, .data$EALF,  .data$AFGE, .data$EXPVAL, .data$EXPERR)
  df2<-merge(df2, e)
  
  df2<-df2%>%group_by(.data$INST, .data$LIBVER)%>%
    mutate(
      COVERE = .data$CALCVAL/.data$EXPVAL,
      TOTERR = sqrt(.data$EXPERR^2 + .data$CALCERR^2),
      RESIDUAL = (.data$CALCVAL-.data$EXPVAL)/ TOTERR, 
      CUMUL= round(cumsum(.data$RESIDUAL^2/NCASES),2),
      CHISQ= round(mean(.data$RESIDUAL^2),2)
      )
  
  return(df2)
} 
