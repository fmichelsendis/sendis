#' Adds derived columns
#' 
#' This function returns a dataframe with the following features 
#' (or columns) added to the dataframe passed as an argument (provided it has the 
#' expected format): EALF, AFGE, EXPVAL, EXPERR, COVERE, TOTERR, RESIDUAL, CUMUL, CHISQ. 
#'
#'
#' The argument must be a dataframe in the proper format 
#' describing unequivocally a benchmark result observation. The C/E association is done 
#' on the basis of merging the calculated results data frame 
#' and the experimental results dataframe by the benchmark identification fields (columns) 
#' FULLID and MODEL.
#'  
#' 
#' @param df dataframe to consider (no default),
#' @import data.table
#' @import dplyr
#' @import plotly
#' @import splitstackshape
#' @export
build_derived_calcs<- function(df){
  
 
  if("NCASES" %in% names(df)) {df<-df%>%select(-NCASES)} 
  
  #create a vector for number of cases calculated for each LIBVER
  d<-dplyr::count(ungroup(df), .data$INST, .data$LIBVER)  # d has 3 columns : INST, LIBVER and n
  d$NCASES<-d$n  #change name of computed n to NCASES
  d$n<-NULL
  df2<-merge(df, d, by = c("INST", "LIBVER"))
   
  data(exps)
  e<-exps%>%select(.data$FULLID, .data$MODEL, .data$EALF,  .data$AFGE, .data$EXPVAL, .data$EXPERR)
  df2<-merge(df2, e, by=c("FULLID", "MODEL"))
  
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
