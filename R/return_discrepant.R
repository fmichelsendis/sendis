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
m<-merge(inst1, inst2, by = c("FULLID", "FISS", "FORM", "SPEC", "MODEL", "EALF", "LIBVER"))%>%
  select("FULLID", "FISS", "FORM", "SPEC", "MODEL", "EALF", "LIBVER", 
         "CODE.x", "CALCVAL.x", "CALCERR.x", 
         "CODE.y", "CALCVAL.y", "CALCERR.y")%>%
  mutate(
    DELTA_PCM = (.data$CALCVAL.y/.data$CALCVAL.x - 1) *1e+5,
    TOT_STAT_ERR_PCM = sqrt(.data$CALCERR.x^2 + .data$CALCERR.y^2) * 1e+5,
    DELTA_SIGMA_STAT = .data$DELTA_PCM/.data$TOT_STAT_ERR_PCM
         )
return(filter(m, abs(.data$DELTA_SIGMA_STAT)>sigma_treshold))
}

