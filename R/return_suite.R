
return_suite<- function(df, inst, libver){
  df2<-df%>%filter(.data$INST==inst, .data$LIBVER==libver)
  return(unique(df2%>%select("FULLID", "MODEL"))) 
    }

return_common_suite<- function(df, libver, inst1, inst2){
 
  d2<-filter(df, INST==inst2, LIBVER==libver)
  
  d<-merge(d2, return_suite(df, inst1, libver))
  return(unique(d))
}
  
  
