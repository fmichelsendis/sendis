
recompile_sendis<- function(){

# build_derived_calcs will merge exps and calcs and compute other columns : 
sendis<-build_derived_calcs(calcs)%>%build_splitcolumns()

# Replacing Model "NA" by "Only" - This is now useless : 
# sendis$MODEL[is.na(sendis$MODEL)] <- "Only"

#Getting rid of all other rows containing NA values
sendis<-sendis%>%na.omit()

#Use select to rearrange order of columns, put character columns first
sendis<-sendis%>%
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


save(sendis, file = "data/sendis.RData")
  
}

