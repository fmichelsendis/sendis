#' Return a dataframe of common calculated benchmarks between two 
#' institutions and filter them according to their difference. 
#' @param df  dataframe to explore (no default).
#' @param INST1  (no default),
#' @param INST2  (no default),
#' @param sigma_treshold  (no default),
#' @import dplyr
#' @export
return_discrepant<- function(df, INST1, INST2, sigma_treshold = 0){

inst1<-filter(df, .data$INST==INST1)
inst2<-filter(df, .data$INST==INST2)
m<-merge(inst1, inst2, by = c("FULLID", "SHORTID", "MODEL", "EALF", "LIBVER"))%>%
  select("SHORTID", "FULLID", "MODEL", "EALF", "LIBVER", 
         "CODE.x", "CALCVAL.x", "CALCERR.x", 
         "CODE.y", "CALCVAL.y", "CALCERR.y")%>%
  mutate(
    DELTA_PCM = round((.data$CALCVAL.y/.data$CALCVAL.x - 1) *1e+5,0),
    TOT_STAT_ERR_PCM = round(sqrt(.data$CALCERR.x^2 + .data$CALCERR.y^2) * 1e+5,0),
    DELTA_SIGMA_STAT = round(.data$DELTA_PCM/.data$TOT_STAT_ERR_PCM, 1)
         )
return(filter(m, abs(.data$DELTA_SIGMA_STAT)>sigma_treshold))
}

