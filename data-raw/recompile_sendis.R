
recompile_sendis<- function(){
  
  e<-exps%>%select(.data$FULLID, .data$MODEL, .data$EALF, .data$EXPVAL, .data$EXPERR)
  sendis<-merge(calcs, e)%>%build_derived_calcs()%>%build_splitcolumns()
  save(sendis, file = "data/sendis.RData")
}

